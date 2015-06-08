//
//  YHEMKNetworkEngine.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHEMKNetworkEngine.h"
#import "YHNetworkUserAgent.h"
//#import "YHELoginUser.h"
#import "MKNetworkEngine.h"


static NSMutableSet *_allOperations;


@interface YHEMKNetworkEngine ()

@property (nonatomic, strong) NSMutableArray *reachabilityChangedHandlers;

@end


@implementation YHEMKNetworkEngine


+ (void)initialize {
    if(_allOperations == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _allOperations = [[NSMutableSet alloc] init];
        });
    }
}


- (NSString *)cacheDirectoryName
{
    NSString *s = [super cacheDirectoryName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:s]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:s withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return s;
}


- (void)enqueueOperation:(MKNetworkOperation *)operation
{
    [super enqueueOperation:operation];
    [_allOperations addObject:operation];
}


+ (id)standardEngine
{
    static YHEMKNetworkEngine *engine_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine_ = [[YHEMKNetworkEngine alloc] initWithHostName:kHostName
                                                     apiPath:kApiPath
                                          customHeaderFields:@{@"User-Agent": [YHNetworkUserAgent userAgent]}];
        [engine_ registerOperationSubclass:[YHENetworkOperation class]];
    });
    return engine_;
}



+ (id)thirdPartyNetworkEngineWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath
{
    YHEMKNetworkEngine *engine = [[YHEMKNetworkEngine alloc] initWithHostName:hostName
                                                                  apiPath:apiPath
                                                       customHeaderFields:nil];
    [engine registerOperationSubclass:[YHENetworkOperation class]];
    return engine;
}


+ (instancetype)videoDownloadEngine
{
    static YHEMKNetworkEngine *engine_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine_ = [[YHEMKNetworkEngine alloc] initWithHostName:nil
                                                     apiPath:nil
                                          customHeaderFields:nil];
        [engine_ registerOperationSubclass:[YHENetworkOperation class]];
    });
    return engine_;
}


+ (instancetype)gifFrameDownloadEngine
{
    static YHEMKNetworkEngine *engine_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine_ = [[YHEMKNetworkEngine alloc] initWithHostName:nil
                                                     apiPath:nil
                                          customHeaderFields:nil];
        [engine_ registerOperationSubclass:[YHENetworkOperation class]];
    });
    return engine_;
}

+ (void)cancelOperationsFrom:(id)requester
{
    yoho_dispatch_execute_in_main_queue(^{
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if (![evaluatedObject isKindOfClass:[YHENetworkOperation class]]) {
                return NO;
            }
            
            YHENetworkOperation *operation = (YHENetworkOperation *)evaluatedObject;
            if (operation.requester == requester) {
                return YES;
            }
            return NO;
        }];
        
        NSSet *operationsToCancel = [_allOperations filteredSetUsingPredicate:predicate];
        [operationsToCancel enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            YHENetworkOperation *operation = (YHENetworkOperation *)obj;
            [operation cancel];
        }];
        [_allOperations minusSet:operationsToCancel];
    });
}


+ (void)removeOperation:(YHENetworkOperation *)operation
{
    yoho_dispatch_execute_in_main_queue(^{
        [_allOperations removeObject:operation];
    });
}


- (void (^)(NetworkStatus))reachabilityChangedHandler
{
    void (^handler)(NetworkStatus networkStatus) = ^(NetworkStatus networkStatus) {
        for (void (^aHandler)(NetworkStatus ns) in self.reachabilityChangedHandlers) {
            aHandler(networkStatus);
        }
    };
    return handler;
}


- (void)addReachabilityChangedHandler:(void (^)(NetworkStatus networkStatus))reachabilityChangedHandler
{
    if (!self.reachabilityChangedHandlers) {
        self.reachabilityChangedHandlers = [NSMutableArray array];
    }
    [self.reachabilityChangedHandlers addObject:[reachabilityChangedHandler copy]];
}


- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler
{
    [self postWithAPI:api
           parameters:parameters
                files:nil
                 from:requester
     succeededHandler:succeededHandler
        failedHandler:failedHandler];
}


- (void)getWithAPI:(NSString *)api
        parameters:(NSDictionary *)parameters
              from:(id)requester
  succeededHandler:(void (^)(id responseObject))succeededHandler
     failedHandler:(void (^)(NSError *error))failedHandler
{
    NSMutableDictionary *actualParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    int platformID = kUserInterfaceIdiomIsPhone?2:3;
    [actualParameters setObject:[NSString stringWithFormat:@"%d", platformID] forKey:@"platform"];
    YHENetworkOperation *operation = (YHENetworkOperation *)[self operationWithPath:api
                                                                             params:@{@"parameters": actualParameters}
                                                                         httpMethod:@"GET"];
    operation.requester = requester;
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        YHENetworkOperation *o = (YHENetworkOperation *)completedOperation;
        succeededHandler([o responseObject]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        failedHandler(error);
    }];
    
    [self enqueueOperation:operation];
}


- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
              files:(NSDictionary *)files
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler
{
    NSMutableDictionary *actualParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    int platformID = kUserInterfaceIdiomIsPhone?2:3;
    [actualParameters setObject:[NSString stringWithFormat:@"%d", platformID] forKey:@"platform"];
    
    NSString *localIdentifier = [[NSLocale currentLocale] localeIdentifier];
    [actualParameters setObject:localIdentifier forKey:@"locale"];
    
    NSString *prefferedLanguage = [NSLocale preferredLanguages][0];
    [actualParameters setObject:prefferedLanguage forKey:@"language"];
    
//    YHELoginUser *currentUser = [YHELoginUser currentLoginUser];
//    if (currentUser) {
//        NSDictionary *authorizationInfo = @{@"uid": [currentUser userID], @"sessionCode": [currentUser sessionCode]};
//        [actualParameters setObject:authorizationInfo forKey:@"authInfo"];
//    }

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:actualParameters options:0 error:&error];
    if (error) {
        YHLogError(@"json parsing", @"connot convert to json for: %@\n code: %d\n reason: %@", actualParameters, [error code], [error localizedDescription]);
    }
#ifdef IS_TEST
    NSLog(@"\n request url \n%@/%@/%@ \n pars \n%@", self.readonlyHostName, self.apiPath, api, [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
#endif
    YHENetworkOperation *operation = (YHENetworkOperation *)[self operationWithPath:api
                                                                             params:@{@"parameters": [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]}
                                                                         httpMethod:@"POST"];
    if (files) {
        for (NSString *key in files) {
            NSString *mimeType = @"multipart/form-data";
            if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"jpg"]) {
                mimeType = @"image/jpg";
            }
            else if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"m4a"]) {
                mimeType = @"audio/m4a";
            }
            else if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"mp4"]) {
                mimeType = @"video/mp4";
            }
            [operation addFile:files[key] forKey:key mimeType:mimeType];
        }
    }
    operation.requester = requester;
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#ifdef IS_TEST
        NSLog(@"completedOperation %@", completedOperation);
#endif
        YHENetworkOperation *o = (YHENetworkOperation *)completedOperation;
        succeededHandler([o responseObject]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        failedHandler(error);
    }];
    [self enqueueOperation:operation];
}

- (void)postWithAPIStack:(NSString *)api
         parameters:(NSDictionary *)parameters
              files:(NSDictionary *)files
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler
{
    NSMutableDictionary *actualParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    int platformID = kUserInterfaceIdiomIsPhone?2:3;
    [actualParameters setObject:[NSString stringWithFormat:@"%d", platformID] forKey:@"platform"];
    
    NSString *localIdentifier = [[NSLocale currentLocale] localeIdentifier];
    [actualParameters setObject:localIdentifier forKey:@"locale"];
    
    NSString *prefferedLanguage = [NSLocale preferredLanguages][0];
    [actualParameters setObject:prefferedLanguage forKey:@"language"];
    
//    YHELoginUser *currentUser = [YHELoginUser currentLoginUser];
//    if (currentUser) {
//        NSDictionary *authorizationInfo = @{@"uid": [currentUser userID], @"sessionCode": [currentUser sessionCode]};
//        [actualParameters setObject:authorizationInfo forKey:@"authInfo"];
//    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:actualParameters options:0 error:&error];
    if (error) {
        YHLogError(@"json parsing", @"connot convert to json for: %@\n code: %d\n reason: %@", actualParameters, [error code], [error localizedDescription]);
    }
    
    YHENetworkOperation *operation = (YHENetworkOperation *)[self operationWithPath:api
                                                                             params:@{@"parameters": [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]}
                                                                         httpMethod:@"POST"];
    if (files) {
        for (NSString *key in files) {
            NSString *mimeType = @"multipart/form-data";
            if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"jpg"]) {
                mimeType = @"image/jpg";
            }
            else if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"m4a"]) {
                mimeType = @"audio/m4a";
            }
            else if ([[[files[key] pathExtension] lowercaseString] isEqualToString:@"mp4"]) {
                mimeType = @"video/mp4";
            }
            [operation addFile:files[key] forKey:key mimeType:mimeType];
        }
    }
    
    [operation setFreezable:YES];
    

    operation.requester = requester;

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        YHENetworkOperation *o = (YHENetworkOperation *)completedOperation;
        succeededHandler([o responseObject]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        failedHandler(error);
    }];
    [self enqueueOperation:operation];
}


@end

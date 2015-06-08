//
//  YHENetworkEngine.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHENetworkEngine.h"
#import "YHNetworkUserAgent.h"


static NSMutableSet         *_allOperations;
static dispatch_queue_t     _squeue;
NSMutableArray              *_reachabilityChangedHandlers;
AFNetworkReachabilityStatus _currentNetworkStatus;

@implementation YHENetworkEngine
{
    NSString                    *_hostName;
    NSString                    *_apiPath;
    NSMutableDictionary         *_customHeaders;
}

+ (void)initialize
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _allOperations = [[NSMutableSet alloc] init];
        _squeue = dispatch_queue_create("show.network.engine.squeue", 0);
        
            //监听网络状态
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
            _currentNetworkStatus = status;
            
            for (int i = 0; i < [_reachabilityChangedHandlers count]; i++)
            {
                void (^aHandler)(NetworkStatus ns) = [_reachabilityChangedHandlers objectAtIndex:i];
                
                NetworkStatus ns = ReachableViaWiFi;
                switch (status)
                {
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    default:
                        ns = ReachableViaWiFi;
                        break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                        ns = ReachableViaWWAN;
                        break;
                    case AFNetworkReachabilityStatusNotReachable:
                        ns = NotReachable;
                        break;
                }
                aHandler(ns);
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
            //默认有网络
        _currentNetworkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
        _reachabilityChangedHandlers = [NSMutableArray array];
    });
}

#pragma mark - 实现init系列方法 为了与之前用法的兼容

- (id)init
{
    return [self initWithHostName:nil apiPath:nil customHeaderFields:nil];
}

- (id)initWithHostName:(NSString *)hostName
{
    return [self initWithHostName:hostName apiPath:nil customHeaderFields:nil];
}

- (id)initWithHostName:(NSString*)hostName customHeaderFields:(NSDictionary*)headers
{
    return [self initWithHostName:hostName apiPath:nil customHeaderFields:headers];
}

- (id)initWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath customHeaderFields:(NSDictionary *)headers
{
    if((self = [super init]))
    {
        _hostName = hostName;
        _apiPath = apiPath;
        
        if(headers && !headers[@"User-Agent"])
        {
            NSMutableDictionary *newHeadersDict = [headers mutableCopy];
            NSString *userAgentString = [NSString stringWithFormat:@"%@/%@",
                                         [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey],
                                         [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey]];
            newHeadersDict[@"User-Agent"] = userAgentString;
            _customHeaders = newHeadersDict;
        }
        else
        {
            _customHeaders = [headers mutableCopy];
        }
        
        if (!_customHeaders)
        {
            _customHeaders = [NSMutableDictionary dictionary];
        }
    }
    
    return self;
}
#pragma mark - 实现init系列方法 为了与之前用法的兼容

- (NSString *)apiUrlStr:(NSString *)api
{
    NSMutableString *apiUrl = [NSMutableString stringWithString:@""];
    if (_hostName && _hostName.length)
    {
        [apiUrl appendFormat:@"%@%@", _hostName, (_apiPath.length) ? @"/" : @""];
    }
    if (_apiPath && _apiPath.length)
    {
        [apiUrl appendFormat:@"%@%@", _apiPath, (api.length) ? @"/" : @""];
    }
    if (api && api.length)
    {
        [apiUrl appendFormat:@"%@", api];
    }
    
    if (apiUrl.length < 1 || ![apiUrl hasPrefix:@"http"])
    {
        NSLog(@"ERROR YHENetworkEngine: 接口请求的URL不正确: %@", apiUrl);
        NSLog(@"调用堆栈 %@", [NSThread callStackSymbols]);
        return nil;
    }
    return apiUrl;
}

    //为了兼容
- (BOOL)isReachable
{
        //有网络时_currentNetworkStatus枚举值大于0
    return _currentNetworkStatus > AFNetworkReachabilityStatusNotReachable;
}

- (BOOL)isReachableWifi
{
    return _currentNetworkStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

- (void)enqueueOperation:(AFHTTPRequestOperation *)operation
{
    dispatch_sync(_squeue, ^{
        
        [_allOperations addObject:operation];
    });
}

- (void)pauseAllOperation
{
    dispatch_sync(_squeue, ^{
        NSLog(@"pauseAllOperation current Operation is %d",(int)_allOperations.count);
        [_allOperations makeObjectsPerformSelector:@selector(pause)];
    });
}

- (void)resumeAllOperation
{
    dispatch_sync(_squeue, ^{
        NSLog(@"resumeAllOperation current Operation is %d",(int)_allOperations.count);
        [_allOperations makeObjectsPerformSelector:@selector(resume)];
    });
}

+ (instancetype)standardEngine
{
    static YHENetworkEngine *engine_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine_ = [[YHENetworkEngine alloc] initWithHostName:[NSString stringWithFormat:@"http://%@", kHostName]
                                                     apiPath:kApiPath
                                          customHeaderFields:@{@"User-Agent": [YHNetworkUserAgent userAgent]}];
    });
    return engine_;
}



+ (instancetype)thirdPartyNetworkEngineWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath
{
    YHENetworkEngine *engine = [[YHENetworkEngine alloc] initWithHostName:hostName
                                                                  apiPath:apiPath
                                                       customHeaderFields:nil];
    return engine;
}

+ (void)cancelOperationsFrom:(id)requester
{
    dispatch_sync(_squeue, ^{
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
        {
                //AFHTTPRequestOperation
            if (![evaluatedObject isKindOfClass:[AFHTTPRequestOperation class]])
            {
                return NO;
            }
            
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)evaluatedObject;
            if (operation.identifier == requester) {
                return YES;
            }
            return NO;
        }];
        
        NSSet *operationsToCancel = [_allOperations filteredSetUsingPredicate:predicate];
        [operationsToCancel enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
        {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)obj;
            [operation cancel];
        }];
        [_allOperations minusSet:operationsToCancel];
    });
}

+ (void)removeOperation:(AFHTTPRequestOperation *)operation
{
    dispatch_sync(_squeue, ^{
        [_allOperations removeObject:operation];
//        NSLog(@"_allOperations count %d", [_allOperations count]);
    });
}

- (void)addReachabilityChangedHandler:(void (^)(NetworkStatus networkStatus))reachabilityChangedHandler
{
    dispatch_sync(_squeue, ^{
        
        [_reachabilityChangedHandlers addObject:[reachabilityChangedHandler copy]];
    });
}


- (void)getWithAPI:(NSString *)api parameters:(NSDictionary *)parameters from:(id)requester
  succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    NSMutableDictionary *actualParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *platform = kUserInterfaceIdiomIsPhone ? @"2" : @"3";
    [actualParameters setObject:platform forKey:@"platform"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *requestOperation = [manager GET:[self apiUrlStr:api] parameters:actualParameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (succeededHandler)
        {
            [self operationSucceeded:operation responseObject:responseObject succeededHandler:succeededHandler failedHandler:failedHandler];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
        [YHENetworkEngine removeOperation:operation];
        if (failedHandler)
        {
            failedHandler(error);
        }
    }];
    
    requestOperation.identifier = requester;
    [self enqueueOperation:requestOperation];
}

- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    [self postWithAPI:api parameters:parameters files:nil from:requester succeededHandler:succeededHandler failedHandler:failedHandler];
}


- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters files:(NSDictionary *)files from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    [self postWithAPI:api parameters:parameters files:files from:(id)requester progressHandler:nil succeededHandler:succeededHandler failedHandler:failedHandler];
}

- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters files:(NSDictionary *)files from:(id)requester progressHandler:(void (^)(float progress))progressBlock succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler
{
    NSMutableDictionary *actualParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSString *platform = kUserInterfaceIdiomIsPhone ? @"2" : @"3";
    [actualParameters setObject:platform forKey:@"platform"];
    
    NSString *localIdentifier = [[NSLocale currentLocale] localeIdentifier];
    [actualParameters setObject:localIdentifier forKey:@"locale"];
    
    NSString *prefferedLanguage = [NSLocale preferredLanguages][0];
    [actualParameters setObject:prefferedLanguage forKey:@"language"];
    
//    YHELoginUser *currentUser = [YHELoginUser currentLoginUser];
//    if (currentUser)
//    {
//        NSDictionary *authorizationInfo = @{@"uid": kSafeValue([currentUser userID]), @"sessionCode": kSafeValue([currentUser sessionCode])};
//        [actualParameters setObject:authorizationInfo forKey:@"authInfo"];
//    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:actualParameters options:0 error:&error];
    if (error)
    {
        YHLogError(@"json parsing", @"connot convert to json for: %@\n code: %d\n reason: %@", actualParameters, [error code], [error localizedDescription]);
        if (failedHandler)
        {
            failedHandler(error);
        }
        return;
    }
    
    if (![self apiUrlStr:api])
    {
        if (failedHandler)
        {
            failedHandler(error);
        }
        return;
    }
    
    
    NSString *parsJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *requestOperation = nil;
    NSDictionary *pars = @{@"parameters": kSafeValue(parsJsonStr)};
    if (files && [files count])
    {
        requestOperation = [manager POST:[self apiUrlStr:api] parameters:pars constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                            {
                                for (NSString *key in files)
                                {
                                    NSURL *filePath = [NSURL fileURLWithPath:files[key]];
                                    [formData appendPartWithFileURL:filePath name:key error:nil];
                                }
                            }
                                 success:^(AFHTTPRequestOperation *operation, id responseObject)
                            {
                                if (succeededHandler)
                                {
                                    [self operationSucceeded:operation responseObject:responseObject succeededHandler:succeededHandler failedHandler:failedHandler];
                                }
                            }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
                            {
#ifdef IS_TEST
                                
                                NSString *parsJsonStr = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                                parsJsonStr = [parsJsonStr urlDecodedString];
                                NSLog(@"\nrequest url \n%@\n pars \n%@", operation.request.URL, parsJsonStr);
                                NSLog(@"接口请求出错 Error: %@", error);
#endif
                                [YHENetworkEngine removeOperation:operation];
                                if (failedHandler)
                                {
                                    failedHandler(error);
                                }
                            }];
    }
    else
    {
        requestOperation = [manager POST:[self apiUrlStr:api] parameters:pars success:^(AFHTTPRequestOperation *operation, id responseObject)
                            {
                                if (succeededHandler)
                                {
                                    [self operationSucceeded:operation responseObject:responseObject succeededHandler:succeededHandler failedHandler:failedHandler];
                                }
                            }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
                            {
#ifdef IS_TEST
                                
                                NSString *parsJsonStr = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                                parsJsonStr = [parsJsonStr urlDecodedString];
                                NSLog(@"\nrequest url \n%@\n pars \n%@", operation.request.URL, parsJsonStr);
                                NSLog(@"接口请求出错 Error: %@", error);
#endif
                                [YHENetworkEngine removeOperation:operation];
                                if (failedHandler)
                                {
                                    failedHandler(error);
                                }
                            }];
    }
    [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progressBlock) {
            CGFloat progress = 0.0f;
            if (totalBytesExpectedToWrite!=0) {
                progress = ((CGFloat)totalBytesWritten)/((CGFloat)totalBytesExpectedToWrite);
            }
            progressBlock(progress);
        }
    }];
    requestOperation.identifier = requester;
    [self enqueueOperation:requestOperation];
}


- (void)downloadFile:(NSString *)urlAddress localPath:(NSString *)localPath from:(id)requester progressBlock:(void (^)(float progress))progressBlock
    succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    [self downloadFile:urlAddress localPath:localPath fileStream:YES from:requester progressBlock:progressBlock succeededHandler:succeededHandler failedHandler:failedHandler];
}

//fileStream表示是否使用文件流的形式写文件(如果使用流方式则文件可能存在但数据不全)
- (void)downloadFile:(NSString *)urlAddress localPath:(NSString *)localPath fileStream:(BOOL)isFileStream from:(id)requester progressBlock:(void (^)(float progress))progressBlock
    succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    if(isFileStream)
    {
        requestOperation.outputStream = [NSOutputStream outputStreamToFileAtPath:localPath append:NO];
    }
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        
         [YHENetworkEngine removeOperation:operation];
         if (succeededHandler)
         {
             succeededHandler(responseObject);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [YHENetworkEngine removeOperation:operation];
        NSLog(@"Error: %@", error);
        if (failedHandler)
        {
            failedHandler(error);
        }
    }];
    
    [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        //NSLog(@"Download = %f", (float)totalBytesRead / totalBytesExpectedToRead);
        if (progressBlock)
        {
            progressBlock((float)totalBytesRead / totalBytesExpectedToRead);
        }
    }];
    
    [requestOperation start];
    requestOperation.identifier = requester;
    [self enqueueOperation:requestOperation];
}

#pragma mark - 成功请求后统一解析数据  从YHENetworkOperation.m中copy的处理逻辑

- (void)operationSucceeded:(AFHTTPRequestOperation *)operation responseObject:(NSDictionary *)responseObject
          succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler
{
    [YHENetworkEngine removeOperation:operation];
    
#ifdef IS_TEST
    
    NSString *parsJsonStr = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
    parsJsonStr = [parsJsonStr urlDecodedString];
    NSLog(@"\nrequest url \n%@\n pars \n%@", operation.request.URL, parsJsonStr);
    NSLog(@"Success: %@", responseObject);
#endif
    
    if (![responseObject isKindOfClass:[NSDictionary class]])
    {
        succeededHandler(responseObject);
        return;
    }
    
    NSInteger responseStatus = 0;
    if ([responseObject.allKeys containsObject:@"status"])
    {
        responseStatus = [[responseObject objectForKey:@"status"] integerValue];
    }
    
    if (responseStatus != 0 )
    {
        NSInteger responseCode = 0;
        if ([responseObject.allKeys containsObject:@"code"])
        {
            responseCode = [[responseObject objectForKey:@"code"] integerValue];
        }
        NSString *localizedDescription = [responseObject objectForKey:@"message"];
        
        NSDictionary* dataDic = [responseObject objectForKey:@"data"];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:localizedDescription, NSLocalizedDescriptionKey, kSafeValue(dataDic), @"data", nil];
        NSError *error = [NSError errorWithDomain:YHEAPIErrorDomain code:responseCode userInfo:userInfo];
        
        if (failedHandler)
        {
            failedHandler(error);
        }
    }
    else
    {
        NSDictionary *responseJSON = [responseObject objectForKey:@"data"];
        
        if([responseJSON isKindOfClass:[NSArray class]] && 0 == [(NSArray*)responseJSON count])
        {
            responseJSON = nil;
        }
        
        succeededHandler(responseJSON);
    }
}



    //该接口是独立于应用服务器接口封装外的单独用于第三方接口请求(比如支付宝登录接口)
- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters responseContentType:(NSString *)responeContentType encoding:(NSStringEncoding)encoding succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler
{
    AFHTTPRequestOperationManager *manager      = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                  = [AFHTTPResponseSerializer serializer];
    if (responeContentType)
    {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:responeContentType];//设置相应内容类型
    }
    AFHTTPRequestOperation *requestOperation    = [manager POST:api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
                        {
                            if (succeededHandler)
                            {
                                succeededHandler(responseObject);
                            }
                        }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
                        {
#ifdef IS_TEST
                            NSString *parsJsonStr = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                            parsJsonStr = [parsJsonStr urlDecodedString];
                            NSLog(@"\nrequest url \n%@\n pars \n%@", operation.request.URL, parsJsonStr);
                            NSLog(@"接口请求出错 Error: %@", error);
#endif
                            if (failedHandler)
                            {
                                failedHandler(error);
                            }
                        }];
    [self enqueueOperation:requestOperation];
}


    //该接口是独立于应用服务器接口封装外的单独用于第三方接口请求
- (void)getWithAPI:(NSString *)url parameters:(NSDictionary *)parameters responseContentType:(NSString *)responeContentType succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler
{
    AFHTTPRequestOperationManager *manager      = [AFHTTPRequestOperationManager manager];
        //    manager.responseSerializer                  = [AFHTTPResponseSerializer serializer];
    if (responeContentType)
    {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:responeContentType];//设置相应内容类型
    }
    AFHTTPRequestOperation *requestOperation    = [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                   {
                                                       NSLog(@"operation %@", operation);
                                                       if (succeededHandler)
                                                       {
                                                           succeededHandler(responseObject);
                                                       }
                                                   }
                                                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                   {
#ifdef IS_TEST
                                                       NSString *parsJsonStr = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                                                       parsJsonStr = [parsJsonStr urlDecodedString];
                                                       NSLog(@"\nrequest url \n%@\n pars \n%@", operation.request.URL, parsJsonStr);
                                                       NSLog(@"接口请求出错 Error: %@", error);
#endif
                                                       if (failedHandler)
                                                       {
                                                           failedHandler(error);
                                                       }
                                                   }];
        //超时时间20秒
    ((NSMutableURLRequest *)requestOperation.request).timeoutInterval = 20;
    [self enqueueOperation:requestOperation];
}


@end











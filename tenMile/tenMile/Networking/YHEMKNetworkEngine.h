//
//  YHENetworkEngine.h
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "YHENetworkOperation.h"

@interface YHEMKNetworkEngine : MKNetworkEngine

+ (id)standardEngine;
+ (id)thirdPartyNetworkEngineWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath;
+ (instancetype)videoDownloadEngine;
+ (instancetype)gifFrameDownloadEngine;

+ (void)cancelOperationsFrom:(id)requester;
+ (void)removeOperation:(YHENetworkOperation *)operation;

- (void)addReachabilityChangedHandler:(void (^)(NetworkStatus networkStatus))reachabilityChangedHandler;

- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler;

- (void)getWithAPI:(NSString *)api
        parameters:(NSDictionary *)parameters
              from:(id)requester
  succeededHandler:(void (^)(id responseObject))succeededHandler
     failedHandler:(void (^)(NSError *error))failedHandler DEPRECATED_ATTRIBUTE;

- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
              files:(NSDictionary *)files
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler;

- (void)postWithAPIStack:(NSString *)api
         parameters:(NSDictionary *)parameters
              files:(NSDictionary *)files
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler;


@end

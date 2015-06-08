//
//  YHENetworkEngine.h
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "AFNetworking.h"


@interface YHENetworkEngine : NSObject

+ (id)standardEngine;

- (id)initWithHostName:(NSString *)hostName;

- (id)initWithHostName:(NSString *)hostName customHeaderFields:(NSDictionary *)headers;

- (id)initWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath customHeaderFields:(NSDictionary *)headers;
    //将会删除它
+ (id)thirdPartyNetworkEngineWithHostName:(NSString *)hostName apiPath:(NSString *)apiPath;

- (BOOL)isReachable;

- (BOOL)isReachableWifi;

- (void)enqueueOperation:(AFHTTPRequestOperation *)operation;

- (void)pauseAllOperation;

- (void)resumeAllOperation;

+ (void)cancelOperationsFrom:(id)requester;

+ (void)removeOperation:(AFHTTPRequestOperation *)operation;

- (void)addReachabilityChangedHandler:(void (^)(NetworkStatus networkStatus))reachabilityChangedHandler;

- (void)getWithAPI:(NSString *)api
        parameters:(NSDictionary *)parameters
              from:(id)requester
  succeededHandler:(void (^)(id responseObject))succeededHandler
     failedHandler:(void (^)(NSError *error))failedHandler;

- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler;

- (void)postWithAPI:(NSString *)api
         parameters:(NSDictionary *)parameters
              files:(NSDictionary *)files
               from:(id)requester
   succeededHandler:(void (^)(id responseObject))succeededHandler
      failedHandler:(void (^)(NSError *error))failedHandler;

- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters files:(NSDictionary *)files from:(id)requester progressHandler:(void (^)(float progress))progressBlock succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler;


- (void)downloadFile:(NSString *)urlAddress localPath:(NSString *)localPath from:(id)requester progressBlock:(void (^)(float progress))progressBlock
    succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler;

//fileStream:表示是否使用文件流的形式写文件(如果使用流方式则文件可能存在但数据不全)
- (void)downloadFile:(NSString *)urlAddress localPath:(NSString *)localPath fileStream:(BOOL)isFileStream  from:(id)requester progressBlock:(void (^)(float progress))progressBlock
    succeededHandler:(void (^)(id responseObject))succeededHandler failedHandler:(void (^)(NSError *error))failedHandler;



- (void)postWithAPI:(NSString *)api parameters:(NSDictionary *)parameters responseContentType:(NSString *)responeContentType encoding:(NSStringEncoding)encoding succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler;

- (void)getWithAPI:(NSString *)url parameters:(NSDictionary *)parameters responseContentType:(NSString *)responeContentType succeededHandler:(void (^)(id))succeededHandler failedHandler:(void (^)(NSError *))failedHandler;


@end

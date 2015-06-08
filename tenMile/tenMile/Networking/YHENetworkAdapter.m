//
//  YHENetworkAdapter.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHENetworkAdapter.h"


@implementation YHENetworkAdapter


- (id)init
{
    self = [super init];
    if (self != nil)
    {
#ifdef USE_AFNETWORKING
        self.standardEngine = [YHENetworkEngine standardEngine];
        self.videoEngine    = [[YHENetworkEngine alloc] initWithHostName:nil
                                                                 apiPath:nil
                                                      customHeaderFields:nil];
        self.imageEngine = [[YHENetworkEngine alloc] initWithHostName:nil
                                                                 apiPath:nil
                                                      customHeaderFields:nil];
#else
        self.standardEngine = [YHEMKNetworkEngine standardEngine];
        self.videoEngine    = [YHEMKNetworkEngine videoDownloadEngine];
        self.imageEngine = [YHEMKNetworkEngine gifFrameDownloadEngine];
#endif
    }
    return self;
}


+ (YHENetworkAdapter *)adapter
{
    SHARED_INSTANCE_USING_BLOCK(^{
        return [[YHENetworkAdapter alloc] init];
    });
}


+ (BOOL)isReachable
{
    return [[[YHENetworkAdapter adapter] standardEngine] isReachable];
}

+ (BOOL)isReachableWifi
{
    return [[[YHENetworkAdapter adapter] standardEngine] isReachableWifi];
}

- (void)cancelOperationsFrom:(id)requester
{
#ifdef USE_AFNETWORKING
    
    [YHENetworkEngine cancelOperationsFrom:requester];
#else
    
    [YHEMKNetworkEngine cancelOperationsFrom:requester];
#endif
}


@end

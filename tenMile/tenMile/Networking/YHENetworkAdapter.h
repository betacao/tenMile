//
//  YHENetworkAdapter.h
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef USE_AFNETWORKING

    #import "YHENetworkEngine.h"
    @interface YHENetworkAdapter : NSObject

    @property (nonatomic, strong) YHENetworkEngine *standardEngine;
    @property (nonatomic, strong) YHENetworkEngine *videoEngine;
    @property (nonatomic, strong) YHENetworkEngine *imageEngine;
    + (YHENetworkAdapter *)adapter;
    + (BOOL)isReachable;
    + (BOOL)isReachableWifi;
    - (void)cancelOperationsFrom:(id)requester;

    @end

#else

    #import "YHEMKNetworkEngine.h"
    @interface YHENetworkAdapter : NSObject

    @property (nonatomic, strong) YHEMKNetworkEngine *standardEngine;
    @property (nonatomic, strong) YHEMKNetworkEngine *videoEngine;
    @property (nonatomic, strong) YHEMKNetworkEngine *gifFrameEngine;
    + (YHENetworkAdapter *)adapter;
    + (BOOL)isReachable;
    + (BOOL)isReachableWifi;
    - (void)cancelOperationsFrom:(id)requester;

    @end

#endif
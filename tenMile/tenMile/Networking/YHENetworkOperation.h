//
//  YHENetworkOperation.h
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "MKNetworkOperation.h"


@interface YHENetworkOperation : MKNetworkOperation

@property (nonatomic, weak) id requester;
@property (nonatomic, strong) id responseJSON;

- (BOOL)isStandardYohoCnOperation;
- (id)responseObject;

@end

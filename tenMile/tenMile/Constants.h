//
//  Constants.h
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#ifndef tenMile_Constants_h
#define tenMile_Constants_h

static NSString * const YHEAPIErrorDomain = @"YHEAPIErrorDomain";

typedef NS_ENUM(NSInteger, YHEErrorCode) {
    YHEErrorCodeSuccess,
};

#define SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


#define kHostName @""

#define kApiPath @""

#define kSafeValue(X)                       (!(X) ? [NSNull null] : (X))

#define kScreenScale                ([UIScreen instancesRespondToSelector:@selector(scale)]?[[UIScreen mainScreen] scale]:(1.0f))

#define kUserInterfaceIdiomIsRetina ([[UIScreen mainScreen] scale] >= 2.0)

#define kScreenIs4InchRetina        (kUserInterfaceIdiomIsRetina && ([UIScreen mainScreen].bounds.size.height == 568.0f))

#define kScreenIsnot35              ([[UIScreen mainScreen] bounds].size.height > 480)

#define kUserInterfaceIdiomIsPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kScreenWidth                ([[UIScreen mainScreen] bounds].size.width)

#define kScreenHeight                ([[UIScreen mainScreen] bounds].size.height)

#define kStatusBarMaxY              CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame])

#define kNavigationBarHeight        44.0f

#define kSearchBarHeight            44.0f

#define kEmailRegularExpression                     @".+@.+\\..+"

#define kStoreKeyPhotoQuality       @"photoQuality"

#define kSystemVersion              [[UIDevice currentDevice] systemVersion]

#define kSystemVersionPriorToIOS6   ([kSystemVersion compare:@"6.0" options:NSNumericSearch range:NSMakeRange(0, 3)] == NSOrderedAscending)

#define kSystemVersionPriorToIOS7   ([kSystemVersion compare:@"7.0" options:NSNumericSearch range:NSMakeRange(0, 3)] == NSOrderedAscending)

#define kSystemVersionPriorToIOS8   ([kSystemVersion compare:@"8.0" options:NSNumericSearch range:NSMakeRange(0, 3)] == NSOrderedAscending)

#define kSystemVersionReachesIOS7   ([kSystemVersion compare:@"7.0" options:NSNumericSearch range:NSMakeRange(0, 3)] != NSOrderedAscending)

//高于7.1系统判断
#define kSystemVersionReachesIOS71   ([kSystemVersion compare:@"7.1" options:NSNumericSearch range:NSMakeRange(0, 3)] != NSOrderedAscending)

#define kSystemVersionReachesIOS8   ([kSystemVersion compare:@"8.0" options:NSNumericSearch range:NSMakeRange(0, 3)] != NSOrderedAscending)


#endif

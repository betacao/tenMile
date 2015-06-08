//
//  YHNetworkUserAgent.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-20.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHNetworkUserAgent.h"
#import "OpenUDID.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>


#define kUDIDMD5Suffix      @"yohoeeohoy"


@interface YHNetworkUserAgent ()

+ (NSString *)openUDID;
+ (NSString *)md5UDID;
+ (NSString *)timeZone;
+ (NSString *)devicePlatform;
+ (NSString *)deviceModel;
+ (NSString *)screenResolution;
+ (NSString *)operatingSystemNameAndVersion;
+ (NSString *)applicationNameAndVersion;
+ (NSString *)timestamp;
+ (NSString *)userAgent;

@end


@implementation YHNetworkUserAgent

+ (NSString *)openUDID
{
    return [OpenUDID value];
}


+ (NSString *)md5UDID
{
    NSDictionary *suffixDictionary = @{@"cn.yoho.efashion" : @"yohoidffdiohoy", @"cn.yoho.e" : @"yohoeeohoy", @"cn.yoho.girl" : @"yohogirllrigohoy", @"cn.yoho.show" : @"showwohs"};
    NSString *bundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey];
    NSString *suffix = suffixDictionary[bundleIdentifier];
    
    const char *cStr = [[NSString stringWithFormat:@"%@_%@_%@", [self openUDID], [self timestamp], suffix] UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSString *)timeZone
{
    NSTimeZone *SystemTimeZone = [NSTimeZone systemTimeZone];
    NSInteger hoursFromGMT = SystemTimeZone.secondsFromGMT / 60 / 60;
    NSString *timeZoneName = (hoursFromGMT > 0) ? [NSString stringWithFormat:@"+%ld",(long)hoursFromGMT] : [NSString stringWithFormat:@"%ld",(long)hoursFromGMT];
    return timeZoneName;
}


+ (NSString *)devicePlatform
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}


+ (NSString *)deviceModel
{
    NSString *platform = [self devicePlatform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone(GSM)";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G(GSM)";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS(GSM)";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4(GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4(CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S(GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5(GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5(GSM+CDMA)";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod touch 1st generation";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod touch 2nd generation";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod touch 3rd generation";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod touch 4th generation";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod touch 5th generation";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2(WIFI)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2(GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2(CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3rd generation(WIFI)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3rd generation(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3rd generation(GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4th generation(WIFI)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4th generation(GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4th generation(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini(WIFI)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini(GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini(GSM+CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}


+ (NSString *)screenResolution
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    return [NSString stringWithFormat:@"%ldx%ld",(long)(rect.size.width * scale), (long)(rect.size.height * scale)];
}


+ (NSString *)operatingSystemNameAndVersion
{
    return [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
}


+ (NSString *)applicationNameAndVersion
{
    NSDictionary *appNameDict = @{@"cn.yoho.efashion" : @"YOHO!E-fashion", @"cn.yoho.e" : @"YOHO!E", @"cn.yoho.girl" : @"YOHO!Girl", @"cn.yoho.show" : @"SHOW"};
    NSString *appName = appNameDict[[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey]] ? appNameDict[[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey]] : appNameDict[[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]];
    return [NSString stringWithFormat:@"%@ %@", appName, [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]];
}


+ (NSString *)timestamp
{
    long long now = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)now;
    return  [NSString stringWithFormat:@"%lld", date];
}



+ (NSString *)userAgent
{
    return  [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",[self openUDID], [self timestamp], [self md5UDID], [self deviceModel], [self screenResolution], [self operatingSystemNameAndVersion], [self applicationNameAndVersion], [self timeZone]];
}


@end

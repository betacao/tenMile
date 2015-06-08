//
//  ObjLoginUser.h
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjLoginUser : NSObject

//// 机制和yohobuy一样，当前如果没登录返回nil
//+ (ObjLoginUser *)currentLoginUser;
//// 上次登录的用户，如果没有登录过则返回nil
//+ (ObjLoginUser *)lastLoginUser;
//// 启动时调用，开始自动登录等工作
//+ (void)start;
//- (void)loginFrom:(id)requester succeededBlock:(void(^)())succeededBlock failedBlock:(YHENetworkFailedBlock)failedBlock;
//- (void)logOut;
//// 对currentLoginUser修改密码头像之后，调用存储一下
//- (void)store;
//
//
//+ (void)userLoginAndDisplayRecommendVC:(ObjLoginUser *)userInfo succeededBlock:(void(^)())succeededBlock failedBlock:(YHENetworkFailedBlock)failedBlock;
//
//
//
//// 共通
//@property (nonatomic, copy) NSString *userID;
//@property (nonatomic, copy) NSString *sessionCode;
//@property (nonatomic, copy) NSString *avatar;
//@property (nonatomic) NSInteger unreadMessageCount;
//@property (nonatomic) BOOL isLoggedOut;
//@property (nonatomic, getter = isSyncSinaWeibo) BOOL syncSinaWeibo;
//@property (nonatomic, getter = isSyncTencentWeibo) BOOL syncTencentWeibo;
//@property (nonatomic) BOOL syncQq;
//@property (nonatomic) BOOL syncFacebook;
//// 普通用户
//@property (nonatomic, copy) NSString *loginName;
//@property (nonatomic, copy) NSString *password;
//@property (nonatomic, copy) NSString *nickname;
//@property (nonatomic, copy) NSString *mail;
//@property (nonatomic, copy) NSString *mobile;
//// 联合登录用户,associateLoginInfo两种登录完全不同，干脆直接写成字典，键值可直接用在登录接口上
//@property (nonatomic, strong) NSDictionary  *associateLoginInfo;
//@property (nonatomic) BOOL onceLogged;
//@property (nonatomic) YHEGender gender;
//@property (nonatomic, strong) NSString *location;
///**
// *  因为app登录后再启动不请求网络,所以个人信息不会更新,这个字段用于保证启动后刷新个人的信息状态
// */
//@property (nonatomic, strong) YHEPersonal *personalInfo;
@end

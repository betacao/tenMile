//
//  YHEProgressHUD.h
//  YOHOE
//
//  Created by YOHO on 14/12/1.
//  Copyright (c) 2014年 NewPower Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHEProgressHUD : UIView

@property (assign, nonatomic) BOOL shouldAutoMediate;

- (void)stopAnimation;

- (CGSize)YHEProgressHUDSize;

@end

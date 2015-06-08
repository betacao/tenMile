//
//  YHEProgressHUD.m
//  YOHOE
//
//  Created by YOHO on 14/12/1.
//  Copyright (c) 2014年 NewPower Co. All rights reserved.
//

#import "YHEProgressHUD.h"
#define kDEFAULT_ANIMATIONDURATION 0.3

@interface YHEProgressHUD()

@property (strong, nonatomic) CALayer *imageLayer;
@property (strong, nonatomic) CALayer *activityLayer;
@property (strong, nonatomic) CALayer *maskLayer;

@end

@implementation YHEProgressHUD


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _maskLayer = [CALayer layer];
        UIImage *image = [UIImage imageNamed:@"loading_icon_bg"];
        [_maskLayer setContentsGravity: kCAGravityResizeAspect];
        [_maskLayer setContents: (id)image.CGImage];
        [[self layer] addSublayer:_maskLayer];
        
        image = [UIImage imageNamed:@"loading_icon_page_white"];
        _imageLayer = [CALayer layer];
        [_imageLayer setContentsGravity: kCAGravityResizeAspect];
        [_imageLayer setContents: (id)image.CGImage];
        [[self layer] addSublayer:_imageLayer];
        
        _activityLayer = [CALayer layer];
        image = [UIImage imageNamed:@"loading_icon_ringline_white"];
        [_activityLayer setContentsGravity: kCAGravityResizeAspect];
        [_activityLayer setContents: (id)image.CGImage];
        [[self layer] addSublayer:_activityLayer];
        
        self.shouldAutoMediate = YES;
        [self startAnimation];
    }
    return self;
}

#pragma mark -
#pragma mark animationMethod

- (void)startAnimation {
    if(![self.activityLayer animationForKey:@"transform"]) {
        CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform" ];
        [animation setFromValue: [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        //圍繞z軸旋轉，垂直螢幕
        [animation setToValue: [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2.0f, 0.0f, 0.0f, 1.0f)]];
        [animation setDuration: kDEFAULT_ANIMATIONDURATION];
        //旋轉效果累計，先轉180度，接著再旋轉180度，從而實現360度旋轉
        [animation setCumulative: YES];
        [animation setRepeatCount:NSIntegerMax];
        [animation setDelegate:self];
        [animation setRemovedOnCompletion: NO];
        [self.activityLayer addAnimation:animation forKey:@"transform"];
    }
}

- (void)stopAnimation {
    if([self.activityLayer animationForKey:@"transform"]) {
        [self.activityLayer removeAnimationForKey:@"transform"];
    }
}

- (void)layoutSubviews {
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    UIImage *image = [UIImage imageNamed:@"loading_icon_ringline_white"];
    CGSize ringSize = image.size;
    image = [UIImage imageNamed:@"loading_icon_page_white"];
    CGSize imageSize = image.size;
    image = [UIImage imageNamed:@"loading_icon_bg"];
    CGSize maskSize = image.size;
    //以最大的图片大小 作为self的frame大小
    CGSize maxSize = (ringSize.width >= imageSize.width ? ringSize : imageSize);
    maxSize = (maxSize.width >= maskSize.width ? maxSize : maskSize);
    
    //self的frame计算
    
    CGRect selfFrame = CGRectInset(bounds, (CGRectGetWidth(bounds) - maxSize.width)/2.0f, (CGRectGetHeight(bounds) - maxSize.height)/2.0f);
    selfFrame = [self.window convertRect:selfFrame toView:self.superview];
    if(self.shouldAutoMediate){
        [self setFrame:selfFrame];
    }
    //转圈的frame计算
    CGRect ringFrame = CGRectInset(self.bounds, (CGRectGetWidth(selfFrame)-ringSize.width)/2.0f, (CGRectGetHeight(selfFrame)-ringSize.height)/2.0f);
    [self.activityLayer setFrame:ringFrame];
    //中间show图片的frame计算
    CGRect imageFrame = CGRectInset(self.bounds, (CGRectGetWidth(selfFrame)-imageSize.width)/2.0f, (CGRectGetHeight(selfFrame)-imageSize.height)/2.0f);
    [self.imageLayer setFrame:imageFrame];
    
    CGRect maskFrame = CGRectInset(self.bounds, (CGRectGetWidth(selfFrame)-maskSize.width)/2.0f, (CGRectGetHeight(selfFrame)-maskSize.height)/2.0f);
    
    [self.maskLayer setFrame:maskFrame];
}

- (CGSize)YHEProgressHUDSize
{
    UIImage *image = [UIImage imageNamed:@"loading_icon_ringline_white"];
    CGSize ringSize = image.size;
    image = [UIImage imageNamed:@"loading_icon_page_white"];
    CGSize imageSize = image.size;
    image = [UIImage imageNamed:@"loading_icon_bg"];
    CGSize maskSize = image.size;
    //以最大的图片大小 作为self的frame大小
    CGSize maxSize = (ringSize.width >= imageSize.width ? ringSize : imageSize);
    maxSize = (maxSize.width >= maskSize.width ? maxSize : maskSize);
    return maxSize;
}

- (void)dealloc {
    self.activityLayer = nil;
    self.imageLayer = nil;
}

@end

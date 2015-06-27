//
//  ObjSegmentView.h
//  tenMile
//
//  Created by changxicao on 15/6/27.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ObjSegmentViewDelegate <NSObject>

// 首页调用 需要实现这个代理方法
// 三个按钮的index 分别为0，1，2
- (void)ObjSegmentDidSelectAtIndex:(NSInteger)index;

@end


@interface ObjSegmentView : UIView
{
    UIView *lineView;   //下面的横线
    UIButton *clickedButton;
    NSArray *_titleArr;
    NSMutableArray *_btnArr;
}

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,assign) NSUInteger selectedIndex;
@property (nonatomic,assign) id<ObjSegmentViewDelegate> delegate;
@end
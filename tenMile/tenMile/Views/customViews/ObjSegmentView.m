//
//  ObjSegmentView.m
//  tenMile
//
//  Created by changxicao on 15/6/27.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjSegmentView.h"

@interface ObjSegmentView ()

@property (nonatomic,strong) UIButton *totalBtn;

@property (nonatomic,strong) UIButton *followBtn;

@property (nonatomic,strong) UIButton *focusBtn;

@end

@implementation ObjSegmentView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    // Initialization code
    _btnArr = [[NSMutableArray alloc] initWithCapacity:0];
    lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0099bb"];
    [self addSubview:lineView];
}

- (void)setTitleArr:(NSArray *)titleArr
{
    [_btnArr removeAllObjects];
    CGFloat btnWidth = CGRectGetWidth(self.frame)/titleArr.count;
    for (NSInteger i = 0; i<titleArr.count; i++) {
        NSString *title = titleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"b6b6b6"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0099bb"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHexString:@"0099bb"] forState:UIControlStateSelected];
        [btn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, CGRectGetHeight(self.frame))];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {[btn setSelected:YES];}
        [_btnArr addObject:btn];
    }
    
    CGFloat lineWidth = 0.7125*btnWidth;
    CGFloat originX = (btnWidth - lineWidth)/2;
    [lineView setFrame:CGRectMake(originX, CGRectGetHeight(self.frame)-2, lineWidth, 2)];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex >= _btnArr.count) {  return;  }
    _selectedIndex = selectedIndex;
    UIButton *btn = _btnArr[selectedIndex];
    [self buttonDidClick:btn];
}

- (void)buttonDidClick:(UIButton *)button
{
    if (button.selected) {return;}
    for (UIButton *btn in _btnArr) {
        if (btn != button) {
            [btn setSelected:NO];
        }
    }
    
    [button setSelected:YES];
    _selectedIndex = [_btnArr indexOfObject:button];
    
    CGPoint lineViewCenter = lineView.center;
    lineViewCenter.x = CGRectGetMidX(button.frame);
    
    [UIView animateWithDuration:0.1 animations:^
     {
         [lineView setCenter:lineViewCenter];
     }];
    
    if(delegate && [delegate respondsToSelector:@selector(ObjSegmentDidSelectAtIndex:)])
    {
        [delegate ObjSegmentDidSelectAtIndex:_selectedIndex];
    }
}

@end

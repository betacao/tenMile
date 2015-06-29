//
//  ObjBoardView.m
//  tenMile
//
//  Created by 邢亚鑫 on 15/6/29.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjBoardView.h"

@implementation ObjBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.0;
        self.layer.borderColor = [UIColor colorWithHexString:@"e6e8e8"].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)awakeFromNib{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.layer.borderColor = [UIColor colorWithHexString:@"e6e8e8"].CGColor;
    self.layer.borderWidth = 1;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

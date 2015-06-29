//
//  ObjMyOrderCell.m
//  tenMile
//
//  Created by 邢亚鑫 on 15/6/29.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjMyOrderCell.h"

@implementation ObjMyOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSArray *)data{
    self.orderNumLab = data[0];
    self.orderTimeLab = data[1];
    self.orderStatusLab = data[2];
    self.orderMethodLab = data[3];
}
@end

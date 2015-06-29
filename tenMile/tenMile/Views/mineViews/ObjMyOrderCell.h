//
//  ObjMyOrderCell.h
//  tenMile
//
//  Created by 邢亚鑫 on 15/6/29.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjMyOrderCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *orderNumLab;
@property (nonatomic, weak) IBOutlet UILabel *orderTimeLab;
@property (nonatomic, weak) IBOutlet UILabel *orderStatusLab;
@property (nonatomic, weak) IBOutlet UILabel *orderMethodLab;
@property (nonatomic, weak) IBOutlet UIButton *orderDetailBtn;

- (void)setData:(NSArray *)data;

@end

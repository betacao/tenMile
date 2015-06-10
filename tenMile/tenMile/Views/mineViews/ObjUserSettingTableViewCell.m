//
//  ObjUserSettingTableViewCell.m
//  tenMile
//
//  Created by changxicao on 15/6/10.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjUserSettingTableViewCell.h"

@interface ObjUserSettingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end

@implementation ObjUserSettingTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"808181"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateCellWithDictionary:(NSDictionary *)dictionary
{
    if(dictionary){
        if([dictionary objectForKey:@"title"]) {
            [self.titleLabel setText:[dictionary objectForKey:@"title"]];
        }
    }
}

@end

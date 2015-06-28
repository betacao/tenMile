//
//  ObjShopRecommendViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/28.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjShopRecommendViewController.h"
#import "ObjShopRecommendViewCell.h"
@interface ObjShopRecommendViewController ()

@end

@implementation ObjShopRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名店推荐";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 288.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"ObjShopRecommendViewCell";
    ObjShopRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjShopRecommendViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

@end

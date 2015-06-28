//
//  ObjTimeShoppingViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/28.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjTimeShoppingViewController.h"
#import "ObjTimeShoppingTableViewCell.h"

@interface ObjTimeShoppingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ObjTimeShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时抢购";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static  NSString  *CellIdentiferId = @"ObjTimeShoppingTableViewHeader";
    ObjTimeShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjTimeShoppingTableViewCell" owner:nil options:nil];
        cell = [nibs firstObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"ObjTimeShoppingTableViewCell";
    ObjTimeShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjTimeShoppingTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

@end

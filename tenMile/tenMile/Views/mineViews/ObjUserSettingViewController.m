//
//  ObjUserSettingViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjUserSettingViewController.h"
#import "ObjUserSettingTableViewCell.h"
#import "ObjMyOrderViewController.h"

@interface ObjUserSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic)     IBOutlet UIButton *orderButton;
@property (weak, nonatomic)     IBOutlet UIButton *myStoreButton;
@property (weak, nonatomic)     IBOutlet UIButton *publishButton;
@property (weak, nonatomic)     IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic)     IBOutlet UIImageView *headerView;
@property (weak, nonatomic)     IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic)     IBOutlet UITableView *myTableView;
@property (strong,nonatomic)    NSArray *titleArray;

@end

@implementation ObjUserSettingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.titleArray = @[@"我的订单",@"我的店铺",@"我的发布",@"我的优惠",@"店铺收藏",@"客服电话"];
    
    self.headerView.layer.masksToBounds = YES;
    self.headerView.layer.cornerRadius = CGRectGetHeight(self.headerView.frame) / 2.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"usersettingIdntfier";
    static BOOL nibsRegistered = NO;
    if(!nibsRegistered){
        UINib *nib = [UINib nibWithNibName:@"ObjUserSettingTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
    }
    ObjUserSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell updateCellWithDictionary:@{@"title":self.titleArray[indexPath.row]}];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ObjMyOrderViewController *controller = [[ObjMyOrderViewController alloc] initWithNibName:@"ObjMyOrderViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

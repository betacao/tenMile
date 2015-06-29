//
//  ObjMyOrderViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/10.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjMyOrderViewController.h"
#import "ObjSegmentView.h"
#import "ObjMyOrderCell.h"
#import "ObjMyOrderDetailViewController.h"

@interface ObjMyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ObjMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    self.dataArray = @[@"4号订单",@"2015.6.22 5:33",@"商家未确认",@"正在处理"];
    ObjSegmentView *segmentView = [[ObjSegmentView alloc] initWithFrame:CGRectMake(0.0f, kNavigationBarHeight + kStatusBarMaxY, kScreenWidth, 35.0f)];
    segmentView.titleArr = @[@"未付款订单",@"已付款订单",@"待退款订单"];
    [self.view addSubview:segmentView];
    
    [self.tableView reloadData];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:headView.frame];
    titleLab.backgroundColor = [UIColor colorWithHexString:@"e4e5e6"];
    titleLab.text = @"  订单编号   下单时间   订单状态   处理方式   订单详情";
    titleLab.font = [UIFont systemFontOfSize:13];
    [headView addSubview:titleLab];
    self.tableView.tableHeaderView = headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"ObjMyOrderCell";
    ObjMyOrderCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjMyOrderCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setData:self.dataArray];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ObjMyOrderDetailViewController *controller = [[ObjMyOrderDetailViewController alloc] initWithNibName:@"ObjMyOrderDetailViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

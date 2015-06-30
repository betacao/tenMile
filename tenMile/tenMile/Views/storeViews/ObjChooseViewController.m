//
//  ObjChooseViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/29.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjChooseViewController.h"
#import "ObjChooseTableViewCell.h"

@interface ObjChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *chooseTableView;

@end

@implementation ObjChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选购";
    UIButton *button = [UIButton buttonWithImageName:@"返回" highlightedImageName:@"返回" title:nil target:self action:@selector(popViewController)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjChooseViewController" owner:self options:nil];

    ObjChooseLeftView *leftView = [nibs objectAtIndex:1];
    CGRect frame = leftView.frame;
    frame.origin.x = 0.0f;
    frame.origin.y = kNavigationBarHeight + kStatusBarMaxY;
    leftView.frame = frame;
    [self.view addSubview:leftView];
    
    ObjChooseTopView *topView = [nibs objectAtIndex:2];
    frame = topView.frame;
    frame.origin.x = CGRectGetMaxX(leftView.frame);
    frame.origin.y = kNavigationBarHeight + kStatusBarMaxY;
    topView.frame = frame;
    [self.view addSubview:topView];
    
    ObjChooseBottomView *bottomView = [nibs objectAtIndex:3];
    frame = bottomView.frame;
    frame.origin.y = CGRectGetMaxY(self.chooseTableView.frame) - CGRectGetHeight(frame);
    
    bottomView.frame = frame;
    [self.view addSubview:bottomView];
    
    
}

- (void)popViewController
{
    [self dismissModalViewControllerWithAnimation];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"ObjChooseTableViewCell";
    ObjChooseTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjChooseTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

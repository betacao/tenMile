//
//  ObjHomeViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjHomeViewController.h"

@interface ObjHomeViewController ()<UISearchBarDelegate>

@end

@implementation ObjHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //切换地址
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setFrame:CGRectMake(0, 21, 30, 25)];
    [locationBtn setTitle:@"南京" forState:UIControlStateNormal];
    [locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //个人中心
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setFrame:CGRectMake(0, 24, 16, 16)];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"用户"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:userBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 21, 220, 30)];
    titleView.backgroundColor = [UIColor clearColor];
    UISearchBar *searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 215, 37)];
    searBar.exclusiveTouch = YES;
    searBar.backgroundImage = [UIImage patternImageWithColor:[UIColor clearColor]];
    searBar.delegate = self;
    searBar.placeholder = @"输入关键字";
    [titleView addSubview:searBar];
    
    self.navigationItem.titleView = titleView;


}

- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 700)];
    
}

- (void)gotoUserCenter{
    
}
- (void)changeCity{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

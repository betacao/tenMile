//
//  ObjTabbarController.m
//  tenMile
//
//  Created by changxicao on 15/6/27.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjTabbarController.h"
#import "ObjHomeViewController.h"
#import "ObjNavigationViewController.h"
#import "ObjUserSettingViewController.h"
#import "ObjStoresViewController.h"
#import "ObjCartViewController.h"

@interface ObjTabbarController ()

@end

@implementation ObjTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithImageName:@"返回" highlightedImageName:@"返回" title:nil target:self action:@selector(popViewController)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //商城
    ObjStoresViewController *storesViewController = [[ObjStoresViewController alloc] initWithNibName:@"ObjStoresViewController" bundle:nil];
    
    //购物车
    ObjCartViewController *cartViewController = [[ObjCartViewController alloc] initWithNibName:@"ObjCartViewController" bundle:nil];
    
    //个人中心
    ObjUserSettingViewController *settingViewController = [[ObjUserSettingViewController alloc] initWithNibName:@"ObjUserSettingViewController" bundle:nil];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"选购" image:[UIImage imageNamed:@"选购--常态"] selectedImage:[UIImage imageNamed:@"选购--常态"]];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车--常态"] selectedImage:[UIImage imageNamed:@"购物车--常态"]];
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"个人信息" image:[UIImage imageNamed:@"个人中心-常态"] selectedImage:[UIImage imageNamed:@"个人中心-常态"]];
    

    storesViewController.tabBarItem = item2;
    cartViewController.tabBarItem = item3;
    settingViewController.tabBarItem = item4;
    
    [self setViewControllers:@[storesViewController,cartViewController,settingViewController] animated:NO];
    self.selectedViewController = settingViewController;
    
}


- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    if(index == 0){
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

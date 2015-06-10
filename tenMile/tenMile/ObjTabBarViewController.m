//
//  ObjTabBarViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjTabBarViewController.h"
#import "ObjHomeViewController.h"
#import "ObjNavigationViewController.h"

@interface ObjTabBarViewController ()<UITabBarDelegate>

@property (strong, nonatomic)   ObjHomeViewController *homeViewController;
@property (weak, nonatomic)     IBOutlet UITabBar *tabBarView;


@end

@implementation ObjTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeViewController = [[ObjHomeViewController alloc] initWithNibName:@"ObjHomeViewController" bundle:nil];
    ObjNavigationViewController *nav = [[ObjNavigationViewController alloc] initWithRootViewController:self.homeViewController];
    [self addChildViewController:nav];
    [self.view insertSubview:nav.view belowSubview:self.tabBarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------selectItem

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    switch (index) {
        case 0:
        {
            //首页
        }
            break;
        case 1:
        {
            //选购
        }
            break;
        case 2:
        {
            //购物车
        }
            break;
        case 3:
        {
            //个人信息
        }
            break;
            
        default:
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end

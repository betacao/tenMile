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

@interface ObjTabbarController ()<UINavigationControllerDelegate>

@end

@implementation ObjTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //商城
    ObjStoresViewController *storesViewController = [[ObjStoresViewController alloc] initWithNibName:@"ObjStoresViewController" bundle:nil];
    ObjNavigationViewController *nav1 = [[ObjNavigationViewController alloc] initWithRootViewController:storesViewController];
    nav1.delegate = self;
    
    //购物车
    ObjCartViewController *cartViewController = [[ObjCartViewController alloc] initWithNibName:@"ObjCartViewController" bundle:nil];
    ObjNavigationViewController *nav2 = [[ObjNavigationViewController alloc] initWithRootViewController:cartViewController];
    nav2.delegate = self;
    
    //个人中心
    ObjUserSettingViewController *settingViewController = [[ObjUserSettingViewController alloc] initWithNibName:@"ObjUserSettingViewController" bundle:nil];
    ObjNavigationViewController *nav3 = [[ObjNavigationViewController alloc] initWithRootViewController:settingViewController];
    nav3.delegate = self;
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"选购" image:[UIImage imageNamed:@"选购--常态"] selectedImage:[UIImage imageNamed:@"选购--常态"]];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车--常态"] selectedImage:[UIImage imageNamed:@"购物车--常态"]];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"个人信息" image:[UIImage imageNamed:@"个人中心-常态"] selectedImage:[UIImage imageNamed:@"个人中心-常态"]];
    

    storesViewController.tabBarItem = item1;
    cartViewController.tabBarItem = item2;
    settingViewController.tabBarItem = item3;
    
    [self setViewControllers:@[nav1,nav2,nav3] animated:NO];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    if(index == 0){
        
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSTimeInterval animationDuration = (viewController == [navigationController.viewControllers firstObject])?0.26:0.25;
    CGRect frame = self.tabBar.frame;
    frame.origin.x = (viewController == [navigationController.viewControllers firstObject])?0.0f:(self.tabBar.frame.size.width * -1.0f);
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.tabBar.frame = frame;
        [self.view bringSubviewToFront:self.tabBar];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

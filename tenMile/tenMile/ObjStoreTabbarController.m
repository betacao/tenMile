//
//  ObjStoreTabbarController.m
//  tenMile
//
//  Created by changxicao on 15/6/28.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjStoreTabbarController.h"
#import "ObjHomeViewController.h"
#import "ObjNavigationViewController.h"
#import "ObjUserSettingViewController.h"
#import "ObjStoresViewController.h"
#import "ObjMyStoreViewController.h"

@interface ObjStoreTabbarController ()<UINavigationControllerDelegate>

@end

@implementation ObjStoreTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //商城
    ObjStoresViewController *storesViewController = [[ObjStoresViewController alloc] initWithNibName:@"ObjStoresViewController" bundle:nil];
    ObjNavigationViewController *nav1 = [[ObjNavigationViewController alloc] initWithRootViewController:storesViewController];
    nav1.delegate = self;
    
    //我的店铺
    ObjMyStoreViewController *cartViewController = [[ObjMyStoreViewController alloc] initWithNibName:@"ObjMyStoreViewController" bundle:nil];
    ObjNavigationViewController *nav2 = [[ObjNavigationViewController alloc] initWithRootViewController:cartViewController];
    nav2.delegate = self;
    
    //个人中心
    ObjUserSettingViewController *settingViewController = [[ObjUserSettingViewController alloc] initWithNibName:@"ObjUserSettingViewController" bundle:nil];
    ObjNavigationViewController *nav3 = [[ObjNavigationViewController alloc] initWithRootViewController:settingViewController];
    nav3.delegate = self;
    
    UIImage *image = [UIImage imageNamed:@"商家--常态"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:@"商家--选中"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"商城" image:image selectedImage:selectedImage];
    
    image = [UIImage imageNamed:@"我的店铺-常态"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [UIImage imageNamed:@"店铺--选中"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"我的店铺" image:image selectedImage:selectedImage];
    
    image = [UIImage imageNamed:@"个人中心-常态"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [UIImage imageNamed:@"个人中心-选中"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"个人信息" image:image selectedImage:selectedImage];
    
    
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

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
#import "ObjUserSettingViewController.h"
#import "ObjStoresViewController.h"
#import "ObjCartViewController.h"


@interface ObjTabBarViewController ()<UITabBarDelegate>

@property (weak, nonatomic)     IBOutlet UITabBar *tabBarView;
@property (strong, nonatomic)   NSArray *viewControllers;
@property (assign, nonatomic)   NSInteger currentIndex;


@end

@implementation ObjTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    ObjHomeViewController *homeViewController = [[ObjHomeViewController alloc] initWithNibName:@"ObjHomeViewController" bundle:nil];
    ObjNavigationViewController *nav1 = [[ObjNavigationViewController alloc] initWithRootViewController:homeViewController];
    [self addChildViewController:nav1];
    [self.view insertSubview:nav1.view belowSubview:self.tabBarView];
    
    //商城
    ObjStoresViewController *storesViewController = [[ObjStoresViewController alloc] initWithNibName:@"ObjStoresViewController" bundle:nil];
    ObjNavigationViewController *nav2 = [[ObjNavigationViewController alloc] initWithRootViewController:storesViewController];
    
    //购物车
    ObjCartViewController *cartViewController = [[ObjCartViewController alloc] initWithNibName:@"ObjCartViewController" bundle:nil];
    ObjNavigationViewController *nav3 = [[ObjNavigationViewController alloc] initWithRootViewController:cartViewController];
    
    //个人中心
    ObjUserSettingViewController *settingViewController = [[ObjUserSettingViewController alloc] initWithNibName:@"ObjUserSettingViewController" bundle:nil];
    ObjNavigationViewController *nav4 = [[ObjNavigationViewController alloc] initWithRootViewController:settingViewController];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
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
    if(self.currentIndex == index) {
        return;
    }
    switch (index) {
        case 0:
        {
            //首页
            ObjNavigationViewController *fromController = [self.viewControllers objectAtIndex:self.currentIndex];
            ObjNavigationViewController *toController = [self.viewControllers objectAtIndex:index];
            [fromController.view removeFromSuperview];
            [fromController removeFromParentViewController];
            
            [self addChildViewController:toController];
            [self.view insertSubview:toController.view belowSubview:self.tabBarView];
        }
            break;
        case 1:
        {
            //选购
            ObjNavigationViewController *fromController = [self.viewControllers objectAtIndex:self.currentIndex];
            ObjNavigationViewController *toController = [self.viewControllers objectAtIndex:index];
            [fromController.view removeFromSuperview];
            [fromController removeFromParentViewController];
            
            [self addChildViewController:toController];
            [self.view insertSubview:toController.view belowSubview:self.tabBarView];
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
            ObjNavigationViewController *fromController = [self.viewControllers objectAtIndex:self.currentIndex];
            ObjNavigationViewController *toController = [self.viewControllers objectAtIndex:index];
            [fromController.view removeFromSuperview];
            [fromController removeFromParentViewController];
            
            [self addChildViewController:toController];
            [self.view insertSubview:toController.view belowSubview:self.tabBarView];
        }
            break;
            
        default:
            break;
    }
    self.currentIndex = index;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end

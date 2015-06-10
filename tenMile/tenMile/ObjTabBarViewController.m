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

@interface ObjTabBarViewController ()

@property (strong, nonatomic) ObjHomeViewController *homeViewController;
@property (weak, nonatomic) IBOutlet UITabBar *tabBarView;


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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end

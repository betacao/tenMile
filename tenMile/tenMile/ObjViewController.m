//
//  ObjRootViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjViewController.h"

@interface ObjViewController ()

@end

@implementation ObjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *controllerArray = self.navigationController.viewControllers;
    if([controllerArray indexOfObject:self] != 0){
        UIButton *button = [UIButton buttonWithImageName:@"返回" highlightedImageName:@"返回" title:nil target:self action:@selector(popViewController)];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

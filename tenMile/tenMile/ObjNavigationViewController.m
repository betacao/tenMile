//
//  ObjNavigationViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjNavigationViewController.h"

@interface ObjNavigationViewController ()

@end

@implementation ObjNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage patternImageWithColor: [UIColor colorWithHexString:@"29A1CB"]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

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
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

//
//  ObjLoginViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjLoginViewController.h"
#import "ObjForgetPasswordViewController.h"
#import "ObjRestPasswordViewController.h"
#import "ObjRegisterViewController.h"

@interface ObjLoginViewController ()

@end

@implementation ObjLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}
- (IBAction)loginBtnClick:(id)sender {
    
}
- (IBAction)forgetBtnClick:(UIButton *)sender {
    ObjForgetPasswordViewController *controller = [[ObjForgetPasswordViewController alloc] initWithNibName:@"ObjForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)registerBtnClick:(UIButton *)sender {
    ObjRegisterViewController *controller = [[ObjRegisterViewController alloc] initWithNibName:@"ObjRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)resetBtnClick:(UIButton *)sender {
    ObjRestPasswordViewController *controller = [[ObjRestPasswordViewController alloc] initWithNibName:@"ObjRestPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

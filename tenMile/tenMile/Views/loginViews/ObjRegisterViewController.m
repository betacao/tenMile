//
//  ObjRegisterViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjRegisterViewController.h"

@interface ObjRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation ObjRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHeadImageView:)];
    [self.headImageView addGestureRecognizer:recognizer];
}

- (void)didTapHeadImageView:(UIGestureRecognizer *)recognizer
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ObjHomeViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/8.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjHomeViewController.h"


@interface ObjHomeViewController ()<UISearchBarDelegate>
@end

@implementation ObjHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    //切换地址
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setFrame:CGRectMake(0, 21, 30, 25)];
    [locationBtn setTitle:@"南京" forState:UIControlStateNormal];
    [locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //个人中心
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setFrame:CGRectMake(0, 24, 16, 16)];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"用户"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:userBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 21, 220, 30)];
    titleView.backgroundColor = [UIColor clearColor];
    UISearchBar *searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 215, 37)];
    searBar.exclusiveTouch = YES;
    searBar.backgroundImage = [UIImage patternImageWithColor:[UIColor clearColor]];
    searBar.delegate = self;
    searBar.placeholder = @"输入关键字";
    [searBar setBarStyle:UIBarStyleDefault];
    [titleView addSubview:searBar];
    
    self.navigationItem.titleView = titleView;


}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *ruleStr = @"一般也就是这两种时机会去做View层架构，基于这个时机的特殊性，我们在这时候必须清楚认识到：View层的架构一旦实现或定型，在App发版后可修改的余地就已经非常之小了。因为它跟业务关联最为紧密，所以哪怕稍微动一点点，它所引发的蝴蝶效应都不见得是业务方能够hold住的。这样的情况，就要求我们在实现这个架构时，代码必须得改得勤快，不能偷懒。也必须抱着充分的自我怀疑态度，做决策时要拿捏好尺度。";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
    
    CGSize textSize = [ruleStr boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [self.ruleLab setFrame:CGRectMake(10, self.ruleLab.frame.origin.y, 300, textSize.height)];
    [self.ruleLab setNumberOfLines:0];
    self.ruleLab.text = ruleStr;
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.ruleLab.frame.origin.y+textSize.height+10)];
    
}

- (void)gotoUserCenter{
    
}
- (void)changeCity{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *subView in [[searchBar.subviews objectAtIndex:0] subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    return YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
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

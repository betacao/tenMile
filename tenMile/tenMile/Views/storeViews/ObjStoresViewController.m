//
//  ObjStoresViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/10.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjStoresViewController.h"
#import "ObjDiningOutViewController.h"

@interface ObjStoresViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *storeScrollView;
@end

@implementation ObjStoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initStaticViews];
}
- (void)initStaticViews
{

    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f4f5"];
    UIButton *myOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [myOrderBtn setFrame:CGRectZero];
    [myOrderBtn setImage:[UIImage imageNamed:@"我的订单"] forState:UIControlStateNormal];
    [myOrderBtn sizeToFit];
    [myOrderBtn addTarget:self action:@selector(gotoMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:myOrderBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //搜索框
    UISearchBar *searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 215, 37)];
    searBar.exclusiveTouch = YES;
    searBar.backgroundImage = [UIImage patternImageWithColor:[UIColor clearColor]];
    searBar.delegate = self;
    searBar.placeholder = @"输入关键字";
    [searBar setBarStyle:UIBarStyleDefault];
    
    self.navigationItem.titleView = searBar;
    
    
    //分类按钮
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ObjStoresViewController" owner:self options:nil];
    UIView *categoryView = [nib objectAtIndex:1];
    CGRect frame = categoryView.frame;
    frame.origin.y += (kNavigationBarHeight + kStatusBarMaxY + 10.0f);
    categoryView.frame = frame;
    [self.storeScrollView addSubview:categoryView];
    
    //限时抢购
    UIView *limitedView = [nib objectAtIndex:2];
    frame = limitedView.frame;
    frame.origin.y += (CGRectGetMaxY(categoryView.frame) + 8.0f);
    limitedView.frame = frame;
    [self.storeScrollView addSubview:limitedView];
    
    //名店推荐
    UIView *recomendView = [nib objectAtIndex:3];
    frame = recomendView.frame;
    frame.origin.y += (CGRectGetMaxY(limitedView.frame) + 8.0f);
    recomendView.frame = frame;
    [self.storeScrollView addSubview:recomendView];
    
//    self.storeScrollView.contentSize = CGSizeMake(kScreenWidth, 1.1f * CGRectGetMaxY(recomendView.frame));
    
}

- (void)gotoMyOrder:(UIButton *)button
{
    
}

//超市零食
- (IBAction)superMarket:(UIButton *)sender {
}

//餐饮外卖
- (IBAction)diningOut:(UIButton *)sender {
    ObjDiningOutViewController *controller = [[ObjDiningOutViewController alloc] initWithNibName:@"ObjDiningOutViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}

//衣物护洗
- (IBAction)washingCloth:(UIButton *)sender {
}

//学习用品
- (IBAction)studyTools:(UIButton *)sender {
}

- (IBAction)training:(UIButton *)sender {
}

//旅游素拓
- (IBAction)tourism:(UIButton *)sender {
}

//摄影印刷
- (IBAction)photoShot:(UIButton *)sender {
}

//其他服务
- (IBAction)otherService:(UIButton *)sender {
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

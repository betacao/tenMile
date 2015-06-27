//
//  ObjDiningOutViewController.m
//  tenMile
//
//  Created by changxicao on 15/6/27.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ObjDiningOutViewController.h"
#import "ObjDiningOutTableViewCell.h"

@interface ObjDiningOutViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;



@end

@implementation ObjDiningOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initStaticViews];
}
- (void)initStaticViews
{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f4f5"];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectZero];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [searchBtn sizeToFit];
    [searchBtn addTarget:self action:@selector(gotoSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //搜索框
    UISearchBar *searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 215, 37)];
    searBar.exclusiveTouch = YES;
    searBar.backgroundImage = [UIImage patternImageWithColor:[UIColor clearColor]];
    searBar.delegate = self;
    searBar.placeholder = @"输入关键字";
    [searBar setBarStyle:UIBarStyleDefault];
    self.navigationItem.titleView = searBar;
    
    ObjSegmentView *segmentView = [[ObjSegmentView alloc] initWithFrame:CGRectMake(0.0f, kNavigationBarHeight + kStatusBarMaxY, kScreenWidth, 35.0f)];
    segmentView.titleArr = @[@"店铺种类",@"店铺分区",@"默认排序"];
    [self.contentView insertSubview:segmentView belowSubview:self.contentTableView];
    
    self.contentTableView.dataSource = self;
    self.contentTableView.delegate = self;
    
}


- (void)gotoSearch:(UIButton *)button
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"ObjDiningOutTableViewCell";
    ObjDiningOutTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ObjDiningOutTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ObjDiningOutViewController" owner:self options:nil];
//    UIView *tipView = [nib objectAtIndex:1];
    ObjDiningOutTipView *tipView = [[ObjDiningOutTipView alloc] initWithFrame:self.view.bounds];
    
    [self.view.window addSubview:tipView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@interface ObjDiningOutTipView()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *frameView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation ObjDiningOutTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
    if(self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(40.0f, 110.0f, 240.0f, 170.0f)];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.masksToBounds = YES;
        self.backView.layer.cornerRadius = 2.0f;
        
        self.frameView = [[UIView alloc] initWithFrame:CGRectMake(30.0f, 40.0f, 180.0f, 90.0f)];
        self.frameView.layer.masksToBounds = YES;
        self.frameView.layer.cornerRadius = 2.0f;
        self.frameView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.frameView.layer.borderWidth = 1.0f;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55.0f, 8.0f, 66.0f, 21.0f)];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 37.0f, 161.0f, 30.0f)];
        self.titleLabel.text = @"温馨提示！";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.contentLabel.text = @"尊敬的用户，你好！本地铺尚在休息中，推荐你去其他商家转转吧～";
        self.contentLabel.font = [UIFont systemFontOfSize:10.0f];
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.textColor = [UIColor darkGrayColor];
        
        self.closeBtn = [UIButton buttonWithImageName:@"close" highlightedImageName:@"close" title:nil target:self action:@selector(closeTipView:)];
        CGRect frame = self.closeBtn.frame;
        frame.origin.x = CGRectGetWidth(self.backView.frame) - CGRectGetWidth(frame) - 5.0f;
        frame.origin.y += 5.0f;
        self.closeBtn.frame = frame;
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.frameView];
        [self.backView addSubview:self.closeBtn];
        [self.frameView addSubview:self.titleLabel];
        [self.frameView addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)closeTipView:(UIButton *)button
{
    [self removeFromSuperview];
}
@end



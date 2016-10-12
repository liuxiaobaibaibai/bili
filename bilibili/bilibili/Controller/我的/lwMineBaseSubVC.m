//
//  lwMineBaseSubVC.m
//  bilibili
//
//  Created by lw on 2016/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineBaseSubVC.h"

/***/
#import "lwNavigationBar.h"
/***/


#define kHEIGHT 200

@interface lwMineBaseSubVC ()
<
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UIScrollView *myScrollView;

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) lwNavigationBar *navBar;

@end

@implementation lwMineBaseSubVC

// 数据加载
#pragma mark - loadDataSource
- (void)loadDataSource{
    
}

// 动作事件
#pragma mark - userAction

// 初始化
#pragma mark - init

// 生命周期
#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupView];
    
    [_navBar setTitle:self.title];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor biliPinkColor];
    
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"category_back_button"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"category_back_button"]];
//
//    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, lNavH)];
//    navView.backgroundColor = [UIColor biliPinkColor];
//    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64-35, 41, 30)];
//    [btn setImage:[UIImage imageNamed:@"category_back_button"] forState:UIControlStateNormal];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [navView addSubview:btn];
//
//    [self.view addSubview:navView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage new]];
    
    
    [self.view addSubview:self.navBar];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// 常用代理
#pragma mark - delegate
#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < - 1) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.headerView.frame = rect;
        
        [_headerView setCorner:UIRectCornerTopLeft | UIRectCornerTopRight Radius:5.0];
    }
}

// 常用数据源
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = @"测试诗句";
    
    return cell;
}

// 加载视图
#pragma mark - loadView
- (void)setupView{
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView addSubview:self.headerView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(lNavH, 0, -5, 0));
    }];
    
}

// getter or setter
#pragma mark - setter

#pragma mark - getter

- (lwNavigationBar *)navBar{
    if (_navBar == nil) {
        _navBar = [[lwNavigationBar alloc] initWithFrame:CGRectMake(0, 0, lW, lNavH)];
    }
    return _navBar;
}

- (id)delegate{
    if (_delegate == nil) {
        _delegate = self;
    }
    return _delegate;
}

- (id)dataSource{
    if (_dataSource == nil) {
        _dataSource = self;
    }
    return _dataSource;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 1)];
        [_headerView setCorner:UIRectCornerTopLeft | UIRectCornerTopRight Radius:5.0];
        _headerView.backgroundColor = [UIColor biliPinkColor];
        
    }
    return _headerView;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self.delegate;
        _myTableView.dataSource = self.dataSource;
        _myTableView.tableFooterView = [UIView new];
        
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.backgroundView.backgroundColor = [UIColor whiteColor];
        
        _myTableView.backgroundView.layer.cornerRadius = 6.0;
        _myTableView.backgroundView.layer.masksToBounds = YES;
        _myTableView.layer.cornerRadius = 6.0;
        _myTableView.layer.masksToBounds = YES;
    }
    return _myTableView;
}

@end

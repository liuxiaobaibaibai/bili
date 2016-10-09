//
//  lwMineBaseSubVC.m
//  bilibili
//
//  Created by lw on 2016/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineBaseSubVC.h"

@interface lwMineBaseSubVC ()
<
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UIScrollView *myScrollView;

@property (strong, nonatomic) UIView *headerView;

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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setBackgroundColor:[UIColor biliPinkColor]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

// 常用代理
#pragma mark - delegate
#pragma mark - scrollView delegate
#define kHEIGHT 200
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < - kHEIGHT) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.headerView.frame = rect;
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
    }
    
    cell.textLabel.text = @"测试诗句";
    
    return cell;
}

// 加载视图
#pragma mark - loadView
- (void)setupView{
    
    [self.view addSubview:self.myTableView];
    [self.myTableView setContentInset:UIEdgeInsetsMake(kHEIGHT, 0, 0, 0)];
    [self.myTableView addSubview:self.headerView];
    
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(lNavH, 0, 0, 0));
    }];
    
}

// getter or setter
#pragma mark - setter

#pragma mark - getter

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
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, kHEIGHT)];
        _headerView.layer.cornerRadius = 5.0;
        _headerView.layer.masksToBounds = YES;
        _headerView.backgroundColor = [UIColor JDColor];
    }
    return _headerView;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self.delegate;
        _myTableView.dataSource = self.dataSource;
        _myTableView.tableFooterView = [UIView new];
    }
    return _myTableView;
}

@end

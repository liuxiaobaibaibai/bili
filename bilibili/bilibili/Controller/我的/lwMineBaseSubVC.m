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
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UIScrollView *myScrollView;

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
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

// 常用代理
#pragma mark - delegate

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
    
    WS(ws);
    
    if (self.isCorr) {
        [self.view addSubview:self.myScrollView];
        [self.myScrollView addSubview:self.myTableView];
        
        [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(ws.view);
            make.bottom.mas_equalTo(5);
        }];
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.equalTo(ws.myScrollView);
            make.top.mas_equalTo(lNavH);
            make.width.mas_equalTo(lW);
            make.height.mas_equalTo(lH - lNavH );
        }];
    }else{
        [self.view addSubview:self.myTableView];
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
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

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self.delegate;
        _myTableView.dataSource = self.dataSource;
        _myTableView.layer.cornerRadius = 5.0;
        _myTableView.layer.masksToBounds = YES;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.contentSize = CGSizeMake(lW, 2 * lH);
    }
    return _myTableView;
}

- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.backgroundColor = [UIColor biliPinkColor];
    }
    return _myScrollView;
}

@end

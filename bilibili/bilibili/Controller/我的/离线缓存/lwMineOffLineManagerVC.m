//
//  lwMineOffLineManagerVC.m
//  bilibili
//
//  Created by 刘威 on 16/10/16.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineOffLineManagerVC.h"

#import "lwMineBaseSubVC.h"
#import "lwNavigationBar.h"

@interface lwMineOffLineManagerVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UIBarButtonItem *rightItem;

@end

@implementation lwMineOffLineManagerVC

// 数据加载
#pragma mark - loadDataSource
- (void)loadDataSource{
    self.source = @[@"",@"",@"",@""];
    [self.myTableView reloadData];
}

// 动作事件
#pragma mark - userAction
- (void)barButtonItemClick:(UIBarButtonItem *)item{
    NSLog(@"吊的一笔");
}

// 初始化
#pragma mark - init

// 生命周期
#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupView];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self loadDataSource];
}


// 常用代理
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 常用数据源
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.source.count;
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
    
    cell.textLabel.text = @"吊的一笔";
    
    return cell;
}

// 加载视图
#pragma mark - loadView

- (void)setupView{
    [super setupView];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
}

// getter or setter
#pragma mark - setter

#pragma mark - getter
- (UIBarButtonItem *)rightItem{
    if (_rightItem == nil) {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClick:)];
    }
    return _rightItem;
}


@end

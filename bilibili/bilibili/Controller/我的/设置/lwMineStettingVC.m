//
//  lwMineStettingVC.m
//  bilibili
//
//  Created by 刘威 on 16/10/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineStettingVC.h"
#import "lwMineSettingCell.h"
#import "lwMineSettingModel.h"

#import "lwNavigationBar.h"

@interface lwMineStettingVC ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (copy, nonatomic) NSArray *mineSetting;


@end

@implementation lwMineStettingVC

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
    self.isGroup = YES;
}


// 常用代理
#pragma mark - delegate

// 常用数据源
#pragma mark - dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == self.mineSetting.count ? 10 : 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mineSetting[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.mineSetting count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    lwMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[lwMineSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setMineSettingModel:self.mineSetting[indexPath.section][indexPath.row]];
    
    return cell;
}

// 加载视图
#pragma mark - loadView
- (void)setupView{
    [super setupView];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

// getter or setter
#pragma mark - setter

#pragma mark - getter

- (NSArray *)mineSetting{
    if (_mineSetting == nil) {
        _mineSetting = [lwMineSettingModel mineSetting];
    }
    return _mineSetting;
}

@end

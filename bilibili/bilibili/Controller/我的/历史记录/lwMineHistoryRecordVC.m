//
//  lwMineHistoryRecordVC.m
//  bilibili
//
//  Created by 刘威 on 16/10/17.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineHistoryRecordVC.h"

#import "lwMineBaseSubVC.h"
#import "lwNavigationBar.h"

#import "lwMineHistoryRecordCell.h"

@interface lwMineHistoryRecordVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UIBarButtonItem *rightItem;

@end

@implementation lwMineHistoryRecordVC

// 数据加载
#pragma mark - loadDataSource
- (void)loadDataSource{
    self.source = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [self.myTableView reloadData];
}

// 动作事件
#pragma mark - userAction
- (void)barButtonItemClick:(UIBarButtonItem *)item{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清空播放历史" message:@"喵，想掩盖些什么呢？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
    [alert show];
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
    lwMineHistoryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[lwMineHistoryRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    return cell;
}

// 加载视图
#pragma mark - loadView

- (void)setupView{
    [super setupView];
    
    self.myTableView.rowHeight = 90;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.myTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

// getter or setter
#pragma mark - setter

#pragma mark - getter
- (UIBarButtonItem *)rightItem{
    if (_rightItem == nil) {
        _rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(barButtonItemClick:)];
    }
    return _rightItem;
}

@end

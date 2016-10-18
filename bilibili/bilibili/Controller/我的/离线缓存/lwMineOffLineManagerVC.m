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

#import "lwMineOffLineCell.h"

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
    self.source = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    [self.myTableView reloadData];
}

// 动作事件
#pragma mark - userAction
- (void)barButtonItemClick:(UIBarButtonItem *)item{
    if (!self.myTableView.isEditing) {
        [self.myTableView setEditing:YES];
    }else{
        [self.myTableView setEditing:NO];
    }
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [ws.source removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    
    return @[deleteAction];
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
    lwMineOffLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[lwMineOffLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    return cell;
}

// 加载视图
#pragma mark - loadView

- (void)setupView{
    [super setupView];
    
    self.myTableView.rowHeight = 70;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

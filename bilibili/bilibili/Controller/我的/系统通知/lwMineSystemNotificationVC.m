//
//  lwMineSystemNotificationVC.m
//  bilibili
//
//  Created by lw on 2016/10/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineSystemNotificationVC.h"

#import "lwMineSystemNotificationCell.h"

@interface lwMineSystemNotificationVC ()

<
UITableViewDelegate,
UITableViewDataSource
>


@end

@implementation lwMineSystemNotificationVC

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
    lwMineSystemNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[lwMineSystemNotificationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

// 加载视图
#pragma mark - loadView

- (void)setupView{
    [super setupView];
    
    self.myTableView.estimatedRowHeight = 44;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, -15);
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

// getter or setter
#pragma mark - setter

#pragma mark - getter

@end

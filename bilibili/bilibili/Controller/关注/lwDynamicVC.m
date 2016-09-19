//
//  lwDynamicVC.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwDynamicVC.h"
#import "lwDynamicCell.h"

static NSString *lwDynamicCellID = @"asd";

@interface lwDynamicVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation lwDynamicVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self.myTableView loadHeaderRefreshControl:self Action:@selector(loadDataSource:) Completion:^(UIRefreshControl *control) {
        [control beginRefreshing];
        [self loadDataSource:control];
    }];
}

#pragma mark - UserOperation

- (void)loadDataSource:(id)control{
    NSArray *source = @[@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的"];
    __block lwDynamicVC *bSelf = self;
    [source enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [bSelf.dataSource addObject:obj];
        [bSelf.myTableView reloadData];
        [(UIRefreshControl *)control endRefreshing];
    }];
}

#pragma mark - UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    lwDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:lwDynamicCellID];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - loadView

- (void)setupView{
    [self.view addSubview:self.myTableView];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - getter
- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [UITableView tableViewTarget:self Style:UITableViewStyleGrouped];
        [_myTableView setBackgroundColor:RGB(242, 242, 242)];
        [_myTableView registerClass:[lwDynamicCell class] forCellReuseIdentifier:lwDynamicCellID];
        _myTableView.rowHeight = 110;
    }
    return _myTableView;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end;

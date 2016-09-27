//
//  lwChaseSopaOperaVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwChaseSopaOperaVC.h"
#import "lwChaseSopaOperaCell.h"

static NSString *lwChaseSopaOperaCellID = @"asd";

@interface lwChaseSopaOperaVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation lwChaseSopaOperaVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self.myTableView loadHeaderRefreshControl:self Action:@selector(loadDataSource:) Completion:^(UIRefreshControl *control) {
        [control beginRefreshing];
        [self loadDataSource:control];
    }];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}


#pragma mark - UserOperation

- (void)loadDataSource:(id)control{
    NSArray *source = @[@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的",@"的",@"啊",@"是的"];
    WS(ws);
    [source enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ws.dataSource addObject:obj];
        [ws.myTableView reloadData];
        [(UIRefreshControl *)control endRefreshing];
    }];
}

#pragma mark - UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    lwChaseSopaOperaCell *cell = [tableView dequeueReusableCellWithIdentifier:lwChaseSopaOperaCellID];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentController:@"lwChaseSopaOperaVC" Completion:nil Finish:nil];
    }
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
        _myTableView = [UITableView tableViewTarget:self Style:UITableViewStylePlain];
        [_myTableView registerClass:[lwChaseSopaOperaCell class] forCellReuseIdentifier:lwChaseSopaOperaCellID];
        _myTableView.rowHeight = 90;
    }
    return _myTableView;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end

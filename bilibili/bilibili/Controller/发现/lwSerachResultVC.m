//
//  lwSerachResultVC.m
//  bilibili
//
//  Created by lw on 2016/9/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSerachResultVC.h"

@interface lwSerachResultVC ()
<
UISearchBarDelegate,
UISearchControllerDelegate,
UISearchResultsUpdating,
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *searchResult;

@end

@implementation lwSerachResultVC

#pragma mark - private method

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupView];    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.serachVC.searchBar becomeFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController.view removeFromSuperview];
    [self.navigationController removeFromParentViewController];
}

#pragma mark - searchController delegate

#pragma mark - result update
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"搜索");
}

#pragma mark - tableView delegate

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:cellID];
        cell.backgroundColor = RGB(240, 240, 240);
    }
    
    [cell.textLabel setText:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - setupView
- (void)setupView{
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)cloese:(id)seder{
    [self.navigationController removeFromParentViewController];
    [self.navigationController.view removeFromSuperview];
}

#pragma mark - getter
- (NSMutableArray *)searchResult{
    if (_searchResult == nil) {
        _searchResult = [NSMutableArray new];
    }
    return _searchResult;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"阿达",@"昂鞥",@"阿达我",@"胸口",@"阿达",@"昂鞥"]];
    }
    return _dataSource;
}

- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 0)];
    footerView.backgroundColor = RGB(240, 240, 240);
    return footerView;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView hideKeyBoard:YES];
        [_myTableView setTableHeaderView:self.serachVC.searchBar];
        [_myTableView setTableFooterView:[self tableFooterView]];
        _myTableView.backgroundColor = RGB(240, 240, 240);
    }
    return _myTableView;
}

- (UISearchController *)serachVC{
    if (_serachVC == nil) {
        _serachVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _serachVC.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _serachVC.dimsBackgroundDuringPresentation = false;
        //搜索栏表头视图
        [_serachVC.searchBar sizeToFit];
        //背景颜色
        [_serachVC.searchBar setBackgroundImage:[UIImage new]];
        _serachVC.searchBar.tintColor = [UIColor whiteColor];
        _serachVC.searchBar.barTintColor = [UIColor biliPinkColor];
        _serachVC.searchBar.placeholder = @"搜索视频、番剧、up主或AV号";
        _serachVC.searchBar.delegate = self;
        _serachVC.searchResultsUpdater = self;
    }
    return _serachVC;
}

@end

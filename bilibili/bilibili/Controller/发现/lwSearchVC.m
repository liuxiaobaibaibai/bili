//
//  lwSearchVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSearchVC.h"
#import "lwFindBaseModel.h"
#import "lwSrarchHeaderView.h"


#import "lwSerachResultVC.h"

@interface lwSearchVC ()

<
lwSearchHeaderViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) lwSrarchHeaderView *headerView;

@property (copy, nonatomic) NSArray *source;

@property (strong, nonatomic) lwSerachResultVC *searchVC;

@property (strong, nonatomic) UINavigationController *searchRootVC;

@end

@implementation lwSearchVC

#pragma mark - view action
- (void)loadDataSource{
    self.source = [NSArray arrayWithArray:[lwFindBaseModel findConfig]];
    [self.myTableView reloadData];
}

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - lwSearchHeaderViewDelegate
- (void)headerButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            [_headerView layoutIfNeeded];
            
            if (_headerView.height < 350) {
                [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(350);
                }];
            }else{
                [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(230);
                }];
            }
        }
            break;
        case 2:
        {
            // 扫描二维码
        }
            break;
        default:
        {
            // 搜索
            self.searchRootVC = [[UINavigationController alloc] initWithRootViewController:self.searchVC];
            self.searchVC.navigationController.navigationBarHidden = YES;
            [self addChildViewController:self.searchRootVC];
            [self.view addSubview:self.searchRootVC.view];
        }
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.source.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.source[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    lwFindBaseModel *model = self.source[indexPath.section][indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.imageView.image = [UIImage imageNamed:model.imgPath];
    
    return cell;
}

#pragma mark - setupView
- (void)setupView{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.myTableView];
    WS(ws);
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(230);
    }];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(ws.headerView.mas_bottom);
        make.bottom.mas_equalTo(-lTabbarH);
    }];
    
}

#pragma mark - getter

- (NSArray *)source{
    if (_source == nil) {
        _source = @[];
    }
    return _source;
}

- (lwSrarchHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[lwSrarchHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (lwSerachResultVC *)searchVC{
    if (_searchVC == nil) {
        _searchVC = [[lwSerachResultVC alloc] init];
        [_searchVC.view setFrame:self.view.frame];
    }
    return _searchVC;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

@end

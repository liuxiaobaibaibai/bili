//
//  lwLabelVC.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCategoryDetailVC.h"

#import "lwTagView.h"
#import "lwAttentionTagCell.h"

#import "lwAttentionTagModel.h"

#define TOOLHIEGHT 50

static NSString *lwAttentionTagCellID = @"id";

@interface lwCategoryDetailVC ()
<
lwTagViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) lwTagView *tagView;

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray <lwAttentionTagModel *> *dataSource;

@property (strong, nonatomic) NSMutableArray <lwAttentionTagModel *> *filterSource;

@property (strong, nonatomic) NSMutableArray <lwAttentionTag *> *tags;

/**用来标记是否展示标签**/
// 暂时处理，应该会有更好的处理的方式
@property (assign, nonatomic) BOOL filtered;


@end

@implementation lwCategoryDetailVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filtered = NO;
    
    [self setupView];
    [self loadDataSource];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark - UserOperation

- (void)tagClick:(UIButton *)btn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您点击了：%@",btn.titleLabel.text] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alert show];
}

- (void)loadDataSource{
    
    self.tags = [NSMutableArray arrayWithArray:[lwAttentionTag tags]];
    
    [self.tagView setTags:self.tags];
    
    self.dataSource = [NSMutableArray arrayWithArray:[lwAttentionTagModel feeds]];
    
    self.filterSource = [self.dataSource mutableCopy];
    
    
    [self.myTableView reloadData];
}

/**下拉刷新**/
- (void)refreshDataSource:(id)control{
    
}

#pragma makr - lwTagViewDelegate
- (void)tagViewButtonClick:(UIButton *)btn{
    
    lwAttentionTag *tag = self.tags[btn.tag];
    
    if (btn.tag != 0) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"src_id == %d",tag.tag_id];
        self.dataSource = [NSMutableArray arrayWithArray:[self.filterSource filteredArrayUsingPredicate:pre]];
        self.filtered = YES;
    }else{
        self.filtered = NO;
        self.dataSource = [NSMutableArray arrayWithArray:self.filterSource];
    }
    
    [self.myTableView reloadData];
}

#pragma mark - UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    lwAttentionTagCell *cell = [tableView dequeueReusableCellWithIdentifier:lwAttentionTagCellID];
    
    WS(ws);
    
    [cell tagModel:self.dataSource[indexPath.row] Filtered:self.filtered Completion:^(id object) {
        [(UIButton *)object addTarget:ws action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - loadView

- (void)setupView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.tagView];
    
    WS(ws);
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(TOOLHIEGHT);
    }];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake((lNavH + TOOLHIEGHT), 0, 0, 0));
    }];
}

#pragma mark - getter
- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [UITableView tableViewTarget:self Style:UITableViewStylePlain];
        [_myTableView registerClass:[lwAttentionTagCell class] forCellReuseIdentifier:lwAttentionTagCellID];
    }
    return _myTableView;
}

- (lwTagView *)tagView{
    if (_tagView == nil) {
        _tagView = [[lwTagView alloc] init];
        _tagView.delegate = self;
    }
    return _tagView;
}

- (NSMutableArray <lwAttentionTag *> *)tags{
    if (_tags == nil) {
        _tags = [NSMutableArray new];
    }
    return _tags;
}

- (NSMutableArray <lwAttentionTagModel *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (NSMutableArray <lwAttentionTagModel *> *)filterSource{
    if (_filterSource == nil) {
        _filterSource = [NSMutableArray new];
    }
    return _filterSource;
}


@end

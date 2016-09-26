//
//  lwCategoryVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCategoryVC.h"
#import "lwCategoryCell.h"
#import "lwCategoryModel.h"


static NSString *lwCategoryUsuallyCellID = @"cellID";

@interface lwCategoryVC ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *myCollectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation lwCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupView];
    [self loadDataSource];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.myCollectionView.delegate = nil;
    self.myCollectionView.dataSource = nil;
    self.myCollectionView = nil;
}

#pragma mark - user Action
- (void)loadDataSource{
    self.dataSource = [lwCategoryModel categorySource];
    [self.myCollectionView reloadData];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lwTabber_changeViewController" object:nil userInfo:@{@"index":@0}];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwCategoryUsuallyCellID forIndexPath:indexPath];
    [cell setCategoryModel:(lwCategoryModel *)self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - loadView
- (void)setupView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor biliPinkColor];
    [self.view addSubview:self.myCollectionView];
    
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(lNavH, 0, lTabbarH, 0));
    }];
}

#pragma mark - getter

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat h = (lH - lNavH - lTabbarH) / 5 < 100 ? 100 : (lH - lNavH - lTabbarH) / 5;
        _flowLayout.itemSize = CGSizeMake((lW / 3), h);
        _flowLayout.minimumLineSpacing = 0 ;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)myCollectionView{
    if (_myCollectionView == nil) {
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [_myCollectionView setDelegate:self];
        [_myCollectionView setDataSource:self];
        _myCollectionView.backgroundColor = RGB(242, 242, 242);
        [_myCollectionView registerClass:[lwCategoryCell class] forCellWithReuseIdentifier:lwCategoryUsuallyCellID];
    }
    return _myCollectionView;
}


@end

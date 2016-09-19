//
//  lwAllCategoryVC.m
//  bilibili
//
//  Created by lw on 16/9/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAllCategoryVC.h"

#import "lwAllCategoryCell.h"
#import "lwLiveVideoModel.h"

static NSString *lwCategoryUsuallyCellID = @"cellID";

@interface lwAllCategoryVC ()

<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *myCollectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation lwAllCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - user Action
- (void)loadDataSource{
    self.dataSource = [lwLiveVideoEnterModel allCategory];
    [self.myCollectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    lwAllCategoryCell *cell = (lwAllCategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self pushController:@"lwCategoryDetailVC" Completion:^(id controller) {
        [(UIViewController *)controller setTitle:cell.iconModel.name];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwAllCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwCategoryUsuallyCellID forIndexPath:indexPath];
    [cell setIconModel:(lwLiveVideoEnterModel *)self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - loadView
- (void)setupView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.myCollectionView];
    
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(lNavH, 0, 0, 0));
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
        CGFloat h = (lH - lNavH - lTabbarH) / 4 < 100 ? 100 : (lH - lNavH - lTabbarH) / 4;
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
        [_myCollectionView registerClass:[lwAllCategoryCell class] forCellWithReuseIdentifier:lwCategoryUsuallyCellID];
    }
    return _myCollectionView;
}


@end

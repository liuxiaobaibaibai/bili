//
//  lwLiveVideoVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#warning 所有的indexPath.section - 1 都是因为  第一个部分拆出来作为banner了

#import "lwLiveVideoVC.h"

#import "lwLiveVideoModel.h"

#import "lwHomeLiveVideoCustomCell.h"
#import "lwHomeLiveHeaderView.h"


static NSString *lwCustomCellID = @"dee";

static NSString *lwHeaderViewID = @"aee";
static NSString *lwFooterViewID = @"eee";

static NSString *lwCustomHeaderViewID = @"fee";
static NSString *lwCustomFooterViewID = @"asd";

@interface lwLiveVideoVC ()
<
lwLiveVideoHeaderCellDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) lwLiveVideoModel * liveVideoModel;

@end

@implementation lwLiveVideoVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
}

- (void)dealloc{
    self.myCollectionView.delegate = nil;
    self.myCollectionView.dataSource = nil;
    self.myCollectionView = nil;
}

#pragma mark - private method

- (void)loadDataSource{
    self.liveVideoModel = [lwLiveVideoModel liveVideoSource];
    
    self.dataSource = [NSMutableArray arrayWithArray:self.liveVideoModel.partitions];

    NSMutableArray *recommend = [NSMutableArray arrayWithArray:self.liveVideoModel.recommendData.lives];
    [self.liveVideoModel.recommendData.bannerData enumerateObjectsUsingBlock:^(lwLiveModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [recommend insertObject:obj atIndex:6];
    }];
    
    lwLiveVideoPartitionsModel *partitionsModel = [[lwLiveVideoPartitionsModel alloc] init];
    partitionsModel.partitionModel = self.liveVideoModel.recommendData.partition;
    partitionsModel.lives = [NSMutableArray arrayWithArray:recommend];
    
    [self.dataSource insertObject:partitionsModel atIndex:0];
    
    [self.myCollectionView reloadData];
}

- (void)registCell:(UICollectionView *)collectionView{
    //cell
    [collectionView registerClass:[lwHomeLiveVideoCustomCell class] forCellWithReuseIdentifier:lwCustomCellID];//普通cell
}
- (void)registReusableView:(UICollectionView *)collectionView{
    // banner
    [collectionView registerClass:[lwHomeLiveHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwHeaderViewID];
    // 标题
    [collectionView registerClass:[lwHomeLiveHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwCustomHeaderViewID];
    // footer
    [_myCollectionView registerClass:[lwHomeLiveHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwFooterViewID];
}

- (void)refreshPartDataSource:(UIButton *)btn{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            //绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
            anima.toValue = [NSNumber numberWithFloat:M_PI * 4];
            anima.duration = 1.0f;
            anima.repeatCount = 1;
            [btn.layer addAnimation:anima forKey:@"rotateAnimation"];
        });
        // 继续执行一秒
        sleep(1.0);
    });
    
    dispatch_group_notify(group, queue, ^{
       
        lwHomeLiveVideoCustomCell *cell = (lwHomeLiveVideoCustomCell *)[[btn superview] superview];
        
        NSIndexPath *indexPath = [self.myCollectionView indexPathForCell:cell];
    
        lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section];
        
        /// 如果第一个section  要保证官方推荐的位置不变，所以先取出来
        
        if (indexPath.section == 0) {
            lwLiveModel *live = [[lwLiveModel alloc] init];
            // 取出第七条
            live = [partitions.lives objectAtIndex:6];
            [partitions.lives removeObjectAtIndex:6];
            
            // 重排数组的循序
            NSArray *result = [partitions.lives sortedArrayUsingComparator:^NSComparisonResult(lwLiveModel *  _Nonnull obj1, lwLiveModel *  _Nonnull obj2) {
                int seed = arc4random_uniform(2);
                return seed ? [obj1.title compare:obj2.title] : [obj2.title compare:obj1.title];
            }];
            
            partitions.lives = [NSMutableArray arrayWithArray:result];
            
            // 重新插入到数组中
            [partitions.lives insertObject:live atIndex:6];
            
        }else{
            // 重排数组的循序
            NSArray *result = [partitions.lives sortedArrayUsingComparator:^NSComparisonResult(lwLiveModel *  _Nonnull obj1, lwLiveModel *  _Nonnull obj2) {
                int seed = arc4random_uniform(2);
                return seed ? [obj1.title compare:obj2.title] : [obj2.title compare:obj1.title];
            }];
            
            partitions.lives = [NSMutableArray arrayWithArray:result];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        });
        
    });
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark - lwLiveVideoHeaderCellDelegate
- (void)iconButtonClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"全部分类"]) {
        [self pushController:@"lwAllCategoryVC" Completion:^(id controller) {
            [(UIViewController *)controller setHidesBottomBarWhenPushed:YES];
            [(UIViewController *)controller setTitle:@"全部分类"];
        }];
    }else{
        [self pushController:@"lwTestPageVC" Completion:^(id controller){
            [(UIViewController *)controller setHidesBottomBarWhenPushed:YES];
        }];
    }
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            lwHomeLiveHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwHeaderViewID forIndexPath:indexPath];
            headerView.delegate = self;
            [headerView configCell:self.liveVideoModel Style:lwHomeLiveHeaderViewStyleBannerWithMenu Completion:nil];
            return headerView;
        }else{
            lwHomeLiveHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwCustomHeaderViewID forIndexPath:indexPath];
            lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section];
            [headerView configCell:partitions.partitionModel Style:lwHomeLiveHeaderViewStyleTitle Completion:nil];
            return headerView;
        }
        
    }else{
        lwHomeLiveHeaderView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwFooterViewID forIndexPath:indexPath];
        return footerView;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    lwLiveVideoPartitionsModel *partitons = self.dataSource[section];
    if (section == 0) {
        return [partitons.lives count];
    }else{
        return [partitons.lives count] > 4 ? 4 : [partitons.lives count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwHomeLiveVideoCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwCustomCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

    WS(ws);
    
    lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section];
    
    if (indexPath.row < partitions.lives.count) {
        
        BOOL last = NO;
        
        if (indexPath.section == 0) {
            last = (indexPath.row == partitions.lives.count - 1) ? YES : NO;
        }else{
            last = (indexPath.row == 3) ? YES : NO;
        }
        
        [cell liveModel:partitions.lives[indexPath.row] Last:last Completion:^(id object) {
            // 刷新按钮
            [(UIButton *)object addTarget:ws action:@selector(refreshPartDataSource:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

#define padding 10
#define column  2

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 6) {
        return CGSizeMake(lW - 20, 150);
    }else{
        CGFloat width = (lW - (padding * 2) - ((column - 1) * padding)) / column;
        return CGSizeMake(width, 150);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, padding, padding, padding);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(lW, 255) : CGSizeMake(lW, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}


#pragma mark - loadView
- (void)setupView{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.myCollectionView];
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - getter
- (lwLiveVideoModel *)liveVideoModel{
    if (_liveVideoModel == nil) {
        _liveVideoModel = [[lwLiveVideoModel alloc] init];
    }
    return _liveVideoModel;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(lW / 2, 150);
        _flowLayout.headerReferenceSize = CGSizeMake(lW, 50);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)myCollectionView{
    if (_myCollectionView == nil) {
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        
        [self registCell:_myCollectionView];
        [self registReusableView:_myCollectionView];
    }
    return _myCollectionView;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}


@end

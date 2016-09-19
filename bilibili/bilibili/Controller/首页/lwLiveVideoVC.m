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

#import "lwHomeLiveVideoHeaderCell.h"
#import "lwHomeLiveVideoCustomCell.h"
#import "lwHomeLiveVideoHeaderView.h"

static NSString *lwHedaerCellID = @"cee";
static NSString *lwCustomCellID = @"dee";
static NSString *lwHeaderViewID = @"aee";
static NSString *lwCustomViewID = @"fee";
static NSString *lwFooterViewID = @"eee";

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
}

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
    
        lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section - 1];
        
        /// 如果第一个section  要保证官方推荐的位置不变，所以先取出来
        
        if (indexPath.section == 1) {
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
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwCustomViewID forIndexPath:indexPath];
            return headerView;
        }else{
            lwHomeLiveVideoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwHeaderViewID forIndexPath:indexPath];
            if (indexPath.section - 1 < [self.dataSource count]) {
                lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section - 1];
                [headerView setPartitionModel:partitions.partitionModel];
            }
            return headerView;
        }
        
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwFooterViewID forIndexPath:indexPath];
        return footerView;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        lwLiveVideoPartitionsModel *partitons = self.dataSource[section - 1];
        if (section == 1) {
            return [partitons.lives count];
        }else{
            return [partitons.lives count] > 4 ? 4 : [partitons.lives count];
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwHomeLiveVideoCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwCustomCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    lwHomeLiveVideoHeaderCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwHedaerCellID forIndexPath:indexPath];
    headerCell.delegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    
    WS(ws);
    
    if (indexPath.section == 0) {
        
        [headerCell setLiveVideo:self.liveVideoModel];
        
        return headerCell;
    }else{
        if (indexPath.section - 1 < [self.dataSource count]) {
            
            lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section - 1];
            
            if (indexPath.row < partitions.lives.count) {
                
                BOOL last = NO;
                
                if (indexPath.section == 1) {
                    last = (indexPath.row == partitions.lives.count - 1) ? YES : NO;
                }else{
                    last = (indexPath.row == 3) ? YES : NO;
                }
                
                [cell liveModel:partitions.lives[indexPath.row] Last:last Completion:^(id object) {
                    // 刷新按钮
                    [(UIButton *)object addTarget:ws action:@selector(refreshPartDataSource:) forControlEvents:UIControlEventTouchUpInside];
                }];
            }
        }
        
        return cell;
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(lW, 200);
    } if (indexPath.section == 1 && indexPath.row == 6) {
        return CGSizeMake(lW, 150);
    }else{
        return CGSizeMake(lW / 2, 150);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeZero : CGSizeMake(lW, 50);
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
        
        //cell
        [_myCollectionView registerClass:[lwHomeLiveVideoCustomCell class] forCellWithReuseIdentifier:lwCustomCellID];//普通cell
        [_myCollectionView registerClass:[lwHomeLiveVideoHeaderCell class] forCellWithReuseIdentifier:lwHedaerCellID];//HeaderCell
        
        // header
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwCustomViewID];
        [_myCollectionView registerClass:[lwHomeLiveVideoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwHeaderViewID];
        // footer
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwFooterViewID];
        
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

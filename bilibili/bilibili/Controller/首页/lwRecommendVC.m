//
//  lwRecommendVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//


#import "lwRecommendVC.h"

#import "lwRecommendBaseModel.h"

#import "lwHomeRecommendCell.h"
#import "lwHomeRecommendOperaCell.h"
#import "lwHomeRecommedActityCell.h"
#import "lwHomeRecommendLiveCell.h"
#import "lwHomeRecommendHeaderView.h"


#import "lwHomeRecommendFooterView.h"

static NSString *lwRecommendCellID = @"cee";
static NSString *lwRecommendActityCellID = @"edd";
static NSString *lwRecommendOperaCellID = @"oll";
static NSString *lwRecommendLiveCellID  = @"live";

static NSString *lwRecommendHeaderViewID = @"banner";
static NSString *lwRecommendHeaderCustomViewID = @"as";

static NSString *lwRecommendFooterViewID = @"footer";       //  标题
static NSString *lwRecommendOperaFooterViewID = @"opera";   //  番剧
static NSString *lwRecommendOperaWithBannerViewID = @"operaWithBanner";
static NSString *lwRecommendFooterCustomViewID = @"custom"; //  空白

@interface lwRecommendVC ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray <lwRecommendBaseModel *> *dataSource;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@end

@implementation lwRecommendVC

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

- (void)loadDataSource{
    self.dataSource = [NSMutableArray arrayWithArray:[lwRecommendBaseModel recommendSource]];
    [self.myCollectionView reloadData];
}


#pragma mark - 其实我觉得下面两段可以整合一下

- (void)registCell:(UICollectionView *)collectionView{
    [collectionView registerClass:[lwHomeRecommendCell class] forCellWithReuseIdentifier:lwRecommendCellID];
    [collectionView registerClass:[lwHomeRecommedActityCell class] forCellWithReuseIdentifier:lwRecommendActityCellID];
    [collectionView registerClass:[lwHomeRecommendOperaCell class] forCellWithReuseIdentifier:lwRecommendOperaCellID];
    [collectionView registerClass:[lwHomeRecommendLiveCell class] forCellWithReuseIdentifier:lwRecommendLiveCellID];
}

- (void)registHeaderOrFooter:(UICollectionView *)collectionView{
    [collectionView registerClass:[lwHomeRecommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwRecommendHeaderViewID];
    [collectionView registerClass:[lwHomeRecommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwRecommendHeaderCustomViewID];
    
    // footer
    [collectionView registerClass:[lwHomeRecommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendOperaFooterViewID];
    [collectionView registerClass:[lwHomeRecommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendFooterViewID];
    [collectionView registerClass:[lwHomeRecommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendOperaWithBannerViewID];
    [collectionView registerClass:[lwHomeRecommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendFooterCustomViewID];
}


- ( __kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath Model:(lwRecommendBaseModel *)model{
    BOOL last = indexPath.row == model.body.count - 1 ? YES : NO;
    if ([model.type isEqualToString:@"bangumi"]) {
        
        lwHomeRecommendOperaCell *operaCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendOperaCellID forIndexPath:indexPath];
        [operaCell recommendModel:model.body[indexPath.row] Last:last Completion:nil];
        return operaCell;
        
    }else if ([model.type isEqualToString:@"live"]){
        
        lwHomeRecommendLiveCell *liveCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendLiveCellID forIndexPath:indexPath];
        [liveCell liveModel:model.body[indexPath.row] Last:last Completion:nil];
        return liveCell;
        
    }else if ([model.type isEqualToString:@"activity"]){
        
        lwHomeRecommedActityCell *actityCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendActityCellID forIndexPath:indexPath];
        [actityCell actityModel:model Completion:nil];
        return actityCell;
        
    }else{
        
        lwHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendCellID forIndexPath:indexPath];
        [cell recommendModel:model.body[indexPath.row] Last:last Completion:^(id object) {
            
        }];
        return cell;
        
    }
}

- (__kindof UICollectionReusableView *)collectionHeaderView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath Model:(lwRecommendBaseModel *)model{
    if (model.banner.top.count != 0) {
        lwHomeRecommendHeaderView *headerWithBanner = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwRecommendHeaderViewID forIndexPath:indexPath];
        [headerWithBanner headerModel:model Type:lwHomeRecommendHeaderTypeTitleWithBanner Completion:nil];
        return headerWithBanner;
    }else{
        lwHomeRecommendHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwRecommendHeaderCustomViewID forIndexPath:indexPath];
        [header headerModel:model Type:lwHomeRecommendHeaderTypeTitle Completion:nil];
        return header;
    }
}

- (__kindof UICollectionReusableView *)collectionFooterView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath Model:(lwRecommendBaseModel *)model{
    
    if ([model.title isEqualToString:@"番剧推荐"]) {
        if (model.banner.bottom.count != 0) {
            // 番剧+banner
            lwHomeRecommendFooterView *operaWithBanner = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendOperaWithBannerViewID forIndexPath:indexPath];
            
            [operaWithBanner footerModel:model Type:lwHomeRecommendFooterTypeOperaWithBanner Completion:nil];
            return operaWithBanner;
        }else{
            
            // 番剧
            lwHomeRecommendFooterView *opera = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendOperaFooterViewID forIndexPath:indexPath];
            
            [opera footerModel:model Type:lwHomeRecommendFooterTypeOpera Completion:nil];
            return opera;
        }
    }else{
        if (model.banner.bottom.count != 0) {
            
            // 只有banner
            lwHomeRecommendFooterView *footerWithTitle = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendFooterViewID forIndexPath:indexPath];
            
            [footerWithTitle footerModel:model Type:lwHomeRecommendFooterTypeTitleWithBanner Completion:nil];
            return footerWithTitle;
        }else{

            // 空白
            lwHomeRecommendFooterView *customView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lwRecommendFooterCustomViewID forIndexPath:indexPath];
            
            [customView footerModel:model Type:lwHomeRecommendFooterTypeUsually Completion:nil];
            return customView;
        }
    }
}

- (void)refreshPartDataSource:(UIButton *)btn{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    
//    dispatch_group_async(group, queue, ^{
//        
        dispatch_async(dispatch_get_main_queue(), ^{
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            //绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
            anima.toValue = [NSNumber numberWithFloat:M_PI * 4];
            anima.duration = 1.0f;
            anima.repeatCount = 1;
            [btn.layer addAnimation:anima forKey:@"rotateAnimation"];
        });
        // 继续执行一秒
//        sleep(1.0);
//    });
//    
//    dispatch_group_notify(group, queue, ^{
//        
//        lwHomeLiveVideoCustomCell *cell = (lwHomeLiveVideoCustomCell *)[[btn superview] superview];
//        
//        NSIndexPath *indexPath = [self.myCollectionView indexPathForCell:cell];
//        
//        lwLiveVideoPartitionsModel *partitions = self.dataSource[indexPath.section - 1];
//        
//        /// 如果第一个section  要保证官方推荐的位置不变，所以先取出来
//        
//        if (indexPath.section == 1) {
//            lwLiveModel *live = [[lwLiveModel alloc] init];
//            // 取出第七条
//            live = [partitions.lives objectAtIndex:6];
//            [partitions.lives removeObjectAtIndex:6];
//            
//            // 重排数组的循序
//            NSArray *result = [partitions.lives sortedArrayUsingComparator:^NSComparisonResult(lwLiveModel *  _Nonnull obj1, lwLiveModel *  _Nonnull obj2) {
//                int seed = arc4random_uniform(2);
//                return seed ? [obj1.title compare:obj2.title] : [obj2.title compare:obj1.title];
//            }];
//            
//            partitions.lives = [NSMutableArray arrayWithArray:result];
//            
//            // 重新插入到数组中
//            [partitions.lives insertObject:live atIndex:6];
//            
//        }else{
//            // 重排数组的循序
//            NSArray *result = [partitions.lives sortedArrayUsingComparator:^NSComparisonResult(lwLiveModel *  _Nonnull obj1, lwLiveModel *  _Nonnull obj2) {
//                int seed = arc4random_uniform(2);
//                return seed ? [obj1.title compare:obj2.title] : [obj2.title compare:obj1.title];
//            }];
//            
//            partitions.lives = [NSMutableArray arrayWithArray:result];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.myCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
//        });
//        
//    });
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    lwRecommendBaseModel *baseModel = (lwRecommendBaseModel *)self.dataSource[section];
    if ([baseModel.type isEqualToString:@"activity"]) {
        return 1;
    }else{
        return baseModel.body.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    lwRecommendBaseModel *model = self.dataSource[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [self collectionHeaderView:collectionView IndexPath:indexPath Model:model];
    }else{
        return [self collectionFooterView:collectionView IndexPath:indexPath Model:model];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self collectionView:collectionView IndexPath:indexPath Model:self.dataSource[indexPath.section]];
}


#pragma mark - UICollectionViewDelegateFlowLayout

#define padding 10

- (CGSize)collectionItemSize:(lwRecommendBaseModel *)model{
    CGFloat column;
    if ([model.type isEqualToString:@"bangumi"]) {
       column = 2;
    }else if ([model.type isEqualToString:@"live"]){
        column = 2;
    }else if ([model.type isEqualToString:@"activity"]){
        column = 1;
    }else{
        column = 2;
    }
    CGFloat width = (lW - (padding * 2) - ((column - 1) * padding)) / column;
    return CGSizeMake(width, 150);
}

- (CGSize)collectionHeaderViewSize:(lwRecommendBaseModel *)model{
    if (model.banner.top.count != 0) {
        return CGSizeMake(lW, 160);
    }else{
        return CGSizeMake(lW, 40);
    }
}

- (CGSize)collectionFooterViewSize:(lwRecommendBaseModel *)model{
    if ([model.title isEqualToString:@"番剧推荐"]) {
        if (model.banner.bottom.count != 0) {
            return CGSizeMake(lW, 230);
        }else{
            return CGSizeMake(lW, 60);
        }
    }else{
        if (model.banner.bottom.count != 0) {
            return CGSizeMake(lW, 170);
        }else{
            return CGSizeMake(lW, 0);
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(padding, padding, padding, padding);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwRecommendBaseModel *model = self.dataSource[indexPath.section];
    return [self collectionItemSize:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    lwRecommendBaseModel *model = self.dataSource[section];
    return [self collectionHeaderViewSize:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    lwRecommendBaseModel *model = self.dataSource[section];
    return [self collectionFooterViewSize:model];
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
        [self registCell:_myCollectionView];
        [self registHeaderOrFooter:_myCollectionView];
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

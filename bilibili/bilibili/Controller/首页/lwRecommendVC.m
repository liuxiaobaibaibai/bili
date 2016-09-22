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
#import "lwHomeLiveVideoCustomCell.h"

static NSString *lwRecommendCellID = @"cee";
static NSString *lwRecommendActityCellID = @"edd";
static NSString *lwRecommendOperaCellID = @"oll";
static NSString *lwRecommendLiveCellID  = @"live";

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

- (void)loadDataSource{
    self.dataSource = [NSMutableArray arrayWithArray:[lwRecommendBaseModel recommendSource]];
    [self.myCollectionView reloadData];
}


#pragma mark - 其实我觉得下面两段可以整合一下

- (void)registCell:(UICollectionView *)collectionView{
    [collectionView registerClass:[lwHomeRecommendCell class] forCellWithReuseIdentifier:lwRecommendCellID];
    [collectionView registerClass:[lwHomeRecommedActityCell class] forCellWithReuseIdentifier:lwRecommendActityCellID];
    [collectionView registerClass:[lwHomeRecommendOperaCell class] forCellWithReuseIdentifier:lwRecommendOperaCellID];
    [collectionView registerClass:[lwHomeLiveVideoCustomCell class] forCellWithReuseIdentifier:lwRecommendLiveCellID];
}

- (CGSize)collectionItemSize:(lwRecommendBaseModel *)model{
    if ([model.type isEqualToString:@"bangumi"]) {
        return CGSizeMake(lW / 2, 150);
    }else if ([model.type isEqualToString:@"live"]){
        return CGSizeMake(lW / 2, 150);
    }else if ([model.type isEqualToString:@"activity"]){
        return CGSizeMake(lW, 150);
    }else{
        return CGSizeMake(lW / 2, 150);
    }
}

- ( __kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath Model:(lwRecommendBaseModel *)model{
    
    lwHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendCellID forIndexPath:indexPath];
    lwHomeRecommedActityCell *actityCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendActityCellID forIndexPath:indexPath];
    lwHomeRecommendOperaCell *operaCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendOperaCellID forIndexPath:indexPath];
    lwHomeLiveVideoCustomCell *liveCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendLiveCellID forIndexPath:indexPath];
    
    BOOL last = indexPath.row == model.body.count - 1 ? YES : NO;
    
    if ([model.type isEqualToString:@"bangumi"]) {
        [operaCell recommendModel:model.body[indexPath.row] Last:last Completion:^(id object) {
            NSLog(@"nsl");
        }];
        return operaCell;
    }else if ([model.type isEqualToString:@"live"]){
        return liveCell;
    }else if ([model.type isEqualToString:@"activity"]){
        [actityCell actityModel:model Completion:^(id object) {
            
        }];
        return actityCell;
    }else{
        [cell recommendModel:model.body[indexPath.row] Last:last Completion:^(id object) {
            
        }];
        return cell;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    lwHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwRecommendCellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//    
//    lwRecommendBaseModel *baseModel = (lwRecommendBaseModel *)self.dataSource[indexPath.section];
//    
//    WS(ws);
//    
//    [cell recommendModel:baseModel.body[indexPath.row] Last:(indexPath.row == baseModel.body.count - 1) Completion:^(id object) {
//        [(UIButton *)object addTarget:ws action:@selector(refreshPartDataSource:) forControlEvents:UIControlEventTouchUpInside];
//    }];
//    return cell;
    return [self collectionView:collectionView IndexPath:indexPath Model:self.dataSource[indexPath.section]];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(lW / 2, 150);
    lwRecommendBaseModel *model = self.dataSource[indexPath.section];
    return [self collectionItemSize:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
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

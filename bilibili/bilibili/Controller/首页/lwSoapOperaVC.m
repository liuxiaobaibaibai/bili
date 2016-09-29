//
//  lwSoapOperaVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSoapOperaVC.h"
#import "lwOperaBaseModel.h"
#import "lwHomeOperaCustomCell.h"
#import "lwHomeOperaRecommendCell.h"
#import "lwOperaHeaderView.h"


// 三种cell
NSString *const lwOperaSerializingCellID = @"cellSerializing";
NSString *const lwOperaPreviousCellID = @"cellPrevious";
NSString *const lwOperaRecommendCellID = @"recommend";

NSString *const lwOperaTopHeadViewID = @"header";
NSString *const lwOperaCustomHeadViewID = @"header1";

@interface lwSoapOperaVC ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) lwOperaBaseModel *baseModel;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation lwSoapOperaVC

#pragma mark - private method
- (void)loadDataSource{
    self.baseModel = [lwOperaBaseModel operaSource];
    [self.myCollectionView reloadData];
}

#pragma mark - cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
}

#pragma mark - 其实我觉得下面两段可以整合一下
- (void)registCell:(UICollectionView *)collectionView{
    [collectionView registerClass:[lwHomeOperaCustomCell class] forCellWithReuseIdentifier:lwOperaSerializingCellID];
    [collectionView registerClass:[lwHomeOperaCustomCell class] forCellWithReuseIdentifier:lwOperaPreviousCellID];
    [collectionView registerClass:[lwHomeOperaRecommendCell class] forCellWithReuseIdentifier:lwOperaRecommendCellID];
    
}

- (void)registHeaderOrFooter:(UICollectionView *)collectionView{
    [collectionView registerClass:[lwOperaHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwOperaTopHeadViewID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lwOperaCustomHeadViewID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}


- (__kindof UICollectionViewCell *)configCell:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            lwPreviousListModel *model = [[lwPreviousListModel alloc] init];
            if (indexPath.row < self.baseModel.serializing.count) {
                model = self.baseModel.serializing[indexPath.row];
            }
            lwHomeOperaCustomCell *serailizingCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwOperaSerializingCellID forIndexPath:indexPath];
            [serailizingCell operaModel:model Style:lwHomeOperaCustomCellStyleSerializing];
            return serailizingCell;
        }
            break;
        case 1:
        {
            lwPreviousListModel *model = [[lwPreviousListModel alloc] init];
            if (indexPath.row < self.baseModel.previous.list.count) {
                model = self.baseModel.previous.list[indexPath.row];
            }
            lwHomeOperaCustomCell *previousCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwOperaPreviousCellID forIndexPath:indexPath];
            [previousCell operaModel:model Style:lwHomeOperaCustomCellStylePrevious];
            return previousCell;
        }
            break;
        default:
        {
            lwOperaRecommendModel *model = [lwOperaRecommendModel new];
            if (indexPath.row < self.baseModel.recommend.count) {
                model = self.baseModel.recommend[indexPath.row];
            }
            lwHomeOperaRecommendCell *recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:lwOperaRecommendCellID forIndexPath:indexPath];
            [recommendCell setRecommendModel:model];
            return recommendCell;
        }
            break;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showToast:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section != 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwOperaCustomHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor randomColor];
            return headerView;
        }else{
            lwOperaHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:lwOperaTopHeadViewID forIndexPath:indexPath];
            header.operaModel = self.baseModel;
            return header;
        }
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footer;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.baseModel.serializing.count;
            break;
        case 1:
            return self.baseModel.previous.list.count;
            break;
        default:
            return self.baseModel.recommend.count;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self configCell:collectionView AtIndexPath:indexPath];
}


#pragma mark - UICollectionViewDelegateFlowLayout

#define padding 10
#define column  3

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
     item size的计算公式
     先说明一下概念
     1、sectionInset             每个section 之间的间距 该距离只计算每个section  上下左右的边距
     2、minimumLineSpacing       section内部每行item之间的间距
     3、minimumInteritemSpacing  section内部每列item之间的间距
     总结：
     要想平均item的间距和宽度的话
     item宽度 = (屏幕宽度 - sectionInset的左右边距 - ((列 - 1) * 列间距))) / 列
     */
    CGFloat width = (lW - (padding * 2) - ((column - 1) * padding)) / column;
    return (indexPath.section == 0 || indexPath.section == 1) ? CGSizeMake(width, 200) : CGSizeMake(lW - 20, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, padding, padding, padding);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(lW, 280) : CGSizeMake(lW, 40);
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
        _flowLayout.minimumLineSpacing = padding;
        _flowLayout.minimumInteritemSpacing = padding;
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

@end

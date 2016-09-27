//
//  lwSoapOperaVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSoapOperaVC.h"
#import "lwOperaBaseModel.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - 其实我觉得下面两段可以整合一下
static NSString *lwOperaCustomCellID = @"cell";
- (void)registCell:(UICollectionView *)collectionView{
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:lwOperaCustomCellID];
}

- (void)registHeaderOrFooter:(UICollectionView *)collectionView{
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showToast:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lwOperaCustomCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

#define padding 10
#define column  5

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
    
    switch (indexPath.row) {
        case 5:
        {
            CGFloat width = (lW - (padding * 2));
            return  CGSizeMake(width, 130);
        }
            break;
        default:
        {
            CGFloat width = (lW - (padding * 2) - ((column - 1) * padding)) / column;
            return  CGSizeMake(width, width);
        }
            break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(padding, padding, 0, padding);
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

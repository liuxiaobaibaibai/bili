//
//  lwMineVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineVC.h"
#import "UIImage+lwImage.h"

#import "lwPersonalMenuCell.h"
#import "lwCategoryModel.h"

static NSString *commonCellID = @"cell";
static NSString *commonHeaderID = @"header";
static NSString *commonFooterID = @"footer";

@interface lwMineVC ()

<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UIButton *setBtn;

@property (strong, nonatomic) UIImageView *headerIconView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIImageView *vipLevelView;

@property (strong, nonatomic) UIImageView *genderView;

@property (strong, nonatomic) UIButton *identityLabel;

@property (strong, nonatomic) UILabel *balanceLabel;

@property (strong, nonatomic) UIImageView *detailView;

@property (strong, nonatomic) UICollectionView *myCollectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (copy, nonatomic) NSArray *dataSource;


@property (strong, nonatomic) UICollectionReusableView *headerReusableView;

@property (strong, nonatomic) UICollectionReusableView *footerReusableView;

@end

@implementation lwMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadDataSource];
    
    
    NSLog(@"%@",[lwMineVC paramValueOfUrl:@"http://www.juyingbao.cn/index.php?g=Wap&m=Login&a=personal&token=&wecha_id=&code=011kwzQM0f2IQh2oVkRM0OoxQM0kwzQb&state=" withParam:@"a"]);
    
}

+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setBackgroundColor:[UIColor biliPinkColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - private method
- (void)loadDataSource{
    self.dataSource = [NSArray arrayWithArray:[lwCategoryModel personalMenu]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwPersonalMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commonCellID forIndexPath:indexPath];
    [cell setCategoryModel:self.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        _headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:commonHeaderID forIndexPath:indexPath];
        
        _headerReusableView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, lW - 15, 40)];
        
        if (indexPath.section == 0) {
            titleLabel.text = @"个人中心";
        }else{
            titleLabel.text = @"我的消息";
        }
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, lW, 1)];
        line.backgroundColor = RGB(235, 235, 235);
        
        [_headerReusableView addSubview:titleLabel];
        [_headerReusableView addSubview:line];
        
        return _headerReusableView;
    }else{
        _footerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:commonFooterID forIndexPath:indexPath];
        _footerReusableView.backgroundColor = [UIColor clearColor];
        return _footerReusableView;
    }
}

#pragma mark - setupView
- (void)setupView{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view addSubview:self.headerView];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, lW, lH - lTabbarH - 140)];
    myScrollView.backgroundColor = [UIColor biliPinkColor];
    [myScrollView setContentSize:CGSizeMake(lW, lH - 140)];
    myScrollView.scrollEnabled = YES;
    myScrollView.layer.cornerRadius = 5.0;
    myScrollView.layer.masksToBounds = YES;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];

    self.myCollectionView.frame = CGRectMake(0, 0, lW, lH * 2);
    [myScrollView addSubview:self.myCollectionView];
    
    WS(ws);
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(140);
    }];
}

#pragma mark - getter

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (UIButton *)setBtn{
    if (_setBtn == nil) {
        _setBtn = [[UIButton alloc] init];
        [_setBtn setImage:[UIImage imageNamed:@"mine_settings"] forState:UIControlStateNormal];
    }
    return _setBtn;
}

- (UIImageView *)headerIconView{
    if (_headerIconView == nil) {
        _headerIconView = [[UIImageView alloc] init];
        [_headerIconView setImage:[UIImage addImage:[UIImage imageNamed:@"misc_avatarDefault"] toImage:[UIImage imageNamed:@"mine_bg_avatar"]]];
    }
    return _headerIconView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"abbbbbbli";
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _nameLabel;
}

- (UIImageView *)vipLevelView{
    if (_vipLevelView == nil) {
        _vipLevelView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_level_colorfulLv2"]];
    }
    return _vipLevelView;
}

- (UIImageView *)genderView{
    if (_genderView == nil) {
        _genderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_sex_sox"]];
    }
    return _genderView;
}

- (UIButton *)identityLabel{
    if (_identityLabel == nil) {
        _identityLabel = [[UIButton alloc] init];
        _identityLabel.titleLabel.textColor = [UIColor whiteColor];
        _identityLabel.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_identityLabel setTitle:@" 正式会员 " forState:UIControlStateNormal];
        _identityLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _identityLabel.layer.borderWidth = 1.0;
        _identityLabel.layer.cornerRadius = 5.0;
        _identityLabel.layer.masksToBounds = YES;
    }
    return _identityLabel;
}

- (UILabel *)balanceLabel{
    if (_balanceLabel == nil) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.textColor = [UIColor whiteColor];
        _balanceLabel.font = [UIFont systemFontOfSize:12.0];
        _balanceLabel.text = @"硬币：26.0";
    }
    return _balanceLabel;
}

- (UIImageView *)detailView{
    if (_detailView == nil) {
        _detailView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_rightArrowGray"]];
    }
    return _detailView;
}

/**************************************/

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor biliPinkColor];
        
        [_headerView addSubview:self.setBtn];
        [_headerView addSubview:self.headerIconView];
        [_headerView addSubview:self.nameLabel];
        [_headerView addSubview:self.vipLevelView];
        [_headerView addSubview:self.genderView];
        [_headerView addSubview:self.identityLabel];
        [_headerView addSubview:self.balanceLabel];
        [_headerView addSubview:self.detailView];
        
        WS(ws);
        
        [_setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [_headerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.headerIconView.mas_right).offset(20);
            make.top.equalTo(ws.headerIconView);
        }];
        
        [_vipLevelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.nameLabel.mas_right).offset(10);
            make.centerY.equalTo(ws.nameLabel);
            make.size.mas_equalTo(CGSizeMake(15, 10));
        }];
        
        [_genderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.vipLevelView.mas_right).offset(10);
            make.centerY.equalTo(ws.vipLevelView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        [_identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.nameLabel);
            make.top.mas_equalTo(ws.nameLabel.mas_bottom).offset(5);
        }];
        
        [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.nameLabel);
            make.top.mas_equalTo(ws.identityLabel.mas_bottom).offset(5);
            make.bottom.equalTo(ws.headerIconView);
        }];
        
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.centerY.equalTo(ws.headerIconView);
        }];
        
    }
    return _headerView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(lW / 4 - 0.5 , 95 - 1);
        _flowLayout.headerReferenceSize = CGSizeMake(lW, 40);
        _flowLayout.footerReferenceSize = CGSizeMake(lW, 10);
        _flowLayout.minimumLineSpacing = 1;
        _flowLayout.minimumInteritemSpacing = 0.5;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (UICollectionView *)myCollectionView{
    if (_myCollectionView == nil) {
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = RGB(235, 235, 235);
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.layer.cornerRadius = 10.0;
        _myCollectionView.layer.masksToBounds = YES;
        _myCollectionView.backgroundView.layer.cornerRadius = 10.0;
        _myCollectionView.backgroundView.layer.masksToBounds = YES;
        _myCollectionView.alwaysBounceVertical = YES;
        
        [_myCollectionView registerClass:[lwPersonalMenuCell class] forCellWithReuseIdentifier:commonCellID];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:commonHeaderID];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:commonFooterID];
    }
    return _myCollectionView;
}

@end

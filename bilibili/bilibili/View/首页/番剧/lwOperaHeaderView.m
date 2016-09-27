//
//  lwOperaHeaderView.m
//  bilibili
//
//  Created by 刘威 on 16/9/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwOperaHeaderView.h"
#import "lwScrollView.h"
#import "lwIconButton.h"


@interface lwOperaHeaderView ()

<lwScrollViewDelegate>

@property (strong, nonatomic) lwScrollView *bannerView;
@property (copy, nonatomic) NSArray <NSDictionary *> *categories;
@property (copy, nonatomic) NSArray *menus;

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIImageView *detailView;

@end

@implementation lwOperaHeaderView

#pragma mark - private method

#pragma mark - lwScrollViewDelegate
- (void)flashClick:(id)sender Index:(NSInteger)index{
    
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mark - 
- (void)loadView{
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    WS(ws);
    
    [self addSubview:self.bannerView];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.detailView];
    
    __block lwIconButton *lastIconBtn = nil;
    [self.categories enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imagePath = [[obj allKeys] firstObject];
        NSString *title = [[obj allValues] firstObject];
        
        lwIconButton *iconBtn = [[lwIconButton alloc] init];
        [iconBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [iconBtn.iconView setImage:[UIImage imageNamed:imagePath]];
        [iconBtn.titleLabel setText:title];
        
        [ws addSubview:iconBtn];
        
        [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.bannerView.mas_bottom).offset(10);
            make.width.mas_equalTo(lW / 4);
            make.height.mas_equalTo(70);
            if (lastIconBtn) {
                make.left.mas_equalTo(lastIconBtn.mas_right);
            }else{
                make.left.mas_equalTo(0);
            }
        }];
        
        lastIconBtn = iconBtn;
    }];
    
    __block UIButton *lastBtn = nil;
    [self.menus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgPath = [NSString stringWithFormat:@"%@",obj];
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
        [btn.layer setCornerRadius:5.0];
        [btn.layer setMasksToBounds:YES];
        [ws addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastIconBtn.mas_bottom).offset(10);
            make.width.mas_equalTo((lW - 40) / 3);
            make.height.mas_equalTo(40);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(10);
            }else{
                make.left.mas_equalTo(10);
            }
        }];
        
        lastBtn = btn;
    }];
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(120);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(lastBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.bottom.mas_equalTo(-10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.iconView.mas_right);
        make.centerY.equalTo(ws.iconView);
        make.height.mas_equalTo(ws.iconView);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel.mas_right);
        make.width.mas_equalTo(100);
        make.height.equalTo(ws.iconView);
        make.centerY.equalTo(ws.iconView);
    }];
    
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.subtitleLabel.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(ws.iconView);
        make.size.mas_equalTo(ws.iconView);
    }];
}

#pragma mark - getter
- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textColor = [UIColor lightGrayColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        _subtitleLabel.text = @"更多连载";
    }
    return _subtitleLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"新番连载";
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_region_icon_11"]];
    }
    return _iconView;
}

- (UIImageView *)detailView{
    if (_detailView == nil) {
        _detailView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_openMore"]];
    }
    return _detailView;
}

- (lwScrollView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[lwScrollView alloc] initWithFrame:CGRectZero DataSource:self.menus Delegate:self];
        _bannerView.sourceIsLocal = YES;
    }
    return _bannerView;
}

- (NSArray <NSDictionary *> *)categories{
    if (_categories == nil) {
        _categories = @[@{@"bangumi_finished":@"连载动画"},@{@"bangumi_unfinished":@"完结动画"},@{@"bangumi_domestic":@"国产动画"},@{@"bangumi_extend":@"官方延伸"}];
    }
    return _categories;
}

- (NSArray *)menus{
    if (_menus == nil) {
        _menus = @[@"home_bangumi_category_new",@"home_bangumi_timeline_new",@"home_bangumi_recommend_new"];
    }
    return _menus;
}

- (NSString *)titleValueForKey:(NSString *)titile{
    NSDictionary *info = @{@"热门焦点":@"排行榜",
                           @"热门直播":@"直播",
                           @"番剧推荐":@"番剧",
                           @"动画区":@"动画",
                           @"音乐区":@"音乐",
                           @"舞蹈区":@"舞蹈",
                           @"游戏区":@"舞蹈",
                           @"鬼畜区":@"鬼畜",
                           @"科技区":@"科技",
                           @"活动中心":@"活动",
                           @"生活区":@"生活",
                           @"时尚区":@"时尚",
                           @"广告区":@"广告",
                           @"娱乐区":@"娱乐",
                           @"电视剧区":@"电视剧",
                           @"电影区":@"电影"};
    return info[titile];
}

- (NSString *)imageValueForKey:(NSString *)imageName{
    NSDictionary *info = @{@"热门焦点":@"home_region_icon_11",
                           @"热门直播":@"home_region_icon_11",
                           @"番剧推荐":@"home_region_icon_11",
                           @"动画区":@"home_region_icon_11",
                           @"音乐区":@"home_region_icon_11",
                           @"舞蹈区":@"home_region_icon_11",
                           @"游戏区":@"home_region_icon_11",
                           @"鬼畜区":@"home_region_icon_11",
                           @"科技区":@"home_region_icon_11",
                           @"活动中心":@"home_region_icon_11",
                           @"生活区":@"home_region_icon_11",
                           @"时尚区":@"home_region_icon_11",
                           @"广告区":@"home_region_icon_11",
                           @"娱乐区":@"home_region_icon_11",
                           @"电视剧区":@"home_region_icon_11",
                           @"电影区":@"home_region_icon_11"};
    return info[imageName];
}

@end



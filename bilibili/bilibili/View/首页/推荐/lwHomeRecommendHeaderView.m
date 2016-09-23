//
//  lwHomeRecommendHeaderView.m
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendHeaderView.h"

#import "lwScrollView.h"
#import "lwRecommendBaseModel.h"

@interface lwHomeRecommendHeaderView ()

@property (strong, nonatomic) lwScrollView *bannerView;

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIImageView *detailView;

@end

@implementation lwHomeRecommendHeaderView

#pragma private method

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

- (void)headerModel:(lwRecommendBaseModel *)model Type:(lwHomeRecommendHeaderType)type Completion:(void (^)(id object))completion{
    _headerModel = model;
    [self remarkLayout:type];
    switch (type) {
        case lwHomeRecommendHeaderTypeTitle:
        {
            [self.titleLabel setText:model.title];
            if ([model.title isEqualToString:@"热门焦点"]) {
                [_subtitleLabel setText:@"排行榜"];
            }else if ([model.title isEqualToString:@"热门直播"]) {
                [_subtitleLabel setText:@"当前1492个直播"];
            }else{
                [_subtitleLabel setText:[NSString stringWithFormat:@"更多%@",[self titleValueForKey:model.title]]];
            }
        }
            break;
        case lwHomeRecommendHeaderTypeBanner:
        {
            NSMutableArray *flash = [NSMutableArray new];
            for (lwRecommendHeaderModel *header in model.banner.top) {
                [flash addObject:header.image];
            }
            [self.bannerView setFlashs:flash];
        }
            break;
        case lwHomeRecommendHeaderTypeTitleWithBanner:
        {
            NSMutableArray *flash = [NSMutableArray new];
            for (lwRecommendHeaderModel *header in model.banner.top) {
                [flash addObject:header.image];
            }
            [self.bannerView setFlashs:flash];
            self.iconView.image = [UIImage imageNamed:[self imageValueForKey:model.title]];
            
            [self.titleLabel setText:model.title];
            if ([model.title isEqualToString:@"热门推荐"]) {
                [_subtitleLabel setText:@"排行榜"];
            }else if ([model.title isEqualToString:@"推荐直播"]) {
                [_subtitleLabel setText:@"当前1492个直播"];
            }else{
                [_subtitleLabel setText:[NSString stringWithFormat:@"更多%@",[self titleValueForKey:model.title]]];
            }
        }
            break;
        default:
            // 没有东西
            [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            break;
    }
}

- (void)remarkLayout:(lwHomeRecommendHeaderType)type{
    
    WS(ws);
    
    switch (type) {
        case lwHomeRecommendHeaderTypeTitle:
        {
            [_bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(ws);
                make.height.mas_equalTo(0);
            }];
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(ws.bannerView.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
                make.bottom.mas_equalTo(-10);
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.iconView.mas_right);
                make.centerY.equalTo(ws.iconView);
                make.height.mas_equalTo(ws.iconView);
            }];
            
            [_subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.titleLabel.mas_right);
                make.width.mas_equalTo(100);
                make.height.equalTo(ws.iconView);
                make.centerY.equalTo(ws.iconView);
            }];
            
            [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.subtitleLabel.mas_right).offset(10);
                make.right.mas_equalTo(-10);
                make.centerY.equalTo(ws.iconView);
                make.size.mas_equalTo(ws.iconView);
            }];
        }
            break;
        case lwHomeRecommendHeaderTypeBanner:
        {
            [_bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(ws);
                make.height.mas_equalTo(120);
            }];
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(ws.bannerView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.bottom.mas_equalTo(-10);
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.iconView.mas_right);
                make.centerY.equalTo(ws.iconView);
                make.height.mas_equalTo(ws.iconView);
            }];
            
            [_subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.titleLabel.mas_right);
                make.width.mas_equalTo(100);
                make.height.equalTo(ws.iconView);
                make.centerY.equalTo(ws.iconView);
            }];
            
            [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.subtitleLabel.mas_right).offset(10);
                make.right.mas_equalTo(-10);
                make.centerY.equalTo(ws.iconView);
                make.size.mas_equalTo(ws.iconView);
            }];
        }
            break;
        case lwHomeRecommendHeaderTypeTitleWithBanner:
        {
            [_bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(ws);
                make.height.mas_equalTo(120);
            }];
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(ws.bannerView.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
                make.bottom.mas_equalTo(-10);
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.iconView.mas_right);
                make.centerY.equalTo(ws.iconView);
                make.height.mas_equalTo(ws.iconView);
            }];
            
            [_subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.titleLabel.mas_right);
                make.width.mas_equalTo(100);
                make.height.equalTo(ws.iconView);
                make.centerY.equalTo(ws.iconView);
            }];
            
            [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.subtitleLabel.mas_right).offset(10);
                make.right.mas_equalTo(-10);
                make.centerY.equalTo(ws.iconView);
                make.size.mas_equalTo(ws.iconView);
            }];
        }
            break;
        default:
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            break;
    }
    [self layoutIfNeeded];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mark - loadView
- (void)loadView{
    [self addSubview:self.bannerView];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.detailView];
    
    WS(ws);
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(120);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(ws.bannerView.mas_bottom).offset(10);
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
    }
    return _subtitleLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
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
        _bannerView = [[lwScrollView alloc] initWithFrame:CGRectZero DataSource:@[] Delegate:self];
    }
    return _bannerView;
}

@end

//
//  lwHomeRecommendFooterView.m
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendFooterView.h"

#import "lwScrollView.h"
#import "lwRecommendBaseModel.h"

@interface lwHomeRecommendFooterView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIImageView *detailView;
@property (strong, nonatomic) lwScrollView *bannerView;


@property (strong, nonatomic) UIButton *indexBtn;
@property (strong, nonatomic) UIButton *broadcastBtn;

@end

@implementation lwHomeRecommendFooterView



#pragma mark - private method
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

- (void)footerModel:(lwRecommendBaseModel *)model Type:(lwHomeRecommendFooterType)type Completion:(void (^)(id))completion{
    _footerModel = model;

    [self remarkLayout:type];
    switch (type) {
        case lwHomeRecommendFooterTypeOpera:
        {
            
        }
            break;
        case lwHomeRecommendFooterTypeOperaWithBanner:
        {
            NSMutableArray *flash = [NSMutableArray new];
            for (lwRecommendHeaderModel *footer in model.banner.bottom) {
                [flash addObject:footer.image];
            }
            [self.bannerView setFlashs:flash];
            self.iconView.image = [UIImage imageNamed:[self imageValueForKey:model.title]];
        }
            break;
        case lwHomeRecommendFooterTypeTitleWithBanner:
        {
            NSMutableArray *flash = [NSMutableArray new];
            for (lwRecommendHeaderModel *footer in model.banner.bottom) {
                [flash addObject:footer.image];
            }
            [self.bannerView setFlashs:flash];
            self.iconView.image = [UIImage imageNamed:[self imageValueForKey:model.title]];
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


- (void)remarkLayout:(lwHomeRecommendFooterType)type{
    
    WS(ws);
    
    switch (type) {
        case lwHomeRecommendFooterTypeOpera:
        {
            // 去掉
            [_indexBtn setHidden:NO];
            [_broadcastBtn setHidden:NO];
            [_iconView setHidden:YES];
            [_titleLabel setHidden:YES];
            [_subtitleLabel setHidden:YES];
            [_detailView setHidden:YES];
            [_bannerView setHidden:YES];
            
            
            [_broadcastBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.equalTo(ws);
                make.height.mas_equalTo(40);
            }];
            
            [_indexBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.broadcastBtn.mas_right).offset(10);
                make.right.mas_equalTo(-10);
                make.height.width.mas_equalTo(ws.broadcastBtn);
                make.centerY.equalTo(ws);
            }];
        }
            break;
        case lwHomeRecommendFooterTypeOperaWithBanner:
        {
            [_indexBtn setHidden:NO];
            [_broadcastBtn setHidden:NO];
            [_iconView setHidden:NO];
            [_titleLabel setHidden:NO];
            [_subtitleLabel setHidden:NO];
            [_detailView setHidden:NO];
            [_bannerView setHidden:NO];
            
            [_broadcastBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
                make.height.mas_equalTo(40);
            }];
            
            [_indexBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.broadcastBtn.mas_right).offset(10);
                make.right.mas_equalTo(10);
                make.size.mas_equalTo(ws.broadcastBtn);
                make.centerY.equalTo(ws.broadcastBtn);
            }];
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
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
            
            [_bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ws.iconView.mas_bottom).offset(10);
                make.left.right.equalTo(ws);
                make.height.mas_equalTo(120);
                make.bottom.mas_equalTo(-10);
            }];
        }
            break;
        case lwHomeRecommendFooterTypeTitleWithBanner:
        {
            [_broadcastBtn setHidden:YES];
            [_indexBtn setHidden:YES];
            [_iconView setHidden:NO];
            [_titleLabel setHidden:NO];
            [_subtitleLabel setHidden:NO];
            [_detailView setHidden:NO];
            [_bannerView setHidden:NO];
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
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
            
            [_bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ws.iconView.mas_bottom).offset(10);
                make.left.right.equalTo(ws);
                make.height.mas_equalTo(120);
                make.bottom.mas_equalTo(-10);
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
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    // 番剧
    [self addSubview:self.indexBtn];
    [self addSubview:self.broadcastBtn];
    // 普通
    [self addSubview:self.bannerView];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.detailView];
    
    WS(ws);

    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
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
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(10);
        make.left.right.equalTo(ws);
        make.height.mas_equalTo(120);
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark - getter
- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textColor = [UIColor lightGrayColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        [_subtitleLabel setText:@"更多话题"];
    }
    return _subtitleLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel setText:@"话题中心"];
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

// 番剧
- (UIButton *)broadcastBtn{
    if (_broadcastBtn == nil) {
        _broadcastBtn = [[UIButton alloc] init];
        [_broadcastBtn setImage:[UIImage imageNamed:@"home_bangumi_timeline"] forState:UIControlStateNormal];
    }
    return _broadcastBtn;
}

- (UIButton *)indexBtn{
    if (_indexBtn == nil) {
        _indexBtn = [[UIButton alloc] init];
        [_indexBtn setImage:[UIImage imageNamed:@"home_bangumi_category"] forState:UIControlStateNormal];
    }
    return _indexBtn;
}

@end

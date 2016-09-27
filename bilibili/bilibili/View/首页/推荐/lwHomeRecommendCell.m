//
//  lwHomeRecommendCell.m
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendCell.h"

#import "lwRecommendBaseModel.h"

#define padding 5

@interface lwHomeRecommendCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIImageView *shadowView;

@property (strong, nonatomic) UIImageView *shadowBottomView;

@property (strong, nonatomic) UIButton *playCountLabel;

@property (strong, nonatomic) UIButton *danmakuCountLabel;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *refreshBtn;

@end

@implementation lwHomeRecommendCell

#pragma mark - init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mark - userOperation
- (NSMutableAttributedString *)setBiliPinkColor:(lwRecommendBodyModel *)liveModel{
    NSString *description = [NSString stringWithFormat:@"#%@# %@",liveModel.area,liveModel.title];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:description];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor biliPinkColor] range:NSMakeRange(0, liveModel.area.length + 2)];
    return result;
}

- (NSString *)viewCountOperation:(int)viewCount{
    NSString *result = [NSString new];
    if (viewCount > 10000) {
        result = [NSString stringWithFormat:@"%.2f万",viewCount/10000.00];
    }else{
        result = [NSString stringWithFormat:@"%d",viewCount];
    }
    return result;
}

#pragma mark - setter

- (void)recommendModel:(lwRecommendBodyModel *)model Last:(BOOL)last Completion:(void (^)(id))completion{
    _body = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"default_img"]];
    [_playCountLabel setTitle:[self viewCountOperation:model.play] forState:UIControlStateNormal];
    [_danmakuCountLabel setTitle:[self viewCountOperation:model.danmaku] forState:UIControlStateNormal];
    [_titleLabel setText:model.title];
    [self.refreshBtn setHidden:!last];
    
    WS(ws);
    if (completion) {
        completion(ws.refreshBtn);
    }
}

#pragma mark - loadView
- (void)loadView{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.shadowBottomView];
    [self.contentView addSubview:self.shadowView];
    [self.contentView addSubview:self.playCountLabel];
    [self.contentView addSubview:self.danmakuCountLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.refreshBtn];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(100);
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(100);
    }];
    
    [_shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(100);
    }];

    [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.iconView).offset(padding);
        make.bottom.mas_equalTo(ws.iconView);
        make.height.mas_equalTo(21);
        make.width.equalTo(ws.playCountLabel);
    }];
    
    [_danmakuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.iconView).offset(-padding);
        make.bottom.mas_equalTo(ws.iconView);
        make.height.mas_equalTo(ws.playCountLabel);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.iconView);
        make.bottom.mas_equalTo(ws.contentView);
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(padding);
    }];
    
    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
}

#pragma mark - getter

- (UIImageView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
    }
    return _shadowView;
}

- (UIImageView *)shadowBottomView{
    if (_shadowBottomView == nil){
        _shadowBottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"videoinfo_shadow_bottom"]];
    }
    return _shadowBottomView;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView setContentMode:UIViewContentModeScaleToFill];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UIButton *)playCountLabel{
    if (_playCountLabel == nil) {
        _playCountLabel = [[UIButton alloc] init];
        [_playCountLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_playCountLabel setImage:[UIImage imageNamed:@"misc_playCount_new"] forState:UIControlStateNormal];
    }
    return _playCountLabel;
}

- (UIButton *)danmakuCountLabel{
    if (_danmakuCountLabel == nil) {
        _danmakuCountLabel = [[UIButton alloc] init];
        [_danmakuCountLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_danmakuCountLabel setImage:[UIImage imageNamed:@"misc_danmakuCount_new"] forState:UIControlStateNormal];
    }
    return _danmakuCountLabel;
}

- (UIButton *)refreshBtn{
    if (_refreshBtn == nil) {
        _refreshBtn = [[UIButton alloc] init];
        [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"home_refresh_new"] forState:UIControlStateNormal];
        [_refreshBtn setHidden:YES];
    }
    return _refreshBtn;
}

@end

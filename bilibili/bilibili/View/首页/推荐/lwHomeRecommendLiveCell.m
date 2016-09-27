//
//  lwHomeRecommendLiveCell.m
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendLiveCell.h"
#import "lwRecommendBaseModel.h"

#define padding 5

@interface lwHomeRecommendLiveCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIImageView *shadowView;

@property (strong, nonatomic) UIImageView *shadowBottomView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *countLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UIButton *refreshBtn;

@end

@implementation lwHomeRecommendLiveCell

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

- (void)liveModel:(lwRecommendBodyModel *)liveModel Last:(BOOL)last Completion:(void (^)(id))completion{
    _liveModel = liveModel;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:liveModel.cover] placeholderImage:[UIImage imageNamed:@"default_img"]];
    [_titleLabel setText:liveModel.name];
    [_countLabel setTitle:[self viewCountOperation:liveModel.online] forState:UIControlStateNormal];
    [_descriptionLabel setAttributedText:[self setBiliPinkColor:liveModel]];
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.descriptionLabel];
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
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.iconView).offset(padding);
        make.bottom.mas_equalTo(ws.iconView);
        make.height.mas_equalTo(21);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.iconView).offset(-padding);
        make.bottom.mas_equalTo(ws.iconView);
        make.height.mas_equalTo(ws.titleLabel);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UIButton *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UIButton alloc] init];
        [_countLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_countLabel setImage:[UIImage imageNamed:@"home_viewCount"] forState:UIControlStateNormal];
    }
    return _countLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.backgroundColor = [UIColor whiteColor];
        _descriptionLabel.textColor = [UIColor blackColor];
        _descriptionLabel.numberOfLines = 2;
        _descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _descriptionLabel;
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

//
//  lwHomeRecommendOperaCell.m
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendOperaCell.h"

#import "lwRecommendBaseModel.h"

#define padding 5

@interface lwHomeRecommendOperaCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIImageView *shadowView;

@property (strong, nonatomic) UIImageView *shadowBottomView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *decriptionLabel;

@end

@implementation lwHomeRecommendOperaCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}
#pragma mark - userOperation

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
    [_decriptionLabel setText:model.title];
    [_titleLabel setText:[NSString stringWithFormat:@"%@ 第%@话",model.mtime,model.index]];
}

#pragma mark - loadView
- (void)loadView{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.shadowBottomView];
    [self.contentView addSubview:self.shadowView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.decriptionLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(100);
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(100);
    }];
    
    [_shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(100);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.iconView).offset(padding);
        make.bottom.mas_equalTo(ws.iconView);
        make.height.mas_equalTo(21);
    }];
    
    [_decriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.iconView);
        make.bottom.mas_equalTo(ws.contentView);
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(padding);
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
        _titleLabel.font = [UIFont systemFontOfSize:11.0];
    }
    return _titleLabel;
}

- (UILabel *)decriptionLabel{
    if (_decriptionLabel == nil) {
        _decriptionLabel = [[UILabel alloc] init];
        _decriptionLabel.textColor = [UIColor blackColor];
        _decriptionLabel.numberOfLines = 2;
        _decriptionLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _decriptionLabel;
}



@end

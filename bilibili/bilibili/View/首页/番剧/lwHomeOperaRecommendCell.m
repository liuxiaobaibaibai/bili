//
//  lwHomeOperaRecommendCell.m
//  bilibili
//
//  Created by 刘威 on 16/9/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeOperaRecommendCell.h"

#import "lwOperaBaseModel.h"

@interface lwHomeOperaRecommendCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIImageView *tagView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UIImageView *shadowView;

@end

@implementation lwHomeOperaRecommendCell

#pragma mark - private method

#pragma mark - setter
- (void)setRecommendModel:(lwOperaRecommendModel *)recommendModel{
    _recommendModel = recommendModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:recommendModel.cover]];
    [self.titleLabel setText:recommendModel.title];
    [self.descriptionLabel setText:recommendModel.desc];
    
    [self.tagView setHidden:!recommendModel.is_new];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.tagView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.shadowView];
    
    WS(ws);
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(100);
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.right.mas_equalTo(ws.contentView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(5);
        make.right.mas_equalTo(-10);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.equalTo(ws.titleLabel.mas_bottom);
        make.bottom.equalTo(ws.contentView).offset(-10);
        make.right.mas_equalTo(-10);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(ws.contentView);
    }];
}

#pragma mark - getter
- (UIImageView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
    }
    return _shadowView;
}

- (UIImageView *)tagView{
    if (_tagView == nil){
        _tagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bangumi_tableHead_new"]];
    }
    return _tagView;
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
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.contentMode = UIViewContentModeTop;
        _descriptionLabel.font = [UIFont systemFontOfSize:12.0];
        _descriptionLabel.numberOfLines = 3;
    }
    return _descriptionLabel;
}

@end

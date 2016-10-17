//
//  lwMineHistoryRecordCell.m
//  bilibili
//
//  Created by 刘威 on 16/10/17.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineHistoryRecordCell.h"

@interface lwMineHistoryRecordCell()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UIImageView *shadowView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *playCountLabel;
@property (strong, nonatomic) UILabel *barrageCountLabel;

@end

@implementation lwMineHistoryRecordCell

#pragma mark - private method

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.shadowView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.playCountLabel];
    [self.contentView addSubview:self.barrageCountLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90,70));
        make.centerY.equalTo(ws.contentView);
        make.left.mas_equalTo(10);
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.iconView);
        make.size.equalTo(ws.iconView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.iconView.mas_right).offset(10);
        make.top.mas_equalTo(ws.iconView);
        make.right.mas_equalTo(-10);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(ws.titleLabel);
    }];
    
    [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.authorLabel.mas_bottom).offset(5);
        make.bottom.equalTo(ws.iconView);
        make.width.equalTo(ws.barrageCountLabel.mas_width);
    }];
    
    [_barrageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.playCountLabel.mas_right);
        make.right.equalTo(ws.titleLabel);
        make.top.bottom.equalTo(ws.playCountLabel);
    }];
}

#pragma mark - setter

#pragma mark - getter
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"_discovery_game"];
    }
    return _iconView;
}

- (UIImageView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
    }
    return _shadowView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"爱情公寓外传值开心原理 1-6 集全标清已授权";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)authorLabel{
    if (_authorLabel == nil) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.text = @"up主：付晓苏_P";
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.font = [UIFont systemFontOfSize:12.0];
        _authorLabel.numberOfLines = 1;
    }
    return _authorLabel;
}

- (UILabel *)playCountLabel{
    if (_playCountLabel == nil) {
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.text = @"播放：10.7万";
        _playCountLabel.textColor = [UIColor lightGrayColor];
        _playCountLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _playCountLabel;
}

- (UILabel *)barrageCountLabel{
    if (_barrageCountLabel == nil) {
        _barrageCountLabel = [[UILabel alloc] init];
        _barrageCountLabel.text = @"弹幕：6365";
        _barrageCountLabel.textColor = [UIColor lightGrayColor];
        _barrageCountLabel.font = [UIFont systemFontOfSize:10.0];
        _barrageCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _barrageCountLabel;
}

@end

//
//  lwMineOffLineCell.m
//  bilibili
//
//  Created by 刘威 on 16/10/17.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineOffLineCell.h"

@interface lwMineOffLineCell()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;

@end

@implementation lwMineOffLineCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70,50));
        make.centerY.equalTo(ws.contentView);
        make.left.mas_equalTo(10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.iconView.mas_right).offset(10);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-10);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(ws.titleLabel);
        make.bottom.equalTo(ws);
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

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"【福利GIF转成视频竟然如此清晰】(第二期)";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.text = @"已完成 运行中:0 已完成:5 总下载:5";
        _subtitleLabel.textColor = [UIColor lightGrayColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:10.0];
        _subtitleLabel.numberOfLines = 1;
    }
    return _subtitleLabel;
}

@end

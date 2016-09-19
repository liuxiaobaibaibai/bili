//
//  lwDynamicCell.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwDynamicCell.h"

#define padding 5

@interface lwDynamicCell ()

@property (strong, nonatomic) UIImageView *titleImgView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *subtitleLabel;

@property (strong, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) UILabel *themeLabel;
@property (strong, nonatomic) UILabel *descriptLabel;

@end

@implementation lwDynamicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mmark - loadView
- (void)loadView{
    [self.contentView addSubview:self.titleImgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.themeLabel];
    [self.contentView addSubview:self.descriptLabel];
    
    WS(ws);
    
    [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(padding);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleImgView.mas_right).offset(padding);
        make.top.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(_titleImgView);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(ws.titleImgView.mas_bottom).offset(padding);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(ws.subtitleLabel.mas_bottom).offset(padding);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    [_themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.iconImgView.mas_right).offset(padding);
        make.top.mas_equalTo(ws.iconImgView);
    }];
    
    [_descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.themeLabel);
        make.bottom.mas_equalTo(ws.iconImgView);
    }];
}

#pragma mark - getter
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_recommend_liveTag"]];
    }
    return _titleImgView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        _titleLabel.text = @"火影忍者 疾风传";
        
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textColor = [UIColor grayColor];
        _subtitleLabel.backgroundColor = [UIColor whiteColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:11.0];
        _subtitleLabel.text = @"18天前 更新了 第691话";
    }
    return _subtitleLabel;
}

- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tv_450"]];
    }
    return _iconImgView;
}

- (UILabel *)themeLabel{
    if (_themeLabel == nil) {
        _themeLabel = [[UILabel alloc] init];
        _themeLabel.textColor = [UIColor blackColor];
        _themeLabel.backgroundColor = [UIColor whiteColor];
        _themeLabel.font = [UIFont systemFontOfSize:14.0];
        _themeLabel.text = @"【1月】火影忍者 疾风传 591";
    }
    return _themeLabel;
}

- (UILabel *)descriptLabel{
    if (_descriptLabel == nil) {
        _descriptLabel = [[UILabel alloc] init];
        _descriptLabel.textColor = [UIColor blackColor];
        _descriptLabel.backgroundColor = [UIColor whiteColor];
        _descriptLabel.font = [UIFont systemFontOfSize:11.0];
        _descriptLabel.text = @"  播放：80.4万 弹幕：3.6万";
    }
    return _descriptLabel;
}


@end

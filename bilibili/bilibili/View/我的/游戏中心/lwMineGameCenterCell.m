//
//  lwMineGameCenterCell.m
//  bilibili
//
//  Created by 刘威 on 16/10/17.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineGameCenterCell.h"

@interface lwMineGameCenterCell ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIButton *downloadButton;

@end

@implementation lwMineGameCenterCell

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        self.backgroundColor = RGB(230, 230, 230);
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.downloadButton];
    
    WS(ws);
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws);
        make.height.mas_equalTo(190);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(10);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(ws.titleLabel);
        make.bottom.mas_equalTo(-5);
    }];
    
    [_downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel.mas_right);
        make.top.equalTo(ws.titleLabel);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - setter
- (void)setIsLast:(BOOL)isLast{
    _isLast = isLast;
//    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        if (isLast) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -15, 0));
//        }else{
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -10, 0));
//        }
//    }];
}

#pragma mark - getter
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameCenter"]];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"命运-冠位指定（Fate/GO）";
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.text = @"全平台公测开启！";
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        _subtitleLabel.textColor = [UIColor lightGrayColor];
    }
    return _subtitleLabel;
}

- (UIButton *)downloadButton{
    if (_downloadButton == nil) {
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setTitleColor:[UIColor biliPinkColor] forState:UIControlStateNormal];
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        
        [_downloadButton.layer setCornerRadius:5.0];
        [_downloadButton.layer setMasksToBounds:YES];
        [_downloadButton.layer setBorderWidth:1.0];
        [_downloadButton.layer setBorderColor:[UIColor biliPinkColor].CGColor];
    }
    return _downloadButton;
}

@end

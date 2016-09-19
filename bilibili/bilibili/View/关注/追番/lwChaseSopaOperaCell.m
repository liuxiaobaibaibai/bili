//
//  lwChaseSopaOperaCell.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwChaseSopaOperaCell.h"

#import "UIImage+lwImage.h"

@interface lwChaseSopaOperaCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *recordLabel;

@property (strong, nonatomic) UILabel *lastLabel;

@end

@implementation lwChaseSopaOperaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.recordLabel];
    [self.contentView addSubview:self.lastLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(60, 80));
        make.bottom.mas_equalTo(-5);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.iconView.mas_right).offset(5);
        make.top.mas_equalTo(ws.iconView.mas_top).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    [_recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom);
        make.right.mas_equalTo(ws.titleLabel);
    }];
    
    [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.recordLabel.mas_bottom);
        make.right.mas_equalTo(ws.titleLabel);
    }];
}

#pragma mark - getter
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_discovery_game"]];
        _iconView.layer.cornerRadius = 5.0;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.shouldRasterize = YES;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"火影忍者 疾风传";
    }
    return _titleLabel;
}

- (UILabel *)recordLabel{
    if (_recordLabel == nil) {
        _recordLabel = [[UILabel alloc] init];
        _recordLabel.font = [UIFont systemFontOfSize:14.0];
        _recordLabel.textColor = [UIColor lightGrayColor];
        _recordLabel.text = @"看到第 693 话";
    }
    return _recordLabel;
}

- (UILabel *)lastLabel{
    if (_lastLabel == nil) {
        _lastLabel = [[UILabel alloc] init];
        _lastLabel.font = [UIFont systemFontOfSize:14.0];
        _lastLabel.textColor = [UIColor lightGrayColor];
        _lastLabel.text = @"更新至第 693 话";
    }
    return _lastLabel;
}

@end

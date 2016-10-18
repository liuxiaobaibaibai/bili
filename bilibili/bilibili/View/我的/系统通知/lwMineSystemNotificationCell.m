//
//  lwMineSystemNotificationCell.m
//  bilibili
//
//  Created by lw on 2016/10/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineSystemNotificationCell.h"

@interface lwMineSystemNotificationCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation lwMineSystemNotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.timeLabel];
    
    WS(ws);
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(ws.titleLabel);
        make.top.equalTo(ws.titleLabel.mas_bottom).offset(10);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.descriptionLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"的他是滴啊上等哈了盛大就开始的啦";
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:12.0];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textColor = [UIColor blackColor];
        NSString *content = @"爱上嗲是郭德纲哈市的工行和水电费也无法改变大家伙的分公司的进口国回复阿斯顿嘎哈是更大更合适的气氛官网预购发论文服务打翻了收到啦复合王菲官方和归属感付款的供货商安徽工时费噶业务让发个我辜负了问个法律为规范 士大夫hi武二哥viv斯蒂芬攻略网位富豪的垃圾啊后来删掉 爱上当是否会给五月份吧阿克苏的哈随后vi无二vc卡的八分空间是的哈会计师大蝴蝶飞不 按时大大黄金卡号苏合肥合肥和空间阿尔";
        [_descriptionLabel setAttributedText:[content kernSpace:0.2 LineSpace:6.0]];
    }
    return _descriptionLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"4天前";
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _timeLabel;
}

@end

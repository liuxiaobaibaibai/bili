//
//  lwHomeLiveVideoHeaderView.m
//  bilibili
//
//  Created by lw on 16/9/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeLiveVideoHeaderView.h"

#import "lwLiveVideoModel.h"

#import <SDWebImage/UIButton+WebCache.h>

@interface lwHomeLiveVideoHeaderView ()

@property (strong, nonatomic) UIButton *titleLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UIImageView *accessView;

@end

@implementation lwHomeLiveVideoHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)setPartitionModel:(lwLiveVideoPartitionModel *)partitionModel{
    [self.titleLabel setTitle:partitionModel.name forState:UIControlStateNormal];
    
    [self.titleLabel sd_setImageWithURL:[NSURL URLWithString:partitionModel.iconModel.src] forState:UIControlStateNormal];
    
    [self.descriptionLabel setText:[NSString stringWithFormat:@"当前%d个主播，进去看看",partitionModel.pCount]];
}

- (void)loadView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.accessView];
    
    WS(ws);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(100);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(ws);
    }];
    
    [self.accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.descriptionLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-5);
    }];
}

#pragma mark - getter
- (UIButton *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UIButton alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [_titleLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_titleLabel setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 80)];
        [_titleLabel setTitleEdgeInsets:UIEdgeInsetsMake(10, -40, 10, 0)];
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.backgroundColor = [UIColor whiteColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _descriptionLabel;
}

- (UIImageView *)accessView{
    if (_accessView == nil) {
        _accessView = [[UIImageView alloc] init];
        [_accessView setImage:[UIImage imageNamed:@"search_openMore"]];
    }
    return _accessView;
}

@end

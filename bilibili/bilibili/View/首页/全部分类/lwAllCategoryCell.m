//
//  lwAllCategoryCell.m
//  bilibili
//
//  Created by lw on 16/9/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAllCategoryCell.h"

#import "lwLiveVideoModel.h"

@interface lwAllCategoryCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation lwAllCategoryCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)setIconModel:(lwLiveVideoEnterModel *)iconModel{
    
    [self.titleLabel setText:iconModel.name];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:iconModel.iconModel.src]];
    
    _iconModel = iconModel;
}

#pragma mark - loadView
- (void)loadView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imgView];
    
    WS(ws);
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(ws.contentView);
        make.centerY.equalTo(ws);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.contentView);
        make.top.mas_equalTo(ws.imgView.mas_bottom).offset(10);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

@end

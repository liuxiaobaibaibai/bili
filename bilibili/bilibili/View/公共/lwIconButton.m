//
//  lwIconButton.m
//  bilibili
//
//  Created by lw on 16/9/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwIconButton.h"

@interface lwIconButton ()

@end

@implementation lwIconButton

- (id)init{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.mas_equalTo(5);
        make.left.right.mas_equalTo(ws);
        make.bottom.equalTo(ws.titleLabel.mas_top);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
    }];
}

#pragma mark - getter
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

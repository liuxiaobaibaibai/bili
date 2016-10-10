//
//  lwNavigationBar.m
//  bilibili
//
//  Created by 刘威 on 16/10/10.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwNavigationBar.h"

@interface lwNavigationBar ()

@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UILabel *titleLabel;


@end

@implementation lwNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.backgroundColor = [UIColor biliPinkColor];
    self.barTintColor = [UIColor biliPinkColor];
    
    WS(ws);
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.superview);
        make.height.mas_equalTo(lNavH);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor biliPinkColor];
    [self addSubview:bgView];
    
    [bgView addSubview:self.backBtn];
    [bgView addSubview:self.titleLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.width.mas_lessThanOrEqualTo(60);
        make.centerY.equalTo(bgView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
    }];
}

#pragma mark -
- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _backBtn;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"叼你老母";
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end

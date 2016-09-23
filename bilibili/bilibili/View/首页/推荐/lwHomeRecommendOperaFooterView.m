//
//  lwHomeRecommendOperaFooterView.m
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommendOperaFooterView.h"

@interface lwHomeRecommendOperaFooterView ()

@property (strong, nonatomic) UIButton *broadcastBtn;

@property (strong, nonatomic) UIButton *indexBtn;

@end

@implementation lwHomeRecommendOperaFooterView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self loadView];
    }
    return self;
}

#pragma mark - loadView
- (void)loadView{
    [self addSubview:self.broadcastBtn];
    [self addSubview:self.indexBtn];
    
    WS(ws);
    
    [_broadcastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(ws);
    }];
    
    [_indexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.broadcastBtn.mas_right).offset(10);
        make.right.mas_equalTo(10);
        make.width.mas_equalTo(ws.broadcastBtn);
        make.centerY.equalTo(ws);
    }];
}

#pragma mark - getter
- (UIButton *)broadcastBtn{
    if (_broadcastBtn == nil) {
        _broadcastBtn = [[UIButton alloc] init];
        [_broadcastBtn setImage:[UIImage imageNamed:@"home_bangumi_timeline"] forState:UIControlStateNormal];
    }
    return _broadcastBtn;
}

- (UIButton *)indexBtn{
    if (_indexBtn == nil) {
        _indexBtn = [[UIButton alloc] init];
        [_indexBtn setImage:[UIImage imageNamed:@"home_bangumi_category"] forState:UIControlStateNormal];
    }
    return _indexBtn;
}

@end

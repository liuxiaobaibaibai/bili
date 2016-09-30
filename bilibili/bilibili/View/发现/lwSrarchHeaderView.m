//
//  lwSrarchHeaderView.m
//  bilibili
//
//  Created by lw on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSrarchHeaderView.h"

@interface lwSrarchHeaderView ()

@property (strong, nonatomic) UIScrollView *myScrollView;

@property (strong, nonatomic) UILabel *leftLine;
@property (strong, nonatomic) UILabel *rightLine;

@end

@implementation lwSrarchHeaderView

#pragma mark - view action

- (void)moreButtonClick:(UIButton *)btn{
    
    if (btn.selected) {
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"find_openMore"] forState:UIControlStateNormal];
    }else{
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"find_closeMore"] forState:UIControlStateNormal];
    }
    
    if ([_delegate respondsToSelector:@selector(headerButtonClick:)]) {
        [_delegate headerButtonClick:btn];
    }
}

- (void)customButtonClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(headerButtonClick:)]) {
        [_delegate headerButtonClick:btn];
    }
}

#pragma mark - init
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - life cycle

#pragma mark - setup view
- (void)setupView{
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.backgroundColor = [UIColor biliPinkColor];
    
    [self addSubview:self.qrBtn];
    [self addSubview:self.searchBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.myScrollView];
    [self addSubview:self.moreBtn];
    [self addSubview:self.leftLine];
    [self addSubview:self.rightLine];
    
    WS(ws);
    
    [_qrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(ws.searchBtn);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(ws.qrBtn.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(28);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.qrBtn);
        make.top.mas_equalTo(ws.searchBtn.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
    }];
    
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.qrBtn);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-10);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.qrBtn);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(ws.myScrollView.mas_bottom);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.moreBtn);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(ws.moreBtn);
        make.height.mas_equalTo(1);
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.moreBtn);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(ws.moreBtn);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - getter
- (UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"  搜索视频、番剧、up主或AV号" forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"search_prompt_icon"] forState:UIControlStateNormal];
        [_searchBtn.layer setCornerRadius:5.0];
        [_searchBtn setBackgroundColor:[UIColor whiteColor]];
        [_searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_searchBtn setTag:3];
        [_searchBtn addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UIButton *)qrBtn{
    if (_qrBtn == nil) {
        _qrBtn = [[UIButton alloc] init];
        [_qrBtn setImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
        [_qrBtn setTag:2];
        [_qrBtn addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qrBtn;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"大家都在搜";
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _myScrollView;
}

- (UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setTitle:@"  查看更多" forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"find_openMore"] forState:UIControlStateNormal];
        [_moreBtn setSelected:NO];
        [_moreBtn addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn setTag:1];
    }
    return _moreBtn;
}

- (UILabel *)leftLine{
    if (_leftLine == nil) {
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = [UIColor whiteColor];
    }
    return _leftLine;
}

- (UILabel *)rightLine{
    if (_rightLine == nil) {
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = [UIColor whiteColor];
    }
    return _rightLine;
}

@end

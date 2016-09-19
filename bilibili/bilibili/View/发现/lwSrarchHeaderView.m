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
    [self addSubview:self.searchVC.searchBar];
    [self addSubview:self.titleLabel];
    [self addSubview:self.myScrollView];
    [self addSubview:self.moreBtn];
    [self addSubview:self.leftLine];
    [self addSubview:self.rightLine];
    
    WS(ws);
    
    [_qrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(ws.searchVC.searchBar);
    }];
    
    [_searchVC.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(ws.qrBtn.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.qrBtn);
        make.top.mas_equalTo(ws.searchVC.searchBar.mas_bottom).offset(10);
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

- (void)setSearchUpdate:(id)searchUpdate{
    self.searchVC.searchResultsUpdater = searchUpdate;
    _searchUpdate = searchUpdate;
}

#pragma mark - getter
- (UISearchController *)searchVC{
    if (_searchVC == nil) {
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchVC.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _searchVC.dimsBackgroundDuringPresentation = YES;
        _searchVC.hidesNavigationBarDuringPresentation = NO;
        
        //搜索栏表头视图
        [_searchVC.searchBar sizeToFit];
        //背景颜色
        _searchVC.searchBar.tintColor = [UIColor darkGrayColor];
        [_searchVC.searchBar setBackgroundImage:[UIImage new]];
        _searchVC.searchBar.barTintColor = HTMLColor(@"#f5f5f5");
        _searchVC.searchBar.placeholder = @"搜索视频、番剧、up主或AV号";
        _searchVC.searchResultsUpdater = nil;
    }
    return _searchVC;
}

- (UIButton *)qrBtn{
    if (_qrBtn == nil) {
        _qrBtn = [[UIButton alloc] init];
        [_qrBtn setImage:[UIImage imageNamed:@"scanning_icon"] forState:UIControlStateNormal];
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
        [_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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

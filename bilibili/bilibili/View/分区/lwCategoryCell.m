//
//  lwCategoryCell.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCategoryCell.h"
#import "lwCategoryModel.h"

#import "UIView+lwView.h"
#import <UIButton+WebCache.h>

#define imgSize 30
@interface lwCategoryCell ()

@property (strong, nonatomic) UIImageView *imgView;

@property (strong, nonatomic) UIImageView *coverImageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *iconBtn;

@end

@implementation lwCategoryCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    
    WS(ws);
    self.backgroundColor = RGB(245, 245, 245);
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.imgView];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(ws);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgSize, imgSize));
        make.centerX.equalTo(ws.coverImageView);
        make.top.mas_equalTo(ws.coverImageView.mas_top).offset(15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(ws.coverImageView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - setter
- (void)setCategoryModel:(lwCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    
    [self.titleLabel setText:categoryModel.title];
    if (categoryModel.isLocal) {
        [self.imgView setImage:[UIImage imageNamed:categoryModel.imgPath]];
    }else{
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:categoryModel.imgPath]];
    }
}

#pragma mark - getter
- (UIButton *)iconBtn{
    if (_iconBtn == nil) {
        _iconBtn = [[UIButton alloc] init];
    }
    return _iconBtn;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_region_border"]];
    }
    return _coverImageView;
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

@end

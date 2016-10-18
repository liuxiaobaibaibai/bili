//
//  lwPersonalMenuCell.m
//  bilibili
//
//  Created by lw on 16/9/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalMenuCell.h"

#import "lwCategoryModel.h"

@interface lwPersonalMenuCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *badgeLabel;

@end

@implementation lwPersonalMenuCell

#pragma mark - init

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma amrk - setter
- (void)setBadge:(NSString *)badge{
    _badge = badge;
    _badgeLabel.hidden = NO;
    _badgeLabel.text = badge;
}

- (void)setCategoryModel:(lwCategoryModel *)categoryModel{
    
    _categoryModel = categoryModel;
    [self.titleLabel setText:categoryModel.title];
    [self.iconView setImage:[UIImage imageNamed:categoryModel.imgPath]];
}

#pragma mark - life cycle
- (void)loadView{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.badgeLabel];
    
    WS(ws);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(ws.contentView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.contentView);
        make.top.mas_equalTo(ws.iconView.mas_bottom).offset(5);
    }];
    
    [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)badgeLabel{
    if (_badgeLabel == nil) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.font = [UIFont systemFontOfSize:14.0];
        _badgeLabel.hidden = YES;
        
        _badgeLabel.layer.cornerRadius = 10;
        _badgeLabel.layer.masksToBounds = YES;
        
    }
    return _badgeLabel;
}

@end

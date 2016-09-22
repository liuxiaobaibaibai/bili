//
//  lwHomeRecommedActityCell.m
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeRecommedActityCell.h"

#import "lwRecommendBaseModel.h"

@interface lwHomeRecommedActityCell ()

@property (strong, nonatomic) UIScrollView *myScrollView;

@end

@implementation lwHomeRecommedActityCell

#pragma mark - 
- (void)actityModel:(lwRecommendBaseModel *)model Completion:(void (^)(id))completion{
    _model = model;
    
    [self.myScrollView setContentSize:CGSizeMake(180 * model.body.count, 150)];
    
    for (lwRecommendBodyModel *body in model.body) {
        
        NSInteger idx = [model.body indexOfObject:body];
        
        UIView *albumView = [[UIView alloc] initWithFrame:CGRectMake(idx * 180, 0, 180, 150)];
        albumView.backgroundColor = [UIColor whiteColor];
        [self.myScrollView addSubview:albumView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:body.title];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.numberOfLines = 2;
        
        UIImageView *shadowView = [[UIImageView alloc] init];
        [shadowView sd_setImageWithURL:[NSURL URLWithString:body.cover]];
        [shadowView setContentMode:UIViewContentModeScaleToFill];
        
        
        UIImageView *shadowBottomView = [[UIImageView alloc] init];
        shadowBottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
        
        [albumView addSubview:shadowView];
        [albumView addSubview:shadowBottomView];
        [albumView addSubview:titleLabel];
        

        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(105);
        }];
        
        [shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(shadowView);
            make.size.equalTo(shadowView);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(shadowView.mas_bottom);
        }];
    }
    
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mark - loadView
- (void)loadView{
    [self.contentView addSubview:self.myScrollView];
    
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - getter
- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _myScrollView;
}
@end

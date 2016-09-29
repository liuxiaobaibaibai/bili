//
//  lwHomeOperaCustomCell.m
//  bilibili
//
//  Created by 刘威 on 16/9/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeOperaCustomCell.h"
#import "lwOperaBaseModel.h"

@interface lwHomeOperaCustomCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIImageView *shadowView;

@property (strong, nonatomic) UIImageView *shadowBottomView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *countLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;


@end

@implementation lwHomeOperaCustomCell

#pragma mark - private method
- (NSString *)viewCountOperation:(int)viewCount{
    NSString *result = [NSString new];
    if (viewCount > 10000) {
        result = [NSString stringWithFormat:@"%.1f万",viewCount/10000.00];
    }else{
        result = [NSString stringWithFormat:@"%d",viewCount];
    }
    return result;
}

- (void)addUsuallyLayout:(lwHomeOperaCustomCellStyle)style{
    WS(ws);
    switch (style) {
        case lwHomeOperaCustomCellStyleSerializing:
        {
            // 先关控件的隐藏和显示
            self.descriptionLabel.hidden = NO;
            
            // 新番连载
            [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(ws.contentView);
                make.height.mas_equalTo(140);
            }];
            
            [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(ws.iconView);
                make.center.equalTo(ws.iconView);
            }];
            
            [self.shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(ws.iconView);
                make.center.equalTo(ws.iconView);
            }];
            
            [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(ws.iconView).offset(-5);
                make.left.mas_equalTo(ws.iconView.mas_left).offset(5);
                make.right.mas_equalTo(ws.iconView.mas_right).offset(-5);
            }];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(ws.contentView);
                make.top.mas_equalTo(ws.iconView.mas_bottom).offset(5);
            }];
            
            [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(ws.contentView);
                make.top.equalTo(ws.titleLabel.mas_bottom);
            }];
            
        }
            break;
        default:
        {
            // 相关控件的隐藏和显示
            self.descriptionLabel.hidden = YES;
            
            // 四月新番
            [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(ws.contentView);
                make.height.mas_equalTo(140);
            }];
            
            [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(ws.iconView);
                make.center.equalTo(ws.iconView);
            }];
            
            [self.shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(ws.iconView);
                make.center.equalTo(ws.iconView);
            }];
            
            [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(ws.iconView).offset(-5);
                make.left.mas_equalTo(ws.iconView.mas_left).offset(5);
                make.right.mas_equalTo(ws.iconView.mas_right).offset(-5);
            }];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(ws.contentView);
                make.top.mas_equalTo(ws.iconView.mas_bottom);
                make.bottom.equalTo(ws.contentView);
            }];
        }
            break;
    }
}

- (void)setContentModel:(lwHomeOperaCustomCellStyle)style Model:(lwPreviousListModel *)model{
    switch (style) {
        case lwHomeOperaCustomCellStyleSerializing:
        {
            // 新番连载
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            [self.countLabel setText:[NSString stringWithFormat:@"%@人在看",[self viewCountOperation:model.watching_count]]];
            [self.titleLabel setText:model.title];
            [self.descriptionLabel setText:[NSString stringWithFormat:@"更新至第%@话",model.newwest_ep_index]];
        }
            break;
        default:
        {
            //四月新番
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            [self.countLabel setText:[NSString stringWithFormat:@"%@人在追番",[self viewCountOperation:[model.favourites intValue]]]];
            [self.titleLabel setText:model.title];
        }
            break;
    }
}

#pragma mark - setter
- (void)operaModel:(lwPreviousListModel *)model Style:(lwHomeOperaCustomCellStyle)style{
    _model = model;
    [self setContentModel:style Model:model];
    [self addUsuallyLayout:style];
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
#pragma mark - cycle

#pragma mark - setupView
- (void)setupView{
    [[self.contentView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.shadowBottomView];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.shadowView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
}
#pragma mark - getter
- (UIImageView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
    }
    return _shadowView;
}

- (UIImageView *)shadowBottomView{
    if (_shadowBottomView == nil){
        _shadowBottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"videoinfo_shadow_bottom"]];
    }
    return _shadowBottomView;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView setContentMode:UIViewContentModeScaleToFill];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor whiteColor];
        [_countLabel setFont:[UIFont systemFontOfSize:12.0]];
    }
    return _countLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.contentMode = UIViewContentModeTop;
        _descriptionLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _descriptionLabel;
}

@end

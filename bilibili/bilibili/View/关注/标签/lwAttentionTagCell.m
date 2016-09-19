//
//  lwAttentionTagCell.m
//  bilibili
//
//  Created by lw on 16/9/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAttentionTagCell.h"

#import "lwAttentionTagModel.h"

#define padding 10

@interface lwAttentionTagCell ()

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIImageView *tagView;
@property (strong, nonatomic) UIButton *tagLabel;

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UILabel *barrageCountLabel;


@end

@implementation lwAttentionTagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)tagModel:(lwAttentionTagModel *)tag Filtered:(BOOL)filtered Completion:(void(^)(id object))completion{

    if (filtered) {
        // 隐藏标签
        [self.line setHidden:YES];
        [self.tagView setHidden:YES];
        [self.tagLabel setHidden:YES];
        
        [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else{
        if (tag.source.showTag) {
            // 展示出来
            [self.line setHidden:NO];
            [self.tagView setHidden:NO];
            [self.tagLabel setHidden:NO];
            
            [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(1);
            }];
            
            [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
        }else{
            // 隐藏标签
            [self.line setHidden:YES];
            [self.tagView setHidden:YES];
            [self.tagLabel setHidden:YES];
            
            [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(0, 0));
            }];
        }
    }
    
    
    [_tagLabel setTitle:[NSString stringWithFormat:@"  %@  ",tag.source.name] forState:UIControlStateNormal];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:tag.addition.pic]];
    [_titleLabel setText:tag.addition.title];
    [_authorLabel setText:[NSString stringWithFormat:@"up主：%@",tag.addition.author]];
    [_countLabel setText:[NSString stringWithFormat:@"播放：%d",tag.addition.play]];
    [_barrageCountLabel setText:[NSString stringWithFormat:@"弹幕：%d",tag.addition.video_review]];
    
    _tagModel = tag;
    
    if (completion) {
        completion(_tagLabel);
    }
    
}

#pragma mark - loadView
- (void)loadView{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.tagView];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.barrageCountLabel];
    
    WS(ws);
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(ws.contentView);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.line);
        make.top.mas_equalTo(ws.line.mas_bottom).offset(padding);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.tagView.mas_right).offset(padding);
        make.bottom.top.equalTo(ws.tagView);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.line);
        make.top.equalTo(ws.tagView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(90, 60));
    }];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.iconView);
        make.size.equalTo(ws.iconView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.iconView.mas_right).offset(padding);
        make.top.equalTo(ws.iconView);
        make.right.mas_equalTo(-15);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom).offset(padding);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.top.mas_equalTo(ws.authorLabel.mas_bottom).offset(padding);
        make.bottom.equalTo(ws.barrageCountLabel);
    }];
    
    [_barrageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.countLabel);
        make.width.equalTo(ws.countLabel);
        make.left.equalTo(ws.countLabel.mas_right);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
    }];
    
}

#pragma mark - getter
- (UIView *)line{
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(242, 242, 242);
    }
    return _line;
}

- (UIImageView *)tagView{
    if (_tagView == nil) {
        _tagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_tag"]];
    }
    return _tagView;
}

- (UIButton *)tagLabel{
    if (_tagLabel == nil) {
        _tagLabel = [[UIButton alloc] init];
        [_tagLabel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_tagLabel setBackgroundColor:RGB(242, 242, 242)];
        [_tagLabel.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        _tagLabel.layer.cornerRadius = 10;
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.borderWidth = 1.0;
        _tagLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _tagLabel;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView setImage:[UIImage imageNamed:@"_discovery_game"]];
    }
    return _iconView;
}

- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_5_corner_246_bg"]];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"（盘点）动漫中哪些持刀帅气的女角色";
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UILabel *)authorLabel{
    if (_authorLabel == nil) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.text = @"up主：我也是醉了";
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _authorLabel;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"播放：13265";
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _countLabel;
}

- (UILabel *)barrageCountLabel{
    if (_barrageCountLabel == nil) {
        _barrageCountLabel = [[UILabel alloc] init];
        _barrageCountLabel.text = @"弹幕：15";
        _barrageCountLabel.font = [UIFont systemFontOfSize:12.0];
        _barrageCountLabel.textColor = [UIColor lightGrayColor];
        _barrageCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _barrageCountLabel;
}


@end

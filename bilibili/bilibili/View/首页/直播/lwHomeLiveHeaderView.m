//
//  lwHomeLiveHeaderView.m
//  bilibili
//
//  Created by 刘威 on 16/10/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeLiveHeaderView.h"

#import "lwLiveVideoModel.h"

#import <SDWebImage/UIButton+WebCache.h>

#import "lwScrollView.h"

#import "lwIconButton.h"

#define padding 5

@interface lwHomeLiveHeaderView ()
<
lwScrollViewDelegate
>

@property (strong, nonatomic) UIButton *titleLabel;

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UIImageView *accessView;

// 第一个section时用

@property (strong, nonatomic) NSArray <NSDictionary *>  *itemArray;

@property (strong, nonatomic) lwScrollView *flashView;


@end

@implementation lwHomeLiveHeaderView

- (void)configCell:(id)liveHeaderModel Style:(lwHomeLiveHeaderViewStyle)style Completion:(void (^)(id))cmpletion{
    switch (style) {
        case lwHomeLiveHeaderViewStyleBannerWithMenu:
        {
            [self loadBannerWithMenuView:liveHeaderModel];
        }
            break;
        case lwHomeLiveHeaderViewStyleTitle:
        {
            [self loadCustomView:liveHeaderModel];
        }
            break;
        default:
            break;
    }
}

#pragma mark - lwScrollViewDelegate
- (void)flashClick:(id)sender Index:(NSInteger)index{
    NSLog(@"点击了%@",(_liveVideo.banners[index]).title);
}

#pragma mark - user action
- (void)iconClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(iconButtonClick:)]) {
        [_delegate iconButtonClick:btn];
    }
}

#pragma mark - setter

- (void)setPartitionStyleModel:(lwLiveVideoPartitionModel *)partitionModel{
    
    _partitionModel = partitionModel;
    
    [self.titleLabel setTitle:partitionModel.name forState:UIControlStateNormal];
    
    [self.titleLabel sd_setImageWithURL:[NSURL URLWithString:partitionModel.iconModel.src] forState:UIControlStateNormal];
    
    [self.descriptionLabel setText:[NSString stringWithFormat:@"当前%d个主播，进去看看",partitionModel.pCount]];
}

- (void)setLiveVideoStyleModel:(lwLiveVideoModel *)liveVideo{
    _liveVideo = liveVideo;
    
    NSMutableArray *flash = [NSMutableArray new];
    NSMutableArray *title = [NSMutableArray new];
    for (lwLiveVideoBannerModel *banner in liveVideo.banners) {
        [flash addObject:banner.img];
        [title addObject:banner.remark];
    }
    
    [self.flashView setFlashs:flash];
}

#pragma mark - laodView
- (void)loadCustomView:(lwLiveVideoPartitionModel *)partitionModel{
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.accessView];
    
    WS(ws);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(100);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(ws);
    }];
    
    [self.accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.descriptionLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-5);
    }];
    
    [self setPartitionStyleModel:partitionModel];
}

- (void)loadBannerWithMenuView:(lwLiveVideoModel *)liveVideo{
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self addSubview:self.flashView];
    
    WS(ws);
    
    __block lwIconButton *lastBtn = nil;
    
    [self.itemArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        lwIconButton *itemBtn = [[lwIconButton alloc] init];
        
        [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [itemBtn.titleLabel setText:[[obj allKeys] firstObject]];
        [itemBtn.iconView setImage:[UIImage imageNamed:[[obj allValues] firstObject]]];
        [itemBtn addTarget:ws action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125);
            make.width.mas_equalTo(lW / 4);
            
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right);
            }else{
                make.left.mas_equalTo(0);
            }
        }];
        
        lastBtn = itemBtn;
    }];
    
    // 标题
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.accessView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(lastBtn.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(ws.titleLabel);
    }];
    
    [self.accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.descriptionLabel.mas_right).offset(5);
        make.centerY.equalTo(ws.titleLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-5);
    }];
    
    [self setPartitionStyleModel:[liveVideo.partitions firstObject].partitionModel];
    
    [self setLiveVideoStyleModel:liveVideo];
}

#pragma mark - getter
- (lwScrollView *)flashView{
    if (_flashView == nil) {
        _flashView = [[lwScrollView alloc] initWithFrame:CGRectMake(0, 0, lW, 120) DataSource:@[] Delegate:self];
        _flashView.sourceIsLocal = NO;
        _flashView.timer = 2;
        _flashView.autoScroll = YES;
    }
    return _flashView;
}


- (NSArray <NSDictionary *> *)itemArray{
    if (_itemArray == nil) {
        _itemArray = @[@{@"关注主播":@"live_home_follow_ico"},@{@"直播中心":@"live_home_center_ico"},@{@"搜索房间":@"live_home_search_ico"},@{@"全部分类":@"live_home_category_ico"}];
    }
    return _itemArray;
}

- (UIButton *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UIButton alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [_titleLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_titleLabel setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 80)];
        [_titleLabel setTitleEdgeInsets:UIEdgeInsetsMake(10, -40, 10, 0)];
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.backgroundColor = [UIColor whiteColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _descriptionLabel;
}

- (UIImageView *)accessView{
    if (_accessView == nil) {
        _accessView = [[UIImageView alloc] init];
        [_accessView setImage:[UIImage imageNamed:@"search_openMore"]];
    }
    return _accessView;
}


@end

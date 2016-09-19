//
//  lwHomeLiveVideoHeaderCell.m
//  bilibili
//
//  Created by lw on 16/9/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeLiveVideoHeaderCell.h"

#import "lwScrollView.h"

#import "lwLiveVideoModel.h"

#import <UIButton+WebCache.h>

#import "lwIconButton.h"

@interface lwHomeLiveVideoHeaderCell ()
<
lwScrollViewDelegate
>

@property (strong, nonatomic) NSArray <NSDictionary *>  *itemArray;

@property (strong, nonatomic) lwScrollView *flashView;

@end

@implementation lwHomeLiveVideoHeaderCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

#pragma mark - user action
- (void)iconClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(iconButtonClick:)]) {
        [_delegate iconButtonClick:btn];
    }
}

#pragma mark - setter
- (void)setLiveVideo:(lwLiveVideoModel *)liveVideo{
    _liveVideo = liveVideo;
    
    NSMutableArray *flash = [NSMutableArray new];
    NSMutableArray *title = [NSMutableArray new];
    for (lwLiveVideoBannerModel *banner in liveVideo.banners) {
        [flash addObject:banner.img];
        [title addObject:banner.remark];
    }

    [self.flashView setFlashs:flash];
}

#pragma mark - lwScrollViewDelegate
- (void)flashClick:(id)sender Index:(NSInteger)index{
    NSLog(@"点击了%@",(_liveVideo.banners[index]).title);
}

#pragma mark - laodView
- (void)loadView{
    [self.contentView addSubview:self.flashView];
    
    WS(ws);
    
    __block lwIconButton *lastBtn = nil;
    
    [self.itemArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        lwIconButton *itemBtn = [[lwIconButton alloc] init];
        
        [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [itemBtn.titleLabel setText:[[obj allKeys] firstObject]];
        [itemBtn.iconView setImage:[UIImage imageNamed:[[obj allValues] firstObject]]];
        [itemBtn addTarget:ws action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:itemBtn];
        
        [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125);
            make.bottom.mas_equalTo(ws);
            make.width.mas_equalTo(lW / 4);
            
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right);
            }else{
                make.left.mas_equalTo(0);
            }
        }];

        lastBtn = itemBtn;
    }];
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

@end

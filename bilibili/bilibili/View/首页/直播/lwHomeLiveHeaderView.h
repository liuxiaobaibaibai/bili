//
//  lwHomeLiveHeaderView.h
//  bilibili
//
//  Created by 刘威 on 16/10/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwLiveVideoPartitionModel;

@class lwLiveVideoModel;

typedef enum : NSUInteger {
    lwHomeLiveHeaderViewStyleTitle = 0,
    lwHomeLiveHeaderViewStyleBanner,
    lwHomeLiveHeaderViewStyleBannerWithMenu,
    
} lwHomeLiveHeaderViewStyle;

@protocol lwLiveVideoHeaderCellDelegate <NSObject>

- (void)iconButtonClick:(UIButton *)btn;

@end

@interface lwHomeLiveHeaderView : UICollectionReusableView

@property (strong, nonatomic, readonly) lwLiveVideoPartitionModel *partitionModel;

@property (strong, nonatomic, readonly) lwLiveVideoModel *liveVideo;

@property (weak, nonatomic) id <lwLiveVideoHeaderCellDelegate> delegate;

- (void)configCell:(id)liveHeaderModel Style:(lwHomeLiveHeaderViewStyle)style Completion:(void(^)(id object))cmpletion;


@end

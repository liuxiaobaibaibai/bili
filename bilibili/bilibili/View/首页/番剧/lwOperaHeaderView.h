//
//  lwOperaHeaderView.h
//  bilibili
//
//  Created by 刘威 on 16/9/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwOperaBaseModel;

typedef enum : NSUInteger {
    lwOperaHeaderViewStyleBanner,           // 只有banner
    lwOperaHeaderViewStyleBottomBanner,           // 只有底部banner
    lwOperaHeaderViewStyleBannerWithTitle,  // banner + 标题（其实也就是一个section的头部）
    lwOperaHeaderViewStyleTitle,            // 只有标题
} lwOperaHeaderViewStyle;

@interface lwOperaHeaderView : UICollectionReusableView

@property (strong, nonatomic, readonly) lwOperaBaseModel *operaModel;

/**
 数据

 @param model      数据model
 @param style      样式
 */
- (void)operaModel:(lwOperaBaseModel *)model Style:(lwOperaHeaderViewStyle)style;

@end

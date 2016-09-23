//
//  lwHomeRecommendFooterView.h
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwRecommendBaseModel;

typedef enum : NSUInteger {
    lwHomeRecommendFooterTypeOpera = 0,             // 两个按钮
    lwHomeRecommendFooterTypeOperaWithBanner,   // 两个按钮+标题+按钮
    lwHomeRecommendFooterTypeTitleWithBanner,   // 标题和banner
    lwHomeRecommendFooterTypeUsually            // 空白
} lwHomeRecommendFooterType;

@interface lwHomeRecommendFooterView : UICollectionReusableView

@property (strong, nonatomic, readonly) lwRecommendBaseModel *footerModel;

- (void)footerModel:(lwRecommendBaseModel *)model Type:(lwHomeRecommendFooterType)type Completion:(void (^)(id object))completion;

@end

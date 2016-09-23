//
//  lwHomeRecommendHeaderView.h
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwRecommendBaseModel;

typedef enum : NSUInteger {
    lwHomeRecommendHeaderTypeTitle = 0,
    lwHomeRecommendHeaderTypeBanner,
    lwHomeRecommendHeaderTypeTitleWithBanner,
    lwHomeRecommendHeaderTypeUsually
} lwHomeRecommendHeaderType;

@interface lwHomeRecommendHeaderView : UICollectionReusableView

@property (strong, nonatomic, readonly) lwRecommendBaseModel *headerModel;

- (void)headerModel:(lwRecommendBaseModel *)model Type:(lwHomeRecommendHeaderType)type Completion:(void (^)(id object))completion;

@end

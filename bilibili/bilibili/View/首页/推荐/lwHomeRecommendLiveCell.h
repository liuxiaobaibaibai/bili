//
//  lwHomeRecommendLiveCell.h
//  bilibili
//
//  Created by lw on 2016/9/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwRecommendBodyModel;

@interface lwHomeRecommendLiveCell : UICollectionViewCell

@property (strong, nonatomic, readonly) lwRecommendBodyModel *liveModel;

- (void)liveModel:(lwRecommendBodyModel *)liveModel Last:(BOOL)last Completion:(void(^)(id object))completion;

@end

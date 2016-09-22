//
//  lwHomeRecommendCell.h
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwRecommendBodyModel;

@interface lwHomeRecommendCell : UICollectionViewCell

@property (strong, nonatomic, readonly) lwRecommendBodyModel *body;

- (void)recommendModel:(lwRecommendBodyModel *)model Last:(BOOL)last Completion:(void(^)(id object))completion;

@end

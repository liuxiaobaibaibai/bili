//
//  lwHomeRecommedActityCell.h
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwRecommendBaseModel;

@interface lwHomeRecommedActityCell : UICollectionViewCell

@property (strong, nonatomic, readonly) lwRecommendBaseModel *model;

- (void)actityModel:(lwRecommendBaseModel *)model Completion:(void(^)(id object))completion;

@end

//
//  lwHomeLiveVideoCustomCell.h
//  bilibili
//
//  Created by lw on 16/9/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwLiveModel;

@interface lwHomeLiveVideoCustomCell : UICollectionViewCell

@property (strong, nonatomic, readonly) lwLiveModel *liveModel;

- (void)liveModel:(lwLiveModel *)liveModel Last:(BOOL)last Completion:(void(^)(id object))completion;

@end

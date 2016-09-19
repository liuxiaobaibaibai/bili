//
//  lwHomeLiveVideoHeaderCell.h
//  bilibili
//
//  Created by lw on 16/9/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lwLiveVideoHeaderCellDelegate <NSObject>

- (void)iconButtonClick:(UIButton *)btn;

@end

@class lwLiveVideoModel;

@interface lwHomeLiveVideoHeaderCell : UICollectionViewCell

@property (strong, nonatomic) lwLiveVideoModel *liveVideo;

@property (weak, nonatomic) id <lwLiveVideoHeaderCellDelegate> delegate;

@end

//
//  lwHomeOperaCustomCell.h
//  bilibili
//
//  Created by 刘威 on 16/9/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    lwHomeOperaCustomCellStyleSerializing = 0,
    lwHomeOperaCustomCellStylePrevious,
} lwHomeOperaCustomCellStyle;

@class lwPreviousListModel;

@interface lwHomeOperaCustomCell : UICollectionViewCell

@property (strong, nonatomic, readonly) lwPreviousListModel *model;

- (void)operaModel:(lwPreviousListModel *)model Style:(lwHomeOperaCustomCellStyle)style;

@end

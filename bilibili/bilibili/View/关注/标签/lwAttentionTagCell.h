//
//  lwAttentionTagCell.h
//  bilibili
//
//  Created by lw on 16/9/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwAttentionTagModel;

@interface lwAttentionTagCell : UITableViewCell

@property (strong, nonatomic, readonly) lwAttentionTagModel *tagModel;

- (void)tagModel:(lwAttentionTagModel *)tag Filtered:(BOOL)filtered Completion:(void(^)(id object))completion;

@end

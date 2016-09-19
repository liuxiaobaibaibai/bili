//
//  lwLabelView.h
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwLabelView : UIView

@property (assign, nonatomic, readonly) CGFloat tagViewHeight;

- (id)initWithItems:(NSArray *)items;

@end

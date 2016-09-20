//
//  lwLabelView.h
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lwSlideTagViewDelegate <NSObject>

- (void)slideTagViewButtonClick:(NSInteger)index;

@end

@interface lwSlideTagView : UIView

@property (weak, nonatomic) id <lwSlideTagViewDelegate> delegate;

@property (assign, nonatomic, readonly) CGFloat tagViewHeight;

- (id)initWithItems:(NSArray *)items;

@end

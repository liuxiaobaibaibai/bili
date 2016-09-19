//
//  lwTagView.h
//  bilibili
//
//  Created by lw on 16/9/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwAttentionTag;


@protocol lwTagViewDelegate <NSObject>

@optional

- (void)tagViewButtonClick:(UIButton *)btn;

- (void)openButtonClick:(UIButton *)btn;

@end

@interface lwTagView : UIView

@property (strong, nonatomic) NSArray <lwAttentionTag *> *tags;

@property (weak, nonatomic) id <lwTagViewDelegate>delegate;


@end

//
//  UIButton+lwButton.h
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (lwButton)

+ (UIButton *)createButton:(NSString *)text TitleColor:(UIColor *)titleColor Target:(id)target action:(SEL)selector;

+ (UIButton *)createLabelButton:(NSString *)title Tag:(NSInteger)tag Target:(id)target Action:(SEL)selector;

- (void)ButtonImageTitleTopBottomEdgeInsets;

- (void)setImageViewWithName:(NSString *)name;

//- (void)setImageViewWithSource:(NSString *)source;

- (void)setImageViewWithSource:(NSString *)source Scale:(CGFloat)scale;

- (void)setImageViewWithSource:(NSString *)source Local:(BOOL)local;

- (void)setImageViewWithSource:(NSString *)source Local:(BOOL)local Zoom:(BOOL)zoom;

- (void)setImageViewWithSource:(NSString *)source Size:(CGSize)size;

@end

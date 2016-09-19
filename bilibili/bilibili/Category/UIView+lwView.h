//
//  UIView+lwView.h
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (lwView)

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;
- (CGSize)size;
- (CGPoint)origin;

- (void)setCorner;

- (void)setCorner:(UIRectCorner)corner;

- (void)setCorner:(UIRectCorner)corner Radius:(CGFloat)radius;

+ (UIView *)createBorderView:(CGFloat)borderWidth BorderColor:(UIColor *)aColor CornerRadius:(CGFloat)cornerRadius;

@end

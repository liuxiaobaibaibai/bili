//
//  UIView+lwView.h
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (lwView)

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat centerX;

@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat maxX;

@property (assign, nonatomic) CGFloat maxY;

@property (assign, nonatomic) CGPoint origin;

#pragma mark size

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize  size;

- (void)setCorner;

- (void)setCorner:(UIRectCorner)corner;

- (void)setCorner:(UIRectCorner)corner Radius:(CGFloat)radius;

+ (UIView *)createBorderView:(CGFloat)borderWidth BorderColor:(UIColor *)aColor CornerRadius:(CGFloat)cornerRadius;

@end

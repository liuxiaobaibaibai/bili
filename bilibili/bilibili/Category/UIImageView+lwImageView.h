//
//  UIImageView+lwImageView.h
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    lwImageSourceTypeLocal = 0,
    lwImageSourceTypeRemote
} lwImageSourceType;

@interface UIImageView (lwImageView)

/**
 *  创建一个圆形imageView
 *  @param  sourceType      图片来源类型
 *  @param  path            来源（如果是本地则是图片名称）
 *  @return 返回创建好的imageView
 */
+ (UIImageView *)createImageView:(lwImageSourceType)sourceType ImageSurce:(NSString *)path;

/**
 *  创建一个圆形imageView
 *  @param  sourceType      图片来源类型
 *  @param  path            来源（如果是本地则是图片名称）
 *  @param  width           图片宽度
 *  @param  cornerRadius    是否开启圆角
 *  @return 返回创建好的imageView
 */
+ (UIImageView *)createImageView:(lwImageSourceType)sourceType ImageSurce:(NSString *)path Width:(CGFloat)width isCornerRadius:(BOOL)cornerRadius;

@end

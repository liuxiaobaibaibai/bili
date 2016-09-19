//
//  UIImage+lwImage.h
//  JuYingBao
//
//  Created by 刘威 on 16/6/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (lwImage)

- (UIImage *)cutCircleImage;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

@end

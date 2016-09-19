//
//  UIImageView+lwImageView.m
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIImageView+lwImageView.h"

@implementation UIImageView (lwImageView)


+ (UIImageView *)createImageView:(lwImageSourceType)sourceType ImageSurce:(NSString *)path{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.layer.masksToBounds = YES;
    
    if (path == nil || [path isEqual:[NSNull null]]) {
        return imgView;
    }
    
    switch (sourceType) {
        case lwImageSourceTypeLocal:
            imgView.image = [UIImage imageNamed:path];
            break;
        default:
            [imgView sd_setImageWithURL:[NSURL URLWithString:path]];
            break;
    }
    return imgView;
}

+ (UIImageView *)createImageView:(lwImageSourceType)sourceType ImageSurce:(NSString *)path Width:(CGFloat)width isCornerRadius:(BOOL)cornerRadius{
    UIImageView *imgView = [[UIImageView alloc] init];
    
    switch (sourceType) {
        case lwImageSourceTypeLocal:
            imgView.image = [UIImage imageNamed:path];
            break;
        default:
            [imgView sd_setImageWithURL:[NSURL URLWithString:path]];
            break;
    }
    if (cornerRadius) {
        imgView.layer.cornerRadius = width/2;
        imgView.layer.masksToBounds = YES;
    }
    
    return imgView;
}

@end

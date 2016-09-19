//
//  UILabel+lwLabel.h
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (lwLabel)


/**
 创建一个新的label

 @param direction 文字方向
 @param aColor    文字颜色

 @return label
 */
+ (UILabel *)createLabel:(NSTextAlignment)direction Color:(UIColor *)aColor;


@end

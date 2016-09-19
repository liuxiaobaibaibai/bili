//
//  UILabel+lwLabel.m
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UILabel+lwLabel.h"

@implementation UILabel (lwLabel)

+ (UILabel *)createLabel:(NSTextAlignment)direction Color:(UIColor *)aColor{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"test";
    label.textColor = aColor;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = direction;
    label.font = [UIFont systemFontOfSize:12.0];
    label.numberOfLines = 0;
    return label;
}

@end

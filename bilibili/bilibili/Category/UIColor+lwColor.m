//
//  UIColor+lwColor.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIColor+lwColor.h"

@implementation UIColor (lwColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    return [self colorWithHexString:stringToConvert Alpha:1.0];
}

+ (UIColor *)BTColor{
    return RGB(255, 87, 66);
}

+ (UIColor *)JDColor{
    return RGB(239, 42, 47);
}

+ (UIColor *)DZColor{
    return RGB(30, 34, 55);
}

+ (UIColor *)JYBColor{
    return RGB(250, 90, 90);
}
+ (UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

+ (UIColor *)biliPinkColor{
    return RGB(240, 111, 151);
}



@end

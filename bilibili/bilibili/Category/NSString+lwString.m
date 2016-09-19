//
//  NSString+lwString.m
//  sixApp
//
//  Created by lw on 16/1/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "NSString+lwString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (lwString)

/**
 *  获取当前时间戳
 */
+ (NSString *)nowTimestamp{
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"%.0f", now.timeIntervalSince1970];
}

- (NSString *)price{
    return [NSString stringWithFormat:@"￥ %@",self];
}

+ (NSString *)timestamp:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *timestamp = [formatter dateFromString:time];
    
    return [NSString stringWithFormat:@"%.0f",timestamp.timeIntervalSince1970];
}

+ (NSString *)time:(NSString *)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeInterval time = [timestamp integerValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)time:(NSString *)timestamp Format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:format];
    
    NSTimeInterval time = [timestamp integerValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [formatter stringFromDate:date];
}

/**时间字符串转成date*/
- (NSDate *)changedToDate:(NSString *)string{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:string];
    return date;
}

/**时间转成字符串*/
- (NSString *)changedToString:(NSDate *)date{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}



NSString * gen_uuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

/**
 *  大写MD5 加密
 */
- (NSString *)MD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

/**
 *  小写MD5加密
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];;
}


/**
 *  SHA1 加密
 */
- (NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (BOOL)isNull{
    return  [self isEqualToString:@""];
}


- (NSAttributedString *)strikethrough{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self
                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                         NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                      NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                      NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    return str;
}

+ (NSAttributedString *)strikethrough:(NSString *)str{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    
    NSString *temp = nil;
    NSUInteger strLocation = 0;
    NSUInteger strLength = 0;
    for(int i =0; i < [str length]; i++)
    {
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"【"]) {
            strLocation = i;
        }
        
        if ([temp isEqualToString:@"】"]) {
            strLength = i+1;
        }
    }
    
    NSRange range = NSMakeRange(strLocation, strLength);
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor JDColor] range:range];
    return attributeString;
}

+ (NSAttributedString *)strikethrough:(NSString *)str CurrentColor:(UIColor *)color{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:color}];
    
    NSString *temp = nil;
    NSUInteger strLocation = 0;
    NSUInteger strLength = 0;
    for(int i =0; i < [str length]; i++)
    {
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"【"]) {
            strLocation = i;
        }
        
        if ([temp isEqualToString:@"】"]) {
            strLength = i+1;
        }
    }
    
    NSRange range = NSMakeRange(strLocation, strLength);
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor JDColor] range:range];
    return attributeString;
}

- (NSAttributedString *)underline{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self
                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                                                          NSForegroundColorAttributeName:[UIColor JDColor],
                                                                          NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                          NSStrikethroughColorAttributeName:[UIColor JDColor]}];
    return str;
}


+ (NSString *)escapeHTMLStr:(NSString *)html{
    NSString *content = @"<html ><style >.pd {width: 100%,backgroundColor:black;float:left;}.pd img{width: 100%;}</style><body class=\"pd\">JYB_CONTENT</body></html>";
    content = [content stringByReplacingOccurrencesOfString:@"JYB_CONTENT" withString:html];
    
    return content;
}

+ (CGSize)computedSize:(NSString *)content Font:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(lW-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGSize)computedSize:(CGSize)size Font:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize strSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return strSize;
}

- (NSMutableAttributedString *)originPrice:(NSString *)cutStr Font:(UIFont *)font{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSString *temp = nil;
    int startIndex = 0;
    NSInteger strLen = self.length;
    for (int i = 0; i<self.length; i++) {
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:cutStr]) {
            startIndex = i+1;
        }
    }
    UIFont *subFont = [UIFont systemFontOfSize:font.pointSize-4];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:subFont,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(startIndex, strLen-startIndex)];
    return att;
}

- (NSMutableAttributedString *)msg:(NSString *)cutStr Style:(UIFont *)font{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSString *temp = nil;
    int startIndex = 0;
    NSInteger strLen = self.length;
    for (int i = 0; i<self.length; i++) {
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:cutStr]) {
            startIndex = i+1;
            strLen -= startIndex;
        }
    }
    UIFont *subFont = [UIFont systemFontOfSize:font.pointSize-2];
    [att addAttributes:@{NSForegroundColorAttributeName:RGB(10, 10, 10),NSFontAttributeName:subFont} range:NSMakeRange(startIndex, strLen)];
    return att;
}


+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}


- (NSMutableAttributedString *)lineSpace:(CGFloat)space{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self
                                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                                        NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    return att;
}

- (NSString *)jsonStringForUrlPath{
    
    NSURL *url = [NSURL URLWithString:self];
    
    NSArray *result = [[url query] componentsSeparatedByString:@"&"];
    
    NSMutableArray *r = [NSMutableArray new];
    for (NSString *str in result) {
        if (![str isNull]) {
            [r addObject:[str componentsSeparatedByString:@"="]];
        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSArray *c in r) {
        [dict setObject:[c lastObject] forKey:[c firstObject]];
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *target = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return target;
}

- (NSMutableDictionary *)dictForUrlPath{
    NSURL *url = [NSURL URLWithString:self];
    
    NSArray *result = [[url query] componentsSeparatedByString:@"&"];
    
    NSMutableArray *r = [NSMutableArray new];
    for (NSString *str in result) {
        if (![str isNull]) {
            [r addObject:[str componentsSeparatedByString:@"="]];
        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSArray *c in r) {
        [dict setObject:[c lastObject] forKey:[c firstObject]];
    }
    
    return dict;
}

- (NSString *)htmlString{
    NSString *result = [NSString stringWithFormat:@"%@",self];
    
    /**
     &lt;	<	小于号或显示标记
     &gt;	>	大于号或显示标记
     &amp;	&	可用于显示其它特殊字符
     &quot;	“	引号
     &reg;	®	已注册
     &copy;	©	版权
     &trade;	™	商标
     &ensp;	 	半个空白位
     &emsp;	 	一个空白位
     &nbsp;
     **/
    NSDictionary *htmls = @{@"&lt;":@"<",@"&gt;":@">",@"&amp;":@"&",@"&quot;":@"\"",@"&quot;":@"®",@"&copy;":@"©",@"&trade;":@"™",@"&ensp;":@" ",@"&emsp;":@" ",@"&nbsp;":@" "};
    
    for (int i = 0 ; i<[[htmls allKeys] count]; i++) {
        NSString *key = [htmls allKeys][i];
        result = [result stringByReplacingOccurrencesOfString:key withString:htmls[key]];
    }
    
    result = [result stringByReplacingOccurrencesOfString:@"<img" withString:@"<img style=\"width: 100%\""];
    
    return result;
}


@end

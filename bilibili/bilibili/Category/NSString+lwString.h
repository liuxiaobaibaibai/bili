//
//  NSString+lwString.h
//  sixApp
//
//  Created by lw on 16/1/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (lwString)

/**获取当前时间戳*/
+ (NSString *)nowTimestamp;

/**获取指定时间时间戳**/
+ (NSString *)timestamp:(NSString *)time;

/**时间戳转时间字符串*/
+ (NSString *)time:(NSString *)timestamp;

+ (NSString *)time:(NSString *)timestamp Format:(NSString *)format;

/**MD5（大写加密）*/
- (NSString *)MD5;

/**MD5（小写加密）*/
- (NSString *)md5;

NSString * gen_guid();

/**sha1加密*/
- (NSString *) sha1;

/**添加删除线*/
- (NSAttributedString *)strikethrough;

/**过滤html 代码*/
+ (NSString *)filterHTML:(NSString *)html;

/**
 *  显示为金额
 **/
- (NSString *)price;

/**
 *  获取url里面参数的json字符串格式
 */
- (NSString *)jsonStringForUrlPath;

/**
 *  获取url里面的参数的字典格式
 */
- (NSMutableDictionary *)dictForUrlPath;

/**
 *  设置价格和原价，原价删除线，灰色字体
 *  @param  cutStr  用来切割的字符串
 *  @return         返回结果
 */
- (NSMutableAttributedString *)originPrice:(NSString *)cutStr Font:(UIFont *)font;

/**
 *  修改消息列表的样式
 *  @param  cutStr 分割字符串
 *  @param  font   指定特殊字体
 *  @return 返回修改后的结果
 */
- (NSMutableAttributedString *)msg:(NSString *)cutStr Style:(UIFont *)font;

/**
 *  修改行间距
 *  @param  space   行间距
 */
- (NSMutableAttributedString *)lineSpace:(CGFloat)space;

/**
 设置行间距，字间距

 @param space     字间距
 @param lineSpace 行间距

 @return 富文本
 */
- (NSMutableAttributedString *)kernSpace:(CGFloat)space LineSpace:(CGFloat)lineSpace;

/**
 *  修改部分字体颜色
 *  @param  str 要修改的字符串
 *  @return 返回修改后的字符串
 */
+ (NSAttributedString *)strikethrough:(NSString *)str;

/**
 *  修改部分字体颜色
 *  @param  str     要修改的字符串
 *  @param  color   默认的字体颜色
 *  @return 返回修改后的字符串
 */
+ (NSAttributedString *)strikethrough:(NSString *)str CurrentColor:(UIColor *)color;

/**添加下划线*/
- (NSAttributedString *)underline;

/**判断字符串是否为空*/
- (BOOL)isNull;

/**
 *  转义html字符串
 *  @param  html    要转义的html字符串
 *  @return 返回转义后的html字符串
 */
+ (NSString *)escapeHTMLStr:(NSString *)html;

/**
 *  获取当前字符串的尺寸
 *  @parma  content 当前字符串
 *  @param  font    字体
 *  @return 返回当前字符串的尺寸
 */
+ (CGSize)computedSize:(NSString *)content Font:(UIFont *)font;

/**
 *  获取当前字符串的尺寸
 *  @parma  size 尺寸的限制
 *  @param  font    字体
 *  @return 返回当前字符串的尺寸
 */
- (CGSize)computedSize:(CGSize)size Font:(UIFont *)font;

- (NSString *)htmlString;

@end

//
//  lwCommon.h
//  sixApp
//
//  Created by lw on 15/11/6.
//  Copyright © 2015年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface lwCommon : NSObject

#pragma mark - about device

/**
 获取电池状态

 @return 电池剩余电量
 */
+ (CGFloat)getBatteryQuantity;

/**
 获取总内存大小

 @return 总内存大小
 */
+ (long long)getTotalMemorySize;

/**
 获取当前可用内存

 @return 当前可用内存
 */
+ (long long)getAvailableMemorySize;

/**
 磁盘总空间

 @return 总空间大小
 */
+ (CGFloat)diskOfAllSizeMBytes;

/**
 磁盘可用空间

 @return 可用空间大小
 */
+ (CGFloat)diskOfFreeSizeMBytes;

/**
 long long 转成字符串

 @param fileSize 文件大小

 @return 字符串（文件大小）
 */
+ (NSString *)fileSizeToString:(unsigned long long)fileSize;

#pragma mark - other

/**
 获取链接中的参数

 @param url   链接
 @param param 参数key
 
 @return 参数value
 */
+ (NSString *)paramValueOfUrl:(NSString *)url withParam:(NSString *)param;

/**
 *  倒计时操作
 *  @param  timeLine        倒计时时间
 *  @param  canOperation    倒计时结束回调操作
 *  @param  failed          倒计时开始回调操作
 */
+ (void)startWithTime:(NSInteger)timeLine CanOperation:(void(^)())canOperation Failed:(void(^)(NSString *time))failed;

/// 判断是否联网
+ (BOOL)connectNetWork;

// 拨打电话
+ (void)call:(NSString *)phoneNo;

/// 是否是开发模式
+ (BOOL)debug;

+ (BOOL)isWXAppInstalled;

/**
 *  计算金额
 *  @param  firstValue  第一个数
 *  @param  type        0—>加    1->减    2->乘    3->除
 *  @param  secondValue 第二个数
 *  @return 返回计算的结果
 */
+ (NSString *)compute:(NSString *)firstValue By:(int)type Value:(NSString *)secondValue;

/**
 *  生成二维码
 *
 */
+ (UIImage *)generateQrCode:(NSString *)content;

+ (UIImage *)generateQrCode:(NSString *)content Size:(CGFloat)size;

/**
 *  保存图片到本地
 *  @param  img     要保存的图片对象
 *  @param  name    图片名称
 *  @param  type    图片的类型（png/jpg/jpeg...）
 *  @return 返回保存下来之后的路径
 */
+ (NSString *)saveImage:(UIImage *)img Name:(NSString *)name Type:(NSString *)type;

#pragma mark - 相关验证
/**验证是否为数字**/
+ (BOOL)isPureNumandCharacters:(NSString *)string;

// 邮箱验证
+ (BOOL)validateEmail:(NSString *)email;
/**验证邮编*/
+ (BOOL) isValidZipcode:(NSString*)value;
//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

// 网址验证
+ (BOOL)validateUrlpath:(NSString *)urlpath;

//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo;

//车型验证
+ (BOOL)validateCarType:(NSString *)CarType;

//用户名验证
+ (BOOL)validateUserName:(NSString *)name;

//密码验证
+ (BOOL)validatePassword:(NSString *)passWord;

//昵称验证
+ (BOOL)validateNickname:(NSString *)nickname;

//身份证号验证
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

// 地图导航
+ (void)turnByTurn:(CLLocationCoordinate2D)endPoint EndAddressName:(NSString *)name PhoneNo:(NSString *)phoneNo;


@end

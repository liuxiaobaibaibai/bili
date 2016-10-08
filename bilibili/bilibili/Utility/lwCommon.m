//
//  lwCommon.m
//  sixApp
//
//  Created by lw on 15/11/6.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "lwCommon.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <MapKit/MapKit.h>


#include <mach/mach.h>
#import <sys/utsname.h>

@implementation lwCommon

#pragma mark - 设备相关

//获取电池状态
+ (CGFloat)getBatteryQuantity
{
    return [[UIDevice currentDevice] batteryLevel];
}
// 获取总内存大小
+ (long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}
// 获取当前可用内存
+ (long long)getAvailableMemorySize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}
//磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
// 转成字符串
+ (NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"0 B";
        
    }else if (fileSize < KB)
    {
        return @"< 1 KB";
        
    }else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
        
    }else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}

#pragma mark - other

/**
 *  倒计时操作
 *  @param  timeLine        倒计时时间
 *  @param  canOperation    倒计时结束回调操作
 *  @param  failed          倒计时开始回调操作
 */
+ (void)startWithTime:(NSInteger)timeLine CanOperation:(void(^)())canOperation Failed:(void(^)(NSString *time))failed{
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (canOperation) {
                    canOperation();
                }
            });
        } else {
            NSInteger seconds = timeOut % 60 == 0 ? timeLine : timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failed) {
                    failed(timeStr);
                }
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

+ (BOOL)isWXAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
}

/*********************** 微信操作结束 ***********************/

+ (NSString *)paramValueOfUrl:(NSString *)url withParam:(NSString *)param{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}

+ (BOOL)debug{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:plistPath(@"lwConfig")];
    return [info[@"debug"] boolValue];
}

+ (BOOL)connectNetWork{
    // Create zero addy
    struct sockaddr_storage zeroAddress;//IP地址
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


#pragma mark - 相关验证
// 邮箱验证
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**验证邮编*/
+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}

+ (void)call:(NSString *)phoneNo{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [[[UIApplication sharedApplication] keyWindow] addSubview:callWebview];
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

// 网址验证
+ (BOOL)validateUrlpath:(NSString *)urlpath{
    NSString *carRegex = @"^[a-zA-z]+://[^\\s]*";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:urlpath];
}

//车型
+ (BOOL)validateCarType:(NSString *)CarType{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL)validateUserName:(NSString *)name{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL)validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL)validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (void)turnByTurn:(CLLocationCoordinate2D)endPoint EndAddressName:(NSString *)name PhoneNo:(NSString *)phoneNo{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<6.0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持7.0以下的系统导航" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        //当前的位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endPoint addressDictionary:nil]];
        toLocation.name = name;
        toLocation.phoneNumber = phoneNo;
        
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
}

+ (NSString *)saveImage:(UIImage *)img Name:(NSString *)name Type:(NSString *)type{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];   // 保存文件的名称
    [UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES];
    return filePath;
}

+ (BOOL)saveImage:(UIImage *)img Name:(NSString *)name Type:(NSString *)type System:(BOOL)system{
    return YES;
}


/**
 *  计算金额
 *  @param  firstValue  第一个数
 *  @param  type        0—>加    1->减    2->乘    3->除
 *  @param  secondValue 第二个数
 *  @return 返回计算的结果
 */
+ (NSString *)compute:(NSString *)firstValue By:(int)type Value:(NSString *)secondValue
{
    if ([firstValue isNull] || firstValue == nil) {
        firstValue = @"0";
    }
    
    if ([secondValue isNull] || secondValue == nil) {
        secondValue = @"0";
    }
    
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:firstValue];
    
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:secondValue];
    
    NSDecimalNumber *product;
    switch (type) {
        case 0:
        {
            // +
            product = [multiplierNumber decimalNumberByAdding:multiplicandNumber];
        }
            break;
        case 1:
        {
            // -
            product = [multiplierNumber decimalNumberBySubtracting:multiplicandNumber];
        }
            break;
        case 2:
        {
            // *
            product = [multiplierNumber decimalNumberByMultiplyingBy:multiplicandNumber];
        }
            break;
        default:
        {
            // /
            product = [multiplierNumber decimalNumberByDividingBy:multiplicandNumber];
        }
            break;
    }
    return [product stringValue];
    
}


/**
 *  生成二维码
 *  @param  content 二维码内容
 *  @return 返回二维码的数据
 */
+ (UIImage *)generateQrCode:(NSString *)content{
    return [lwCommon generateQrCode:content Size:100.f];
}

+ (UIImage *)generateQrCode:(NSString *)content Size:(CGFloat)size{
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[content dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    return [lwCommon createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

//改变二维码大小

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}


@end

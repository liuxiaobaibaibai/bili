//
//  NSDate+lwDate.m
//  JuYingBao
//
//  Created by lw on 16/5/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "NSDate+lwDate.h"

@implementation NSDate (lwDate)

// yyyy-MM-dd HH:mm:ss
+ (NSDate *)changedToDate:(NSString *)string{
    return [NSDate changedToDate:string Formatter:@"yyyy-MM-dd HH:mm:ss"];
}

// yyyy-MM-dd HH:mm:ss
+ (NSString *)changedToString:(NSDate *)date{
    return [NSDate changedToString:date Formatter:@"yyyy-MM-dd HH:mm:ss"];
}

// 转换成日期时间 - date 对象
+ (NSDate *)changedToDate:(NSString *)string Formatter:(NSString *)format{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

// 转成日期时间 - string 对象
+ (NSString *)changedToString:(NSDate *)date Formatter:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

// 转成时间戳
+ (NSString *)changedTimestamp:(NSString *)time{
    NSDate *date = [NSDate changedToDate:time];
    return [NSString stringWithFormat:@"%.0f", date.timeIntervalSince1970];
}


// 截取成日期
+ (NSString *)dateByCutDate:(NSString *)time{
    return [NSDate dateByCutDate:time Format:@"yyyy年MM月dd日"];
}

// 截取成时间
+ (NSString *)dateByCutTime:(NSString *)time{
    return [NSDate dateByCutTime:time Format:@"HH:mm:ss"];
}

+ (NSString *)dateByCutDate:(NSString *)time Format:(NSString *)format{
    NSDate *date = [NSDate changedToDate:time Formatter:@"yyyy-MM-dd HH:mm:ss"];
    
    return [NSDate changedToString:date Formatter:format];
}

+ (NSString *)dateByCutTime:(NSString *)time Format:(NSString *)format{
    
    NSDate *date = [NSDate changedToDate:time Formatter:@"yyyy-MM-dd HH:mm:ss"];
    
    return [NSDate changedToString:date Formatter:format];
}

@end

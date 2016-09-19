//
//  NSDate+lwDate.h
//  JuYingBao
//
//  Created by lw on 16/5/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (lwDate)

+ (NSDate *)changedToDate:(NSString *)string;

+ (NSString *)changedToString:(NSDate *)date;

+ (NSString *)dateByCutDate:(NSString *)time;

+ (NSString *)dateByCutTime:(NSString *)time;

+ (NSString *)changedToString:(NSDate *)date Formatter:(NSString *)format;

+ (NSDate *)changedToDate:(NSString *)string Formatter:(NSString *)format;

+ (NSString *)dateByCutDate:(NSString *)time Format:(NSString *)format;

+ (NSString *)dateByCutTime:(NSString *)time Format:(NSString *)format;

@end

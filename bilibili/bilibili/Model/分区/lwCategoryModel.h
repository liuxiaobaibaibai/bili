//
//  lwCategoryModel.h
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwCategoryModel : NSObject

@property (assign, nonatomic) BOOL isLocal;

@property (copy, nonatomic) NSString *imgPath;

@property (copy, nonatomic) NSString *title;

/**
 *  携带参数初始化
 *  
 *  @author lw 2016-08-29 17:11
 *
 *  @param  dict    字典
 *  @return id 当前类实例
 */
- (id)initWithDict:(NSDictionary *)dict;

/**
 *  获取本地预存储的数据
 *
 *  @author lw 2016-08-29 17:13
 *  @return NSMutableArray 当前类数组
 */
+ (NSMutableArray <lwCategoryModel *> *)categorySource;

/**
 *  获取本地预存储的数据
 *
 *  @author lw 2016-09-18 17:13
 *  @return NSMutableArray 个人中心
 */
+ (NSMutableArray *)personalMenu;

@end

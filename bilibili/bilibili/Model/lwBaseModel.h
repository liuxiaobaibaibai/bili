//
//  lwBaseModel.h
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwBaseModel : NSObject

@property (copy, nonatomic) NSString *a;
@property (copy, nonatomic) NSString *b;
@property (copy, nonatomic) NSString *c;

- (id)initWithDict:(NSDictionary *)dict;

/**
 *  获取文件中的数据
 *
 *  @author lw 2016-08-30 17:01
 *
 *  @param  fileName  文件名
 *  @param  type      文件类型
 *  @return NSDictionary
 */
+ (NSDictionary *)source:(NSString *)fileName Type:(NSString *)type;


/*********************************************************************/

/**
 *  将对象转换成Model
 */
- (void)objectChangeToModel:(id)object;

/**
 *  将model转换成字典
 **/
- (NSDictionary *)modelChangeToDictionary;

/**
 *  作为数据源中的键对照model中的变量名
 */
- (NSDictionary *)propertyValueForKey;


@end

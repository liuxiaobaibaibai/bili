//
//  lwNetwork.h
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id object);

typedef void(^fail)(id object,NSError *error);

@interface lwNetwork : NSObject

+ (void)GET:(NSString *)path Param:(NSMutableDictionary *)param Success:(success)success Fail:(fail)fail;
+ (void)POST:(NSString *)path Param:(NSMutableDictionary *)param Success:(success)success Fail:(fail)fail;
@end

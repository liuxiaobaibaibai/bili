//
//  lwFindBaseModel.h
//  bilibili
//
//  Created by lw on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"

@interface lwFindBaseModel : lwBaseModel

@property (assign, nonatomic) BOOL isLocal;

@property (copy, nonatomic) NSString *imgPath;

@property (copy, nonatomic) NSString *title;

- (id)initWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)findConfig;

@end

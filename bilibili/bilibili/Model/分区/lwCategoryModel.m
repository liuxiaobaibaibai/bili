//
//  lwCategoryModel.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCategoryModel.h"

@implementation lwCategoryModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.isLocal = YES;
        self.imgPath = dict[@"icon"];
        self.title = dict[@"title"];
    }
    return self;
}

+ (NSMutableArray <lwCategoryModel *> *)categorySource{
    NSMutableArray *results = [NSMutableArray new];
    NSArray *categories = [NSArray arrayWithContentsOfFile:plistPath(@"lwCategorySource")];
    for (NSDictionary *info in categories) {
        lwCategoryModel *model = [[lwCategoryModel alloc] initWithDict:info];
        [results addObject:model];
    }
    return results;
}

+ (NSMutableArray *)personalMenu{
    NSMutableArray *personal = [NSMutableArray new];
    NSDictionary *categories = [NSDictionary dictionaryWithContentsOfFile:plistPath(@"lwPersonalMenuList")];
    
    for (int i = 0; i<[[categories allKeys] count]; i++) {
        NSDictionary *info = categories[[categories allKeys][i]];
        NSMutableArray *subMenu = [NSMutableArray new];
        for (NSDictionary *sub in info) {
            lwCategoryModel *model = [[lwCategoryModel alloc] initWithDict:sub];
            [subMenu addObject:model];
        }
        [personal addObject:subMenu];
    }
    return personal;
}

@end

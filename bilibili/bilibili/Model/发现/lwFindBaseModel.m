//
//  lwFindBaseModel.m
//  bilibili
//
//  Created by lw on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFindBaseModel.h"

@implementation lwFindBaseModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.isLocal = YES;
        self.imgPath = dict[@"icon"];
        self.title = dict[@"title"];
    }
    return self;
}

+ (NSMutableArray *)findConfig{
    NSMutableArray *result = [NSMutableArray new];
    
    NSArray *source = [NSArray arrayWithContentsOfFile:plistPath(@"lwFindConfigList")];
    
    for (NSArray *section in source) {
        NSMutableArray *subArray = [NSMutableArray new];
        for (NSDictionary *info in section) {
            lwFindBaseModel *model = [[lwFindBaseModel alloc] initWithDict:info];
            [subArray addObject:model];
        }
        [result addObject:subArray];
    }
    
    return result;
}

@end

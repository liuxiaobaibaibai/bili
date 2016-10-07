//
//  lwMineSettingModel.m
//  bilibili
//
//  Created by 刘威 on 16/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineSettingModel.h"

@implementation lwMineSettingModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.title = dict[@"title"];
        self.type = [dict[@"type"] intValue];
        self.target = dict[@"target"];
    }
    return self;
}

+ (NSArray *)mineSetting{
    NSArray *targets = [NSArray arrayWithContentsOfFile:plistPath(@"lwMineSetting")];
    NSMutableArray *mineSetting = [NSMutableArray new];
    for (NSArray *section in targets) {
        NSMutableArray *sections = [NSMutableArray new];
        for (NSDictionary *row in section) {
            lwMineSettingModel *setting = [[lwMineSettingModel alloc] initWithDict:row];
            [sections addObject:setting];
        }
        [mineSetting addObject:sections];
    }
    return mineSetting;
}

@end

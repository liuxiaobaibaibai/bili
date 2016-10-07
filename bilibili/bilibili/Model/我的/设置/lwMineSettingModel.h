//
//  lwMineSettingModel.h
//  bilibili
//
//  Created by 刘威 on 16/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"

@interface lwMineSettingModel : lwBaseModel

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) int type;
@property (copy, nonatomic) NSString *target;

+ (NSArray *)mineSetting;

@end

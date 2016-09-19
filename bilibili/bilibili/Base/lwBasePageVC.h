//
//  lwBasePageVC.h
//  bilibili
//  分页控制器
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseVC.h"

@interface lwBasePageVC : lwBaseVC

@property (assign, nonatomic) BOOL tabbarHidden;

/**
 *  顶部标签数组
 */
@property (copy, nonatomic, readonly) NSArray <NSString *> *labels;

/**
 *  控制器数组
 */
@property (copy, nonatomic, readonly) NSArray <NSString *> *controllers;

/**
 *  设置顶部的标签和控制器数组
 *  
 *  @author lw 2016-08-29 13:51
 *
 *  @param  labels      标签数组
 *  @param  controllers 控制器数组
 *  @return void
 */
- (void)topLabels:(NSArray <NSString *> *)labels Controllers:(NSArray <NSString *> *)controllers;

@end

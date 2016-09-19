//
//  UISegmentedControl+lwSegmentedControl.h
//  JuYingBao
//
//  Created by lw on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (lwSegmentedControl)

/**
 *  创建一个分段按钮
 *  @param  items   按钮数据
 *  @param  target  按钮事件对象
 */
+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items;

/**
 *  创建一个分段按钮
 *  @param  items   按钮数据
 *  @param  target  按钮事件对象
 *  @param  sel     操作事件
 */
+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items Target:(id)target Action:(SEL)sel;

/**
 *  创建一个分段按钮
 *  @param  items   按钮数据
 *  @param  target  按钮事件对象
 *  @param  sel     操作事件
 *  @param  zoom    是否开启标题缩放
 */
+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items Target:(id)target Action:(SEL)sel Zoom:(BOOL)zoom;

@end

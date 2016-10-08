//
//  lwBaseVC.h
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwBaseVC : UIViewController

/**
 *  弹出等待视图
 *
 *  @author lw 2016-08-26 15:58
 *
 *  @return void
 */
- (void)showToast;

/**
 *  弹出等待视图
 *
 *  @author lw 2016-08-26 15:58
 *
 *  @param  msg     提示信息
 *  @return void
 */
- (void)showToast:(NSString *)msg;

/**
 *  弹出等待视图
 *
 *  @author lw 2016-08-26 15:58
 *
 *  @param  msg     提示信息
 *  @param  timer   提示视图消失时间
 *  @return void
 */
- (void)showToast:(NSString *)msg AfterHideDelay:(NSTimeInterval)timer;

/**
 *  present到指定的控制器
 *
 *  @author lw 2016-08-26 15:41
 *
 *  @param  controllerName  控制器的类名
 *  @param  animated        是否开启动画效果
 *  @param  completion      控制器初始化完成之后回调的操作
 *  @param  finish          跳转完成之后的回调操作
 *  @return void
 */
- (void)presentController:(NSString *)controllerName Animated:(BOOL)animated Completion:(void(^)(id controller))completion Finish:(void(^)(void))finish;

/**
 *  present到指定的控制器
 *
 *  @author lw 2016-08-26 15:41
 *
 *  @param  controllerName  控制器的类名
 *  @param  completion      控制器初始化完成之后回调的操作
 *  @param  finish          跳转完成之后的回调操作
 *  @return void
 */
- (void)presentController:(NSString *)controllerName Completion:(void(^)(id controller))completion Finish:(void(^)(void))finish;

/**
 *  push到指定的控制器
 *
 *  @author lw 2016-08-26 15:25
 *
 *  @param  controllerName  控制器的类名
 *  @param  completion      控制器初始化完成之后的回调操作
 *  @param  animated        是否开启动画效果
 *  @return void
 */
- (void)pushController:(NSString *)controllerName Animated:(BOOL)animated Completion:(void(^)(id controller))completion;

/**
 *  push到指定的控制器
 *
 *  @author lw 2016-08-26 15:18
 *
 *  @param  controllerName  控制器的类名
 *  @param  completion      控制器初始化完成之后的回调操作
 */
- (void)pushController:(NSString *)controllerName Completion:(void(^)(id controller))completion;


@end

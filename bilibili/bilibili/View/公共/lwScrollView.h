//
//  lwScrollView.h
//  lwScrollView
//
//  Created by lw on 16/8/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lwScrollViewDelegate <NSObject>

/**
 *
 *  幻灯片点击事件
 *  
 *  @author lw  2016-09-18
 *  
 *  @param  sender  操作对象
 *  @param  index   当前索引
 *  @return
 */
- (void)flashClick:(id)sender Index:(NSInteger)index;

@end

@interface lwScrollView : UIView

<
    UIScrollViewDelegate
>

/**
 *  幻灯片代理
 */
@property (weak, nonatomic) id <lwScrollViewDelegate> delegate;

/**
 *  幻灯片数组
 */
@property (copy, nonatomic) NSArray *flashs;

/**
 *  自动滚动时间
 */
@property (assign, nonatomic) NSTimeInterval timer;

/**
 *  是否开启自动滚动
 *  默认开始
 */
@property (assign, nonatomic) BOOL autoScroll;

/**
 *  数据源是否是本地数据
 */
@property (assign, nonatomic) BOOL sourceIsLocal;

/**
 *
 *  初始化
 *
 *  @author lw
 *
 *  @time 2016-09-17 20：52
 *
 *  @param  frame       坐标
 *  @param  source      图片来源
 *  @param  delegate    代理
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray *)sources Delegate:(id)delegate;

@end

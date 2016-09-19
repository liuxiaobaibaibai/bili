//
//  lwBaseNavVC.m
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseNavVC.h"

@interface lwBaseNavVC ()

@end

@implementation lwBaseNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 状态栏变白
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    // 返回按钮字体颜色变白
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 标题字体白色背景色透明
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor clearColor]}];
    // navigationBar 设成哔哩哔哩粉
    self.navigationBar.barTintColor = [UIColor biliPinkColor];
}


@end

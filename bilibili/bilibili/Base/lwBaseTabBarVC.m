//
//  lwBaseTabBarVC.m
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseTabBarVC.h"

@interface lwBaseTabBarVC ()
<
UITabBarDelegate,
UITabBarControllerDelegate
>

@end

@implementation lwBaseTabBarVC

- (id)init{
    self = [super init];
    if (self) {
        [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UITabBar appearance] setTintColor:[UIColor biliPinkColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma makr -
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController:) name:@"lwTabber_changeViewController" object:nil];
}


- (void)changeViewController:(NSNotification *)noti{
    NSInteger idx = [noti.userInfo[@"index"] integerValue];
    if (self.viewControllers.count != 0) {
        self.selectedViewController = self.viewControllers[idx];
    }
}


@end

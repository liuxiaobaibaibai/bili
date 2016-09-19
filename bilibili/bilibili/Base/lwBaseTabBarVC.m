//
//  lwBaseTabBarVC.m
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseTabBarVC.h"

@interface lwBaseTabBarVC ()

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


@end

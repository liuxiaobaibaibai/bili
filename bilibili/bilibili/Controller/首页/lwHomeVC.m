//
//  lwHomeVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeVC.h"

@interface lwHomeVC ()

@end

@implementation lwHomeVC

#pragma mark - init

- (id)init{
    self = [super init];
    if (self) {
        [self topLabels:@[@"直播",@"推荐",@"番剧"] Controllers:@[@"lwLiveVideoVC",@"lwRecommendVC",@"lwSoapOperaVC"]];
    }
    return self;
}

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor biliPinkColor]];
}

#pragma mark - userAction


@end

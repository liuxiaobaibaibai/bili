//
//  lwAttentionVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAttentionVC.h"

@interface lwAttentionVC ()

@end

@implementation lwAttentionVC

- (id)init{
    self = [super init];
    if (self) {
        [self topLabels:@[@"追番",@"动态",@"标签"] Controllers:@[@"lwChaseSopaOperaVC",@"lwDynamicVC",@"lwLabelVC"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}




@end

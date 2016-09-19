//
//  lwRecommendVC.m
//  bilibili
//
//  Created by lw on 16/8/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwRecommendVC.h"

@interface lwRecommendVC ()

@end

@implementation lwRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor JDColor];
    [self.view addSubview:aView];
    
    WS(ws);
    
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.center.mas_equalTo(ws.view);
    }];
    
}

@end

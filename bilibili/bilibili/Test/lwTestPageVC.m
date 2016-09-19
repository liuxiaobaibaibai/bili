//
//  lwTestPageVC.m
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwTestPageVC.h"

#import "lwLabelView.h"

@interface lwTestPageVC ()
{
    lwLabelView *tagView;
}

@end

@implementation lwTestPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tagView = [[lwLabelView alloc] initWithItems:@[@"标asd签1",@"as阿斯顿标签3",@"标签1",@"标签1",@"标签1",@"标签1",@"标签1",@"标签1",@"标签3",@"标签1",@"标签1",@"标签1",@"标签1",@"标签1as阿斯顿"]];
    tagView.backgroundColor = [UIColor biliPinkColor];
    [self.view addSubview:tagView];
    
    WS(ws);
    
    CGFloat h = tagView.tagViewHeight;
    
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(h);
        make.center.equalTo(ws.view);
    }];
}



@end

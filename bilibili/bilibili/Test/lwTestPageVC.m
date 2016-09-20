//
//  lwTestPageVC.m
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwTestPageVC.h"

#import "lwSlideTagView.h"

@interface lwTestPageVC ()
<
lwSlideTagViewDelegate
>
{
    lwSlideTagView *tagView;
}

@end

@implementation lwTestPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tagView = [[lwSlideTagView alloc] initWithItems:@[@"是的",@"是的阿阿斯顿标签",@"是的",@"是的阿",@"标签",@"标",@"标签",@"标签啊",@"标签是的"]];
    tagView.delegate = self;
    [self.view addSubview:tagView];
    
    WS(ws);
    
    CGFloat h = tagView.tagViewHeight;
    
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lNavH);
        make.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(h);
    }];
}

#pragma mark - lwSlideTagViewDelegate
- (void)slideTagViewButtonClick:(NSInteger)index{
    // 做翻页控制
}



@end

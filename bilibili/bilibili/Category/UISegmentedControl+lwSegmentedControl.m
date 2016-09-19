//
//  UISegmentedControl+lwSegmentedControl.m
//  JuYingBao
//
//  Created by lw on 16/6/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UISegmentedControl+lwSegmentedControl.h"

@implementation UISegmentedControl (lwSegmentedControl)

+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items{
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:items];
    [seg setTintColor:[UIColor whiteColor]];
    seg.selectedSegmentIndex = 0;
    
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor JDColor]}
                       forState:UIControlStateSelected];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor DZColor]}
                       forState:UIControlStateNormal];
    
    
    [seg setBackgroundColor:[UIColor whiteColor]];
    return seg;
}

+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items Target:(id)target Action:(SEL)sel{
    UISegmentedControl *seg = [UISegmentedControl createSegmentedControl:items];
    [seg addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
    return seg;
}

+ (UISegmentedControl *)createSegmentedControl:(NSArray *)items Target:(id)target Action:(SEL)sel Zoom:(BOOL)zoom{
    UISegmentedControl *seg = [UISegmentedControl createSegmentedControl:items Target:target Action:sel];
    if (zoom) {
        [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor JDColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:18.0]}
                           forState:UIControlStateSelected];
        [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor DZColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
                           forState:UIControlStateNormal];
    }else{
        [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor JDColor]}
                           forState:UIControlStateSelected];
        [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor DZColor]}
                           forState:UIControlStateNormal];
    }
    return seg;
}

@end

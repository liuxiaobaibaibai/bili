//
//  lwMineBaseSubVC.h
//  bilibili
//
//  Created by lw on 2016/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseVC.h"

@class lwNavigationBar;

@interface lwMineBaseSubVC : lwBaseVC

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *source;

@property (weak, nonatomic) id delegate;

@property (weak, nonatomic) id dataSource;

@property (assign, nonatomic) BOOL isCorr;

@property (assign, nonatomic) BOOL isGroup;

@property (strong, nonatomic) lwNavigationBar *navBar;

@property (copy, nonatomic) NSString *vcTitle;

- (void)setupView;

@end

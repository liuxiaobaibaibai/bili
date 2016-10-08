//
//  lwMineBaseSubVC.h
//  bilibili
//
//  Created by lw on 2016/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseVC.h"

@interface lwMineBaseSubVC : lwBaseVC

@property (strong, nonatomic) UITableView *myTableView;

@property (copy, nonatomic) NSArray *source;

@property (weak, nonatomic) id delegate;

@property (weak, nonatomic) id dataSource;

@property (assign, nonatomic) BOOL isCorr;

@end

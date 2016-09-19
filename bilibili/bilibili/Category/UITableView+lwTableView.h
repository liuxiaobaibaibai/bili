//
//  UITableView+lwTableView.h
//  sixApp
//
//  Created by lw on 16/1/12.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (lwTableView)

<
    UIScrollViewDelegate
>

+ (UITableView *)tableViewTarget:(id)target Style:(UITableViewStyle)style;

- (void)hideKeyBoard:(BOOL)hidden;

- (void)scrollToBottomWithAnimation:(BOOL)animation;

- (void)scrollToTopWithAnimation:(BOOL)animation;

- (void)scrollHiddenKeyBoard;

- (void)removeNotidication;

- (void)headerRefreshStaring:(id)sender;

- (void)headerRefreshEnding;

- (void)footerRefreshStarting;

- (void)footerRefreshEnding;



#pragma mark - test
- (void)loadHeaderRefreshControl:(id)target Action:(SEL)sel Completion:(void (^)(UIRefreshControl *control))completion;

@end

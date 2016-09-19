//
//  UITableView+lwTableView.m
//  sixApp
//
//  Created by lw on 16/1/12.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UITableView+lwTableView.h"

//static double lastPoint;

@implementation UITableView (lwTableView)

- (void)loadHeaderRefreshControl:(id)target Action:(SEL)sel Completion:(void (^)(UIRefreshControl *control))completion{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
    if (![[self subviews] containsObject:refreshControl]) {
        [self addSubview:refreshControl];
    }
    completion(refreshControl);
}

#pragma mark - refresh
- (void)headerRefreshStaring:(id)sender{
    DLog(@"开启下拉刷新代码");
    
}

- (void)headerRefreshEnding{
    DLog(@"2秒后关闭下拉刷新代码");
}

- (void)footerRefreshStarting{
    DLog(@"底部刷新开始");
}

- (void)footerRefreshEnding{
    DLog(@"底部刷新结束");
}

#pragma mark - UIScrollViewDelegate




#pragma mark - UITableView

+ (UITableView *)tableViewTarget:(id)target Style:(UITableViewStyle)style{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    myTableView.delegate = target;
    myTableView.dataSource = target;
    myTableView.tableFooterView = [[UIView alloc] init];
    myTableView.estimatedRowHeight = 44;
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.rowHeight = UITableViewAutomaticDimension;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return myTableView;
}

- (void)hideKeyBoard:(BOOL)hidden{
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


- (void)hide{
    [self.superview endEditing:YES];
}

- (void)scrollToTopWithAnimation:(BOOL)animation
{
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:animation];
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    NSUInteger section = 0;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        section = [self.dataSource numberOfSectionsInTableView:self] - 1;
    }
    
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        
        NSUInteger row = [self.dataSource tableView:self numberOfRowsInSection:section];
        
        if (row > 0) {
            
            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row - 1 inSection:section] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
            
        }
    }
}

- (void)scrollHiddenKeyBoard{
    [self addNotification];
}

#pragma mark - 
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

}
- (void)removeNotidication{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.superview);
    }];
    [self layoutIfNeeded];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.superview).mas_offset(-keyboardFrame.size.height);
    }];
    [self layoutIfNeeded];
    
//    [self scrollToBottomWithAnimation:NO];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    
}



@end

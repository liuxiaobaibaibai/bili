//
//  UIWebView+lwWebView.h
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIWebView (lwWebView)
/**添加常用手势*/
- (void)addUsuallyGestures;

- (void)scrollViewToBottom;

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

@end

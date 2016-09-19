//
//  UIWebView+lwWebView.m
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIWebView+lwWebView.h"

@implementation UIWebView (lwWebView)

- (void)addUsuallyGestures{
    UISwipeGestureRecognizer *leftSwipe  = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goForwardOperation:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBackOperation:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *topSwipe   = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(topOperation:)];
    topSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downOperation:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    [self addGestureRecognizer:leftSwipe];
    [self addGestureRecognizer:rightSwipe];
    [self addGestureRecognizer:topSwipe];
    [self addGestureRecognizer:downSwipe];
}


- (void)goBackOperation:(id)sender{
    if ([self canGoBack]) {
        [self goBack];
    }
}

- (void)goForwardOperation:(id)sender{
    if ([self canGoForward]) {
        [self goForward];
    }
}

- (void)topOperation:(id)sender{
    DLog(@"向上滑");
}

- (void)downOperation:(id)sender{
    DLog(@"向下滑");
}

- (void)scrollViewToBottom{
    NSInteger height = [[self stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    NSString* javascript = [NSString stringWithFormat:@"window.scrollBy(0, %ld);", (long)height];
    [self stringByEvaluatingJavaScriptFromString:javascript];
}


static BOOL diagStat = NO;

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* dialogue = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [dialogue show];;
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:NSLocalizedString(@"Cancel", @"Cancel"), nil];
    [dialogue show];
    while (dialogue.hidden==NO && dialogue.superview!=nil) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
    return diagStat;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WebViewGoBack" object:nil];
        
        diagStat=YES;
    }else if(buttonIndex==1){
        diagStat=NO;
    }
}

@end

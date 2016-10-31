//
//  lwWebCommonVC.m
//  bilibili
//
//  Created by lw on 2016/10/31.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwWebCommonVC.h"

#define baseURL [NSURL URLWithString:@"http://www.jianshu.com/p/edddcb3cc2d3"]
//[NSURL URLWithString:@"http://yimouleng.com/2016/01/13/ios-QRCode/#长按二维码识别"]

@interface lwWebCommonVC ()

<
UIWebViewDelegate,
NSURLSessionDelegate,
UIActionSheetDelegate,
UIGestureRecognizerDelegate
>

@property (strong, nonatomic) UIWebView *myWebView;
@property (copy, nonatomic) NSString *saveImageUrlPath;

@end

@implementation lwWebCommonVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - UserOperation

- (void)loadDataSource{
    
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [longPress locationInView:self.myWebView];
    
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.myWebView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (urlToSave.length == 0) {
        return;
    }
    
    self.saveImageUrlPath = [NSString stringWithFormat:@"%@",urlToSave];
    
    [lwCommon qrCode:urlToSave Local:NO Completion:^(NSArray *results) {
        if(results.count > 0) {
            //CIQRCodeFeature *feature = [features objectAtIndex:0];
            //NSString *scannedResult = feature.messageString; //二维码内容
            [self showActionSheet:@"提示" Buttons:@[@"保存照片",@"查看全图",@"识别图中二维码"]];
        }else{
            [self showActionSheet:@"提示" Buttons:@[@"保存照片",@"查看全图"]];
        }
    }];
}

- (void)showActionSheet:(NSString *)title Buttons:(NSArray *)btns{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    sheet.tag = 10;
    for (NSString *str in btns) {
        [sheet addButtonWithTitle:str];
    }

    [sheet showInView:self.view];
}

#pragma mark - delegate
#pragma mark - gestureRecognizer delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case 10:
        {
            NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
            if ([title isEqualToString:@"保存照片"]) {
                if (!self.saveImageUrlPath) {
                    return;
                }
                [self saveImageToDiskWithUrl:self.saveImageUrlPath];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - loadView

- (void)setupView{
    [self.view addSubview:self.myWebView];
    
    
}

#pragma mark - getter

- (UIWebView *)myWebView{
    if (_myWebView == nil) {
        _myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _myWebView.delegate = self;
        NSString *urlPath = @"http://192.168.1.35/1.html";
        [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        
        UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPressed.delegate = self;
        [_myWebView addGestureRecognizer:longPressed];
    }
    return _myWebView;
}


@end

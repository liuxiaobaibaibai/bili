//
//  lwBaseVC.m
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseVC.h"

@interface lwBaseVC ()
<
MBProgressHUDDelegate
>

{
     MBProgressHUD *HUD;
}

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation lwBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UserOperation 

- (void)showToast{
    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
    HUD.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD showAnimated:YES];
    });
}

- (void)showToast:(NSString *)msg{
    [self showToast:msg AfterHideDelay:1.5];
}

- (void)showToast:(NSString *)msg AfterHideDelay:(NSTimeInterval)timer{
    WS(ws);
    dispatch_async(dispatch_get_main_queue(), ^{
        HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = ws;
        HUD.label.text = msg;
        
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:timer];
    });
}

- (UIViewController *)instantiate:(NSString *)storyboardName TargetVC:(NSString *)identifier{
    NSAssert(identifier, @"identifier can not be nil!");
    UIStoryboard *main = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [main instantiateViewControllerWithIdentifier:identifier];
    if (controller) {
        return controller;
    }else{
        return nil;
    }
}

- (void)presentController:(NSString *)controllerName Animated:(BOOL)animated Completion:(void(^)(id controller))completion Finish:(void(^)(void))finish{
    NSAssert(controllerName, @"controllerName can not be nil!");
    Class class = NSClassFromString(controllerName);
    if (![[class class] isSubclassOfClass:[UIViewController class]]) {
        return;
    }
    
    UIViewController *targetController = (UIViewController *)[[class alloc] init];
    if (completion) {
        completion(targetController);
    }
    
    [targetController.view setBackgroundColor:[UIColor whiteColor]];
    [self presentViewController:targetController animated:animated completion:finish];
}

- (void)presentController:(NSString *)controllerName Completion:(void(^)(id controller))completion Finish:(void(^)(void))finish{
    [self presentController:controllerName Animated:YES Completion:completion Finish:finish];
}

- (void)pushController:(NSString *)controllerName Animated:(BOOL)animated Completion:(void(^)(id controller))completion{
    NSAssert(controllerName, @"controllerName can not be nil!");
    Class class = NSClassFromString(controllerName);
    if (![[class class] isSubclassOfClass:[UIViewController class]]) {
        return;
    }
    
    UIViewController *targetController = (UIViewController *)[[class alloc] init];
    targetController.hidesBottomBarWhenPushed = YES;
    if (completion) {
        completion(targetController);
    }
    
    [targetController.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:targetController animated:animated];
}

- (void)pushController:(NSString *)controllerName Completion:(void(^)(id controller))completion{
    [self pushController:controllerName Animated:YES Completion:completion];
}



#pragma mark - getter

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end

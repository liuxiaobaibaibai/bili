//
//  AppDelegate.m
//  bilibili
//
//  Created by lw on 16/8/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AppDelegate.h"

#import "lwBaseTabBarVC.h"
#import "lwBaseNavVC.h"
#import "lwBaseVC.h"

//  coreDataManager
#import "lwCoreDataManager.h"

@interface AppDelegate ()

@property (strong, nonatomic) lwCoreDataManager *coreDataManger;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupVC];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self.coreDataManger saveContext];
}

#pragma mark - UserOperation
- (void)setupVC{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSMutableArray *vcs = [NSMutableArray new];
    
    NSArray *tabbarConfig = [NSArray arrayWithContentsOfFile:plistPath(@"lwTabbarConfig")];
    
    for (NSDictionary *info in tabbarConfig) {
        Class class = NSClassFromString(info[@"class"]);
        if (class && [[class class] isSubclassOfClass:[UIViewController class]]) {
            lwBaseVC *controller = (lwBaseVC *)[[class alloc] init];
            
            [controller setTitle:info[@"title"]];
            [controller.tabBarItem setTitle:@""];
            [controller.view setBackgroundColor:[UIColor whiteColor]];
            [controller.tabBarItem setImage:[UIImage imageNamed:info[@"normal"]]];
            [controller.tabBarItem setSelectedImage:[UIImage imageNamed:info[@"select"]]];
            [controller.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
            lwBaseNavVC *lwNavgationVC = [[lwBaseNavVC alloc] initWithRootViewController:controller];
            lwNavgationVC.navigationBarHidden = [info[@"hideNavigationBar"] boolValue];
            [vcs addObject:lwNavgationVC];
        }
    }
    
    lwBaseTabBarVC *tabbar = [[lwBaseTabBarVC alloc] init];
    [tabbar setViewControllers:vcs];
    tabbar.selectedViewController = [vcs firstObject];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:tabbar];
    [self.window makeKeyAndVisible];
}

#pragma mark - getter
- (lwCoreDataManager *)coreDataManger{
    if (_coreDataManger == nil) {
        _coreDataManger = [[lwCoreDataManager alloc] init];
    }
    return _coreDataManger;
}



@end

//
//  lwNetwork.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwNetwork.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager ;
static AFURLSessionManager *session ;

@implementation lwNetwork

+ (AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    });
    return manager;
}

+ (AFURLSessionManager *)sharedURLSession{
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        session = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return session;
}

#pragma mark - method
+ (void)GET:(NSString *)path Param:(NSMutableDictionary *)param Success:(success)success Fail:(fail)fail{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[self sharedHTTPSession] GET:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度：%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        fail(nil,error);
    }];
}

+ (void)POST:(NSString *)path Param:(NSMutableDictionary *)param Success:(success)success Fail:(fail)fail{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[self sharedHTTPSession] POST:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度：%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        fail(nil,error);
    }];
}

@end

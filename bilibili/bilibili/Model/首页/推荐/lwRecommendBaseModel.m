//
//  lwRecommendBaseModel.m
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwRecommendBaseModel.h"

///////////
#import "lwHomeRecommendCell.h"
#import "lwHomeRecommendOperaCell.h"
#import "lwHomeRecommedActityCell.h"
///////////

@implementation lwRecommendHeaderModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.hid = [dict[@"id"] intValue];
        self.title = dict[@"title"];
        self.image = dict[@"image"];
        self.hashTag = dict[@"hash"];
        self.uri = dict[@"uri"];
    }
    return self;
}

@end

/***************************************/

@implementation lwRecommendBannerModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        id top = dict[@"top"];
        NSMutableArray *tops = [NSMutableArray new];
        if ([top isKindOfClass:[NSArray class]]) {
            for (NSDictionary *info in top) {
                lwRecommendHeaderModel *header = [[lwRecommendHeaderModel alloc] initWithDict:info];
                [tops addObject:header];
            }
        }
        self.top = tops;
        
        
        id bottom = dict[@"bottom"];
        NSMutableArray *bottoms = [NSMutableArray new];
        if ([bottom isKindOfClass:[NSArray class]]) {
            for (NSDictionary *info in bottom) {
                lwRecommendHeaderModel *bottom = [[lwRecommendHeaderModel alloc] initWithDict:info];
                [bottoms addObject:bottom];
            }
        }
        self.bottom = bottoms;
    }
    return self;
}

@end

/***************************************/

@implementation lwRecommendBodyModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.title = dict[@"title"];
        self.cover = dict[@"cover"];
        self.uri = dict[@"uri"];
        self.param = dict[@"param"];
        self.gotoTag = dict[@"goto"];
        self.play = [dict[@"play"] intValue];
        self.danmaku = [dict[@"danmaku"] intValue];
        self.area = dict[@"area"];
        self.area_id = [dict[@"area_id"] intValue];
        self.name = dict[@"name"];
        self.face = dict[@"face"];
        self.online = [dict[@"online"] intValue];
        self.index = dict[@"index"];
        self.mtime = dict[@"mtime"];
    }
    return self;
}

@end

/***************************************/

@implementation lwRecommendBaseModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.param = dict[@"param"];
        self.type = dict[@"type"];
        self.style = dict[@"style"];
        self.title = dict[@"title"];
        
        id body = dict[@"body"];
        NSMutableArray *bodys = [NSMutableArray new];
        if ([body isKindOfClass:[NSArray class]]) {
            for (NSDictionary *info in body) {
                lwRecommendBodyModel *bodyModel = [[lwRecommendBodyModel alloc] initWithDict:info];
                [bodys addObject:bodyModel];
            }
        }
        self.body = bodys;
        
        id banner = dict[@"banner"];
        NSMutableArray *banners = [NSMutableArray new];
        if ([banner isKindOfClass:[NSArray class]]) {
            for (NSDictionary *info in banner) {
                lwRecommendBannerModel *bannerModel = [[lwRecommendBannerModel alloc] initWithDict:info];
                [banners addObject:bannerModel];
            }
        }
        self.banner = banners;
        
        id ext = dict[@"ext"];
        if (ext && [ext isKindOfClass:[NSDictionary class]]) {
            self.live_count = [ext[@"live_count"] intValue];
        }
    }
    return self;
}

+ (NSMutableArray <lwRecommendBaseModel *> *)recommendSource{
    NSArray *root = [NSArray arrayWithArray:[[lwBaseModel source:@"lwHomeRecommend" Type:@""] objectForKey:@"data"]];
    NSMutableArray *results = [NSMutableArray new];
    for (NSDictionary *info in root) {
        lwRecommendBaseModel *base = [[lwRecommendBaseModel alloc] initWithDict:info];
        [results addObject:base];
    }
    return results;
}

@end

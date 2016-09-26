//
//  lwOperaBaseModel.m
//  bilibili
//
//  Created by lw on 2016/9/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwOperaBaseModel.h"

@implementation lwADBodyModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        // 暂时还不知道是什么样的
    }
    return self;
}

@end

@implementation lwADHeadModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.hid = [dict[@"id"] intValue];
        self.img = dict[@"img"];
        self.is_ad = [dict[@"is_ad"] boolValue];
        self.link = dict[@"link"];
        self.title = dict[@"title"];
    }
    return self;
}

@end

@implementation lwPreviousListModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.cover = dict[@"cover"];
        self.favourites = dict[@"favourites"];
        self.is_finish = [dict[@"is_finish"] boolValue];
        self.last_time = [dict[@"last_time"] intValue];
        self.newwest_ep_index = dict[@"newwest_ep_index"];
        self.pub_time = [dict[@"pub_time"] intValue];
        self.season_id = [dict[@"season_id"] intValue];
        self.season_status = [dict[@"season_status"] intValue];
        self.title = dict[@"title"];
        self.watching_count = [dict[@"watching_count"] intValue];
    }
    return self;
}

@end

@implementation lwOperadADModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        id body = dict[@"body"];
        NSMutableArray <lwADBodyModel *> *bodys = [NSMutableArray new];
        if ([body isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in body) {
                NSLog(@"%@ %s %d",dict,__func__,__LINE__);
            }
        }
        self.body = bodys;
        
        id head = dict[@"head"];
        NSMutableArray <lwADHeadModel *> *heads = [NSMutableArray new];
        if ([head isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in head) {
                lwADHeadModel *headModel = [[lwADHeadModel alloc] initWithDict:dict];
                [heads addObject:headModel];
            }
        }
        self.head = heads;
        
    }
    return self;
}

@end

@implementation lwOperaPreviousModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.season = [dict[@"season"] intValue];
        self.year = [dict[@"year"] intValue];
        
        id list = dict[@"list"];
        NSMutableArray <lwPreviousListModel *> *lists = [NSMutableArray new];
        if ([list isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in list) {
                lwPreviousListModel *listModel = [[lwPreviousListModel alloc] initWithDict:dict];
                [lists addObject:listModel];
            }
        }
        self.list = lists;
    }
    return self;
}

@end

@implementation lwOperaRecommendModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.cover = dict[@"cover"];
        self.coursor = [dict[@"coursor"] intValue];
        self.desc = dict[@"desc"];
        self.oid = [dict[@"id"] intValue];
        self.is_new = [dict[@"is_new"] boolValue];
        self.link = dict[@"link"];
        self.title = dict[@"title"];

    }
    return self;
}

@end

@implementation lwOperaBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        // 广告
        id ad = dict[@"ad"];
        lwOperadADModel *adModel = [[lwOperadADModel alloc] init];
        if ([ad isKindOfClass:[NSDictionary class]]) {
            adModel = [[lwOperadADModel alloc] initWithDict:ad];
        }
        self.ADModel = adModel;
        
        // 四月新番
        id previous = dict[@"previous"];
        lwOperaPreviousModel *previousModel = [[lwOperaPreviousModel alloc] init];
        if ([previous isKindOfClass:[NSDictionary class]]) {
            previousModel = [[lwOperaPreviousModel alloc] initWithDict:previous];
        }
        self.previous = previousModel;
        
        // 新番连载
        id serializing = dict[@"serializing"];
        NSMutableArray <lwPreviousListModel *> *serializings = [NSMutableArray new];
        if ([serializing isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in serializing) {
                lwPreviousListModel *list = [[lwPreviousListModel alloc] initWithDict:dict];
                [serializings addObject:list];
            }
        }
        self.serializing = serializings;
        
        // 番剧推荐
        id recommend = dict[@"operaRecommend"];
        NSMutableArray <lwOperaRecommendModel *> *recommends = [NSMutableArray new];
        if ([recommend isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in recommend) {
                lwOperaRecommendModel *recommendModel = [[lwOperaRecommendModel alloc] initWithDict:dict];
                [recommends addObject:recommendModel];
            }
        }
        self.recommend = recommends;
        
    }
    return self;
}

+ (lwOperaBaseModel *)operaSource{
    NSDictionary *rootDict = [NSDictionary dictionaryWithDictionary:[self source:@"lwSoapOpera" Type:@""]];
    lwOperaBaseModel *model = [[lwOperaBaseModel alloc] initWithDict:rootDict[@"result"]];
    return model;
}

@end

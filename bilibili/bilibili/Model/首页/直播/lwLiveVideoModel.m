//
//  lwLiveVideoModel.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwLiveVideoModel.h"

/**
 *  直播页面bannermodel
 */
@implementation lwLiveVideoBannerModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.img = dict[@"img"];
        self.remark = dict[@"remark"];
        self.link = dict[@"link"];
    }
    return self;
}


@end

/*********************************************************************/

/**
 *入口图片
 */
@implementation lwLiveVideoEnterIconModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.src = dict[@"src"];
        self.height = dict[@"height"];
        self.width = dict[@"width"];
    }
    return self;
}

@end

/**
 *  入口
 */
@implementation lwLiveVideoEnterModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.eid = [dict[@"id"] intValue];
        self.name = dict[@"name"];
        
        id icon = dict[@"entrance_icon"];
        self.iconModel = [[lwLiveVideoEnterIconModel alloc] initWithDict:icon];

    }
    return self;
}

+ (NSMutableArray <lwLiveVideoEnterModel *> *)allCategory{
    NSMutableArray <lwLiveVideoEnterModel *> *allCategory = [NSMutableArray new];
    
    NSDictionary *dict = [lwBaseModel source:@"lwHomeAllCategory" Type:@""];
    
    id data = dict[@"data"];
    if (data && [[data class] isSubclassOfClass:[NSArray class]]) {
        for (NSDictionary *info in data) {
            lwLiveVideoEnterModel *icon = [[lwLiveVideoEnterModel alloc] initWithDict:info];
            [allCategory addObject:icon];
        }
    }
    return allCategory;
}

@end

/*********************************************************************/

/**
 *  分区
 */
@implementation lwLiveVideoPartitionModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.pid = [dict[@"id"] intValue];
        self.name = dict[@"name"];
        self.area = dict[@"area"];
        self.iconModel = [[lwLiveVideoEnterIconModel alloc] initWithDict:dict[@"sub_icon"]];
        self.pCount = [dict[@"count"] intValue];
    }
    return self;
}

@end

/**
 *  归属
 */
@implementation lwLiveOwnerModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.face = dict[@"face"];
        self.mid = [dict[@"mid"] intValue];
        self.name = dict[@"name"];
    }
    return self;
}

@end

/**
 *  直播间
 */
@implementation lwLiveModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        lwLiveOwnerModel *owner = [[lwLiveOwnerModel alloc] initWithDict:dict[@"owner"]];
        lwLiveVideoEnterIconModel *cover = [[lwLiveVideoEnterIconModel alloc] initWithDict:dict[@"cover"]];
        self.owner = owner;
        self.cover = cover;
        self.title = dict[@"title"];
        self.room_id = [dict[@"room_id"] intValue];
        self.online = [dict[@"online"] intValue];
        self.area = dict[@"area"];
        self.areaID = [dict[@"area_id"] intValue];
        self.playUrl = dict[@"playurl"];
        self.accept_quality = dict[@"accept_quality"];
        self.boardcast_type = [dict[@"boardcast_type"] intValue];
        self.is_tv = [dict[@"is_tv"] boolValue];
    }
    return self;
}

@end

/**
 *  分区数组
 */
@implementation lwLiveVideoPartitionsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.partitionModel = [[lwLiveVideoPartitionModel alloc] initWithDict:dict[@"partition"]];
        NSMutableArray *liveArray = [NSMutableArray new];
        
        for (NSDictionary *info in dict[@"lives"]) {
            lwLiveModel *live = [[lwLiveModel alloc] initWithDict:info];
            [liveArray addObject:live];
        }
        
        self.lives = liveArray;
        
    }
    return self;
}


@end

/*********************************************************************/

/**
 *  推荐
 */
@implementation lwRecommendDataModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        NSMutableArray *lives = [NSMutableArray new];
        id liveArray = dict[@"lives"];
        for (NSDictionary *live in liveArray) {
            lwLiveModel *liveModel = [[lwLiveModel alloc] initWithDict:live];
            [lives addObject:liveModel];
        }
        self.lives = lives;
        
        self.partition = [[lwLiveVideoPartitionModel alloc] initWithDict:dict[@"partition"]];
        
        NSMutableArray *banners = [NSMutableArray new];
        id bannerArray = dict[@"banner_data"];
        for (NSDictionary *info in bannerArray) {
            lwLiveModel *live = [[lwLiveModel alloc] initWithDict:info];
            [banners addObject:live];
        }
        self.bannerData = banners;
        
    }
    return self;
}


@end


@implementation lwLiveVideoModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        id bannerArray = dict[@"banner"];
        NSMutableArray <lwLiveVideoBannerModel *> *banners = [NSMutableArray new];
        if (bannerArray != nil && ![bannerArray isEqual:[NSNull null]] && [[bannerArray class] isSubclassOfClass:[NSArray class]]) {
            for (NSDictionary *info in bannerArray) {
                lwLiveVideoBannerModel *banner = [[lwLiveVideoBannerModel alloc] initWithDict:info];
                [banners addObject:banner];
            }
        }
        self.banners = banners;
        
        id entranceIconArray = dict[@"entranceIcons"];
        NSMutableArray <lwLiveVideoEnterModel *> * entranceIcons = [NSMutableArray new];
        if (entranceIconArray != nil && ![entranceIconArray isEqual:[NSNull null]] && [[entranceIconArray class] isSubclassOfClass:[NSArray class]]) {
            for (NSDictionary *info in entranceIconArray) {
                lwLiveVideoEnterModel *entranceIcon = [[lwLiveVideoEnterModel alloc] initWithDict:info];
                [entranceIcons addObject:entranceIcon];
            }
        }
        self.entranceIcons = entranceIcons;
        
        id partitionArray = dict[@"partitions"];
        NSMutableArray <lwLiveVideoPartitionsModel *> * partitions = [NSMutableArray new];
        if (partitionArray != nil && ![partitionArray isEqual:[NSNull null]] && [[partitionArray class] isSubclassOfClass:[NSArray class]]) {
            for (NSDictionary *info in partitionArray) {
                lwLiveVideoPartitionsModel *p = [[lwLiveVideoPartitionsModel alloc] initWithDict:info];
                [partitions addObject:p];
            }
        }
        self.partitions = partitions;
        
        self.recommendData = [[lwRecommendDataModel alloc] initWithDict:dict[@"recommend_data"]];
        
    }
    return self;
}

+ (lwLiveVideoModel *)liveVideoSource{
    
    lwLiveVideoModel *results = [lwLiveVideoModel new];
    
    NSDictionary *dict = [lwBaseModel source:@"lwHomeLiveVideo" Type:@""];
    
    id data = dict[@"data"];
    if (data && [[data class] isSubclassOfClass:[NSDictionary class]]) {
        results = [[lwLiveVideoModel alloc] initWithDict:data];
    }

    return results;
}

@end

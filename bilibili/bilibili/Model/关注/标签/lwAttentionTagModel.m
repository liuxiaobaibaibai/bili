//
//  lwAttentionTagModel.m
//  bilibili
//
//  Created by lw on 16/9/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAttentionTagModel.h"

@implementation lwAttentionTagCount

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.view = [dict[@"view"] intValue];
        self.use = [dict[@"use"] intValue];
        self.atten = [dict[@"atten"] intValue];
    }
    return self;
}

@end

@implementation lwAttentionTag


- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.tag_id = [dict[@"tag_id"] intValue];
        self.tag_name = dict[@"tag_name"];
        self.cover = dict[@"cover"];
        self.content = dict[@"content"];
        self.type = [dict[@"type"] intValue];
        self.state = [dict[@"state"] intValue];
        self.is_atten = [dict[@"is_atten"] intValue];
        
        id count = dict[@"count"];
        lwAttentionTagCount *tagCount = [[lwAttentionTagCount alloc] init];
        if (count != nil) {
             tagCount = [[lwAttentionTagCount alloc] initWithDict:count];
        }
        self.tagCount = tagCount;
        
        self.ctime = [dict[@"ctime"] intValue];
        
        self.isSelect = NO;
    }
    return self;
}

+ (NSMutableArray <lwAttentionTag *> *)tags{
    NSMutableArray <lwAttentionTag *> *tags = [NSMutableArray new];
    
    NSDictionary *source = [lwBaseModel source:@"lwAttentionTags" Type:@""];
    NSArray *sourceArray = source[@"data"];
    
    for (NSDictionary *info in sourceArray) {
        lwAttentionTag *tag = [[lwAttentionTag alloc] initWithDict:info];
        [tags addObject:tag];
    }
    
    lwAttentionTag *allTag = [[lwAttentionTag alloc] init];
    allTag.tag_name = @"全部";
    allTag.isSelect = YES;
    allTag.tag_id = -100;
    
    [tags insertObject:allTag atIndex:0];
    
    return tags;
}

@end

//**********

@implementation lwAttentionTagAddition

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.aid = [dict[@"aid"] intValue];
        self.typeId = [dict[@"typeid"] intValue];
        self.typeName = dict[@"typename"];
        self.title = dict[@"title"];
        self.subtitle = dict[@"subtitle"];
        self.play = [dict[@"play"] intValue];
        self.review = [dict[@"review"] intValue];
        self.video_review = [dict[@"video_review"] intValue];
        self.favorites = [dict[@"favorites"] intValue];
        self.mid = [dict[@"mid"] intValue];
        self.author = dict[@"author"];
        self.link = dict[@"link"];
        self.keywords = dict[@"keywords"];
        self.aDescription = dict[@"description"];
        self.create = dict[@"create"];
        self.pic = dict[@"pic"];
        self.credit = [dict[@"credit"] intValue];
        self.conis = [dict[@"conis"] intValue];
        self.money = [dict[@"money"] intValue];
        self.duration = dict[@"duration"];
        self.status = [dict[@"status"] intValue];
        self.view = dict[@"view"];
        self.view_at = dict[@"view_at"];
        self.fav_create = dict[@"fav_create"];
        self.fav_create_at = dict[@"fav_create_at"];
        self.flag = dict[@"flag"];
    }
    return self;
}

@end

@implementation lwAttentionTagSource

static int last_tag_id = 0;

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.tag_id = [dict[@"tag_id"] intValue];
        self.name = dict[@"name"];
        self.cover = dict[@"cover"];
        
        if (last_tag_id == 0 || last_tag_id != self.tag_id) {
            self.showTag = YES;
        }else{
            self.showTag = NO;
        }
        
        last_tag_id = self.tag_id;
        
    }
    return self;
}

@end

@implementation lwAttentionTagModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.aid = [dict[@"id"] intValue];
        self.src_id = [dict[@"src_id"] intValue];
        self.add_id = [dict[@"add_id"] intValue];
        self.type = [dict[@"type"] intValue];
        self.mcid = [dict[@"mcid"] intValue];
        self.ctime = [dict[@"ctime"] intValue];
        
        id source = dict[@"source"];
        lwAttentionTagSource *sourceModel = [[lwAttentionTagSource alloc] init];
        if (source != nil && ![source isEqual:[NSNull null]] && [[source class] isSubclassOfClass:[NSDictionary class]]) {
            sourceModel = [[lwAttentionTagSource alloc] initWithDict:source];
        }
        self.source = sourceModel;
        
        id addition = dict[@"addition"];
        lwAttentionTagAddition *additionModel = [[lwAttentionTagAddition alloc] init];
        if (addition != nil && ![addition isEqual:[NSNull null]] && [[addition class] isSubclassOfClass:[NSDictionary class]]) {
            additionModel = [[lwAttentionTagAddition alloc] initWithDict:addition];
        }
        self.addition = additionModel;
        
    }
    return self;
}

+ (NSMutableArray <lwAttentionTagModel *> *)feeds{
    NSMutableArray <lwAttentionTagModel *> *feeds = [NSMutableArray new];
    
    NSDictionary *source = [lwBaseModel source:@"lwAttentionTagsSource" Type:@""];
    NSArray *sourceArray = source[@"data"][@"feeds"];
    
    for (NSDictionary *info in sourceArray) {
        lwAttentionTagModel *tag = [[lwAttentionTagModel alloc] initWithDict:info];
        [feeds addObject:tag];
    }
    
    return feeds;
}

@end

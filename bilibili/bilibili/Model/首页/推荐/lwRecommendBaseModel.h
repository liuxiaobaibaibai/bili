//
//  lwRecommendBaseModel.h
//  bilibili
//
//  Created by lw on 2016/9/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"


/**
 顶部滚动
 */
@interface lwRecommendHeaderModel : lwBaseModel

@property (assign, nonatomic) int hid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *hashTag;
@property (copy, nonatomic) NSString *uri;

@end

/**
 banner
 */
@interface lwRecommendBannerModel : lwBaseModel

@property (strong, nonatomic) NSMutableArray <lwRecommendHeaderModel *> *top;
@property (strong, nonatomic) NSMutableArray <lwRecommendHeaderModel *> *bottom;

@end

/**
 body
 */
@interface lwRecommendBodyModel : lwBaseModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *uri;
@property (copy, nonatomic) NSString *param;
@property (copy, nonatomic) NSString *gotoTag;
@property (copy, nonatomic) NSString *area;
@property (assign, nonatomic) int area_id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *face;
@property (assign, nonatomic) int online;
@property (assign, nonatomic) int play;
@property (assign, nonatomic) int danmaku;

@property (copy, nonatomic) NSString *index;

@end

/**
 推荐
 */
@interface lwRecommendBaseModel : lwBaseModel

@property (copy, nonatomic) NSString *param;
/*
 *  live        ->直播
 *  region      ->范围？
 *  bangumi     ->番剧
 *  recommend   ->推荐
 *  activity    ->活动
 */
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *style;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray <lwRecommendBodyModel *> *body;
@property (strong, nonatomic) NSMutableArray <lwRecommendBannerModel *> *banner;
// 直播的才有
@property (assign, nonatomic) int live_count;

+ (NSMutableArray <lwRecommendBaseModel *> *)recommendSource;

@end

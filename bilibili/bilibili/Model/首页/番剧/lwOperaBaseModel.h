//
//  lwOperaBaseModel.h
//  bilibili
//
//  Created by lw on 2016/9/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"


/**
 body部分
 */
@interface lwADBodyModel : lwBaseModel

@end

/**
 广告头部
 */
@interface lwADHeadModel : lwBaseModel

@property (assign, nonatomic) int hid;
@property (copy, nonatomic) NSString *img;
@property (assign, nonatomic) BOOL is_ad;
@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *title;

@end

/**
 四月新番列表
 */
@interface lwPreviousListModel : lwBaseModel

@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *favourites;
@property (assign, nonatomic) BOOL is_finish;
@property (assign, nonatomic) int last_time;
@property (copy, nonatomic) NSString *newwest_ep_index;
@property (assign, nonatomic) int pub_time;
@property (assign, nonatomic) int season_id;
@property (assign, nonatomic) int season_status;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) int watching_count;

@end

/*************************************************************/
//                         分割线
/*************************************************************/

/**
 广告Model
 */
@interface lwOperadADModel : lwBaseModel

@property (strong, nonatomic) NSMutableArray <lwADBodyModel *> *body;
@property (strong, nonatomic) NSMutableArray <lwADHeadModel *> *head;

@end

/**
 四月新番
 */
@interface lwOperaPreviousModel : lwBaseModel

@property (strong, nonatomic) NSMutableArray <lwPreviousListModel *> *list;

@property (assign, nonatomic) int season;

@property (assign, nonatomic) int year;

@end

/**
 番剧推荐
 */
@interface lwOperaRecommendModel : lwBaseModel

@property (copy, nonatomic) NSString *cover;
@property (assign, nonatomic) int coursor;
@property (copy, nonatomic) NSString *desc;
@property (assign, nonatomic) int oid;
@property (assign, nonatomic) BOOL is_new;
@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *title;

@end

/**
 baseModel
 */
@interface lwOperaBaseModel : lwBaseModel

// 头部广告
@property (strong, nonatomic) lwOperadADModel *ADModel;
// 四月新番
@property (strong, nonatomic) lwOperaPreviousModel *previous;
// 新番连载
@property (strong, nonatomic) NSMutableArray <lwPreviousListModel *> *serializing;
// 番剧推荐
@property (strong, nonatomic) NSMutableArray <lwOperaRecommendModel *> *recommend;

+ (lwOperaBaseModel *)operaSource;

@end

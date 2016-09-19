//
//  lwLiveVideoModel.h
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  直播页面bannermodel
 */
@interface lwLiveVideoBannerModel : lwBaseModel

/**标题**/
@property (copy, nonatomic) NSString *title;

/**图片**/
@property (copy, nonatomic) NSString *img;

/**备注**/
@property (copy, nonatomic) NSString *remark;

/**链接**/
@property (copy, nonatomic) NSString *link;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/*********************************************************************/

/**
 *入口图片
 */
@interface lwLiveVideoEnterIconModel : lwBaseModel

/**图片来源**/
@property (copy, nonatomic) NSString *src;
/**高度**/
@property (copy, nonatomic) NSString *height;
/**宽度**/
@property (copy, nonatomic) NSString *width;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/**
 *  入口
 */
@interface lwLiveVideoEnterModel : lwBaseModel

/**入口ID**/
@property (assign, nonatomic) int eid;

/**名称**/
@property (copy, nonatomic) NSString *name;

/**icon**/
@property (strong, nonatomic) lwLiveVideoEnterIconModel *iconModel;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSMutableArray <lwLiveVideoEnterModel *> *)allCategory;

@end

/*********************************************************************/

/**
 *  分区
 */
@interface lwLiveVideoPartitionModel : lwBaseModel

/**区域ID**/
@property (assign, nonatomic) int pid;
/**区域名称*/
@property (copy, nonatomic) NSString *name;
/**区域**/
@property (copy, nonatomic) NSString *area;
/**icon**/
@property (strong, nonatomic) lwLiveVideoEnterIconModel *iconModel;
/**数量**/
@property (assign, nonatomic) int pCount;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/**
 *  归属
 */
@interface lwLiveOwnerModel : lwBaseModel
/**封面**/
@property (copy, nonatomic) NSString *face;
/**id**/
@property (assign, nonatomic) int mid;
/**房间名称**/
@property (copy, nonatomic) NSString *name;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/**
 *  直播间
 */
@interface lwLiveModel : lwBaseModel
/**归属者**/
@property (strong, nonatomic) lwLiveOwnerModel *owner;
/**封面**/
@property (strong, nonatomic) lwLiveVideoEnterIconModel *cover;
/**房间标题**/
@property (copy, nonatomic) NSString *title;
/**房间ID**/
@property (assign, nonatomic) int room_id;
/**版本？**/
@property (assign, nonatomic) int check_version;
/**在线人数？**/
@property (assign, nonatomic) int online;
/**归属区域**/
@property (copy, nonatomic) NSString *area;
/**归属区域ID**/
@property (assign, nonatomic) int areaID;
/**播放链接**/
@property (copy, nonatomic) NSString *playUrl;
/**接收质量**/
@property (copy, nonatomic) NSString *accept_quality;
/**播音类型**/
@property (assign, nonatomic) int boardcast_type;
/**是否是TV**/
@property (assign, nonatomic) BOOL is_tv;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/**
 *  分区数组
 */
@interface lwLiveVideoPartitionsModel : lwBaseModel

/**分区model**/
@property (strong, nonatomic) lwLiveVideoPartitionModel *partitionModel;
/**直播数据**/
@property (strong, nonatomic) NSMutableArray <lwLiveModel *> *lives;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/*********************************************************************/

/**
 *  推荐
 */
@interface lwRecommendDataModel : lwBaseModel

@property (strong, nonatomic) NSMutableArray <lwLiveModel *> *lives;

@property (strong, nonatomic) lwLiveVideoPartitionModel *partition;

@property (strong, nonatomic) NSMutableArray <lwLiveModel *> *bannerData;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

/*********************************************************************/

/**
 *  直播model
 */
@interface lwLiveVideoModel : lwBaseModel

/**banner图**/
@property (strong, nonatomic) NSMutableArray <lwLiveVideoBannerModel *>     *banners;
/**入口图**/
@property (strong, nonatomic) NSMutableArray <lwLiveVideoEnterModel *>      *entranceIcons;
/**分区**/
@property (strong, nonatomic) NSMutableArray <lwLiveVideoPartitionsModel *>  *partitions;
/**推荐**/
@property (strong, nonatomic) lwRecommendDataModel *recommendData;

+ (lwLiveVideoModel *)liveVideoSource;

/**
 *
 *  初始化
 *
 *  @author lw 2516-08-30
 *  @param  dict    原始数据
 *  @return 当前类实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

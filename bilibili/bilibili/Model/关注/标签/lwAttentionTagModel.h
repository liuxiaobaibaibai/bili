//
//  lwAttentionTagModel.h
//  bilibili
//
//  Created by lw on 16/9/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"

@interface lwAttentionTagCount : lwBaseModel

@property (assign, nonatomic) int view;

@property (assign, nonatomic) int use;

@property (assign, nonatomic) int atten;

@end

@interface lwAttentionTag : lwBaseModel

@property (assign, nonatomic) int tag_id;

@property (copy, nonatomic) NSString *tag_name;

@property (copy, nonatomic) NSString *cover;

@property (copy, nonatomic) NSString *content;

@property (assign, nonatomic) int type;

@property (assign, nonatomic) int state;

@property (assign, nonatomic) int is_atten;

@property (strong, nonatomic) lwAttentionTagCount *tagCount;

@property (assign, nonatomic) int ctime;

@property (assign, nonatomic) BOOL isSelect;

+ (NSMutableArray <lwAttentionTag *> *)tags;

@end

@interface lwAttentionTagAddition : lwBaseModel

@property (assign, nonatomic) int aid;

@property (assign, nonatomic) int typeId;

@property (copy, nonatomic) NSString *typeName;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *subtitle;

@property (assign, nonatomic) int play;

@property (assign, nonatomic) int review;

@property (assign, nonatomic) int video_review;

@property (assign, nonatomic) int favorites;

@property (assign, nonatomic) long int mid;

@property (copy, nonatomic) NSString *author;

@property (copy, nonatomic) NSString *link;

@property (copy, nonatomic) NSString *keywords;

@property (copy, nonatomic) NSString *aDescription;

@property (copy, nonatomic) NSString *create;

@property (copy, nonatomic) NSString *pic;

@property (assign, nonatomic) int credit;

@property (assign, nonatomic) int conis;

@property (assign, nonatomic) int money;

@property (copy, nonatomic) NSString *duration;

@property (assign, nonatomic) int status;

@property (assign, nonatomic) UIView *view;

@property (copy, nonatomic) NSString *view_at;

@property (copy, nonatomic) NSString *fav_create;

@property (copy, nonatomic) NSString *fav_create_at;

@property (copy, nonatomic) NSString *flag;

@end

@interface lwAttentionTagSource : lwBaseModel

@property (assign, nonatomic) int tag_id;

@property (copy,nonatomic) NSString *name;

@property (copy, nonatomic) NSString *cover;

@property (assign, nonatomic) BOOL showTag;

@end


@interface lwAttentionTagModel : lwBaseModel

@property (assign, nonatomic) int aid;

@property (assign, nonatomic) int src_id;

@property (assign, nonatomic) int add_id;

@property (assign, nonatomic) int type;

@property (assign, nonatomic) int mcid;

@property (assign, nonatomic) int ctime;

@property (strong, nonatomic) lwAttentionTagSource *source;

@property (strong, nonatomic) lwAttentionTagAddition *addition;

+ (NSMutableArray <lwAttentionTagModel *> *)feeds;

@end

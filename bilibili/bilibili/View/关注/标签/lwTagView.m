//
//  lwTagView.m
//  bilibili
//
//  Created by lw on 16/9/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwTagView.h"

#import "lwAttentionTagModel.h"

#define padding 10
#define btnWidth 30

#define viewHeight 50
#define fontSize 14.0

@interface lwTagView ()

<
UIScrollViewDelegate
>

@property (strong, nonatomic) UIButton *openBtn;

@property (strong, nonatomic) UIScrollView *tagView;

@property (strong, nonatomic) NSMutableArray <UIButton *> *tagButtons;

@end

@implementation lwTagView

#pragma mark - init

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, viewHeight);
        [self loadView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, viewHeight);
        [self loadView];
    }
    return self;
}

#pragma mark - User Operation
- (void)tagButtonClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(tagViewButtonClick:)]) {
        [_delegate tagViewButtonClick:btn];
    }
    for (UIButton *aBtn in self.tagButtons) {
        if ([aBtn isEqual:btn]) {
            [aBtn.layer setBorderColor:[UIColor biliPinkColor].CGColor];
            [aBtn setTitleColor:[UIColor biliPinkColor] forState:UIControlStateNormal];
        }else{
            [aBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [aBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (void)openButtonClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(openButtonClick:)]) {
        [_delegate openButtonClick:btn];
    }
}

#pragma mark - loadView
- (void)loadView{
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.backgroundColor = RGB(242, 242, 242);
    
    [self addSubview:self.openBtn];
    [self addSubview:self.tagView];
}

#pragma mark - setter

- (void)setTags:(NSArray <lwAttentionTag *> *)tags{
    _tags = tags;
    
    __block CGFloat contentWidth = 0;
    
    __block UIButton *lastBtn = nil;
    
    WS(ws);
    
    [tags enumerateObjectsUsingBlock:^(lwAttentionTag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *content = [NSString stringWithFormat:@"  %@  ",obj.tag_name];
        contentWidth += [content computedSize:CGSizeMake(MAXFLOAT, btnWidth) Font:[UIFont systemFontOfSize:fontSize]].width + 11;// 加1是因为边框的宽度
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:content forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [btn.layer setBorderWidth:1.0];
        [btn.layer setCornerRadius:15.0];
        
        if (obj.isSelect) {
            [btn setSelected:YES];
            [btn.layer setBorderColor:[UIColor biliPinkColor].CGColor];
            [btn setTitleColor:[UIColor biliPinkColor] forState:UIControlStateNormal];
        }else{
            [btn setSelected:NO];
            [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn setTag:idx];
        [btn addTarget:ws action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [ws.tagView addSubview:btn];
        [self.tagButtons addObject:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ws.tagView);
            make.height.mas_equalTo(btnWidth);
            
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(10);
            }else{
                make.left.mas_equalTo(10);
            }
        }];
        
        lastBtn = btn;
        
    }];
    
    [self.tagView setContentSize:CGSizeMake(contentWidth, btnWidth)];
    
}

#pragma mark - getter

- (NSMutableArray <UIButton *> *)tagButtons{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray new];
    }
    return _tagButtons;
}

- (UIButton *)openBtn{
    if (_openBtn == nil) {
        _openBtn = [[UIButton alloc] initWithFrame:CGRectMake((lW - padding / 2 - btnWidth), 10, btnWidth, btnWidth)];
        [_openBtn setImage:[UIImage imageNamed:@"home_pull"] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(openButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

- (UIScrollView *)tagView{
    if (_tagView == nil) {
        _tagView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (lW - padding - btnWidth), viewHeight)];
        _tagView.bounces = NO;
        _tagView.showsHorizontalScrollIndicator = NO;
        [_tagView setDelegate:self];
    }
    return _tagView;
}

@end

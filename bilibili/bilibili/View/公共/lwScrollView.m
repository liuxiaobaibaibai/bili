//
//  lwScrollView.m
//  lwScrollView
//
//  Created by lw on 16/8/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwScrollView.h"

#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENX [[UIScreen mainScreen] bounds].origin.x
#define SCREENY [[UIScreen mainScreen] bounds].origin.y

// 2.获得RGB颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)


@interface lwScrollView()

@property (strong, nonatomic) UITapGestureRecognizer *imgTap;

@property (strong, nonatomic) UIScrollView *myScrollView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSTimer *time;

@property (strong, nonatomic) UIImageView *leftImageView;

@property (strong, nonatomic) UIImageView *middleImageView;

@property (strong, nonatomic) UIImageView *rightImageView;


@end

@implementation lwScrollView

#pragma mark - init

- (id)init{
    self = [super init];
    if (self) {
        _index = 0;
        _timer = 2;
        _autoScroll = YES;
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 0;
        _timer = 2;
        _autoScroll = YES;
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame DataSource:(NSArray *)sources Delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 0;
        _timer = 2;
        _autoScroll = YES;
        [self setupView];
        self.flashs = sources;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - lifeCycle

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.height == 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
        [_myScrollView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_leftImageView setFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
        [_middleImageView setFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, self.frame.size.height)];
        [_rightImageView setFrame:CGRectMake(SCREENWIDTH * 2, 0, SCREENWIDTH, self.frame.size.height)];
        [_pageControl setFrame:CGRectMake(0, self.frame.size.height - 30, SCREENWIDTH, 30)];
    }
}

- (void)dealloc{
    self.myScrollView.delegate = nil;
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self stopAutoScroll];
    
}

#pragma mark - private method
- (void)stopAutoScroll{
    [self.time invalidate];
    self.time = nil;
}

- (void)startAutoScroll{
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:self.time forMode:NSDefaultRunLoopMode];
}

// 翻页
- (void)operationScrollView:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / SCREENWIDTH;
    switch (page) {
        case 0:
            if (_index == 0) {
                _index = self.flashs.count - 1;
            }else{
                _index--;
            }
            break;
        case 2:
            if (_index == self.flashs.count - 1) {
                _index = 0;
            }else{
                _index++;
            }
            break;
        default:
            break;
    }
//    NSLog(@"OPERATION");
    [self setImageView];
}

// 翻页的时候控制
- (void)setImageView{
    
    [self.pageControl setCurrentPage:_index];
    
    NSString *leftPath = self.flashs[[self leftIndex]];
    NSString *middlePath = self.flashs[[self middleIndex]];
    NSString *rightPath = self.flashs[[self rightIndex]];
    
    if (_sourceIsLocal) {
        [self.leftImageView setImage:[UIImage imageNamed:leftPath]];
        [self.middleImageView setImage:[UIImage imageNamed:middlePath]];
        [self.rightImageView setImage:[UIImage imageNamed:rightPath]];
    }else{
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftPath]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middlePath]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightPath]];
    }
}

#pragma mark - viewAction
- (void)flashOperation:(id)sender{
    if ([_delegate respondsToSelector:@selector(flashClick:Index:)]) {
        [_delegate flashClick:sender Index:_index];
    }
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_autoScroll) {
        [self stopAutoScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_autoScroll) {
        [self startAutoScroll];
    }
}

// 自动滚动的时候用到
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self operationScrollView:scrollView];
    [self.myScrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
}
// 手动滚动的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self operationScrollView:scrollView];
    [self.myScrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
}
#pragma mark - setupView
// 添加到视图上
- (void)setupView{
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self addSubview:self.myScrollView];
    [self addSubview:self.pageControl];
    
    [self.myScrollView addSubview:self.leftImageView];
    [self.myScrollView addSubview:self.middleImageView];
    [self.myScrollView addSubview:self.rightImageView];
}

- (void)scrollPageNextIndex{
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.contentOffset.x + SCREENWIDTH, 0) animated:YES];
}

#pragma mark - setter

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    if (!autoScroll) {
        [self stopAutoScroll];
    }else{
        [self startAutoScroll];
    }
}

- (void)setFlashs:(NSArray *)flashs{
    
    if (flashs.count < 1) {
        return;
    }
    
    NSArray *item = [NSArray arrayWithArray:flashs];
    if (flashs.count > 9) {
        item = [item subarrayWithRange:NSMakeRange(0, 9)];
    }
    _flashs = [NSMutableArray arrayWithArray:item];
    [self.pageControl setNumberOfPages:_flashs.count];
    [self setImageView];
    // 数据加载完成之后，判断如果开启了自动滚动就开始自动滚动
    if (flashs.count >1) {
        if (_autoScroll) {
            [self startAutoScroll];
        }
    }else{
        _autoScroll = NO;
        self.myScrollView.scrollEnabled = NO;
        [self.pageControl setHidden:YES];
    }
}

- (void)setTimer:(NSTimeInterval)timer{
    if (timer < 1.0) {
        timer = 1.0;
    }
    _timer = timer;
}

#pragma mark - getter

- (NSInteger)rightIndex{
    NSInteger right = 0;
    right = _index == self.flashs.count - 1 ? 0 : _index + 1;
    return labs(right);
}

- (NSInteger)middleIndex{
    return _index;
}

- (NSInteger)leftIndex{
    NSInteger left = 0;
    left = _index == 0 ? self.flashs.count - 1 : _index - 1;
    return labs(left);
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
        [_pageControl setTintColor:[UIColor redColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_pageControl setCurrentPage:0];
    }
    return _pageControl;
}

- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
        _myScrollView.delegate = self;
        _myScrollView.pagingEnabled = YES;
        _myScrollView.userInteractionEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [_myScrollView setContentSize:CGSizeMake(SCREENWIDTH * 3, self.frame.size.height)];
        [_myScrollView setContentOffset:CGPointMake(SCREENWIDTH, 0)];
        // 开启之后连续滑动到边界会有不流畅的感觉
        _myScrollView.bounces = NO;
    }
    return _myScrollView;
}

- (NSTimer *)time{
    if (_time == nil) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_timer];
        _time = [[NSTimer alloc] initWithFireDate:date interval:_timer target:self selector:@selector(scrollPageNextIndex) userInfo:nil repeats:YES];
    }
    return _time;
}

- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
        [_leftImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flashOperation:)]];
        _leftImageView.userInteractionEnabled = YES;
    }
    return _leftImageView;
}
- (UIImageView *)middleImageView{
    if (_middleImageView == nil) {
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, self.frame.size.height)];
        _middleImageView.userInteractionEnabled = YES;
        [_middleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flashOperation:)]];
    }
    return _middleImageView;
}
- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 2, 0, SCREENWIDTH, self.frame.size.height)];
        _rightImageView.userInteractionEnabled = YES;
        [_rightImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flashOperation:)]];
    }
    return _rightImageView;
}

- (UITapGestureRecognizer *)imgTap{
    if (_imgTap == nil) {
        _imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flashOperation:)];
    }
    return _imgTap;
}

@end

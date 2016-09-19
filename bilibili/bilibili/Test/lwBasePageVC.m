//
//  lwBasePageVC.m
//  bilibili
//
//  Created by lw on 16/8/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBasePageVC.h"

#import "UISegmentedControl+lwSegmentedControl.h"

#define leftPadding 100

@interface lwBasePageVC ()

<
    UIScrollViewDelegate
>

/**
 *  滚动父级视图
 */
@property (strong, nonatomic) UIScrollView *pageView;

/**
 *  子控制器的视图数组
 */
@property (strong, nonatomic) NSMutableArray <UIViewController *> *pages;

/**
 *  标题视图（分段按钮）
 */
@property (strong, nonatomic) UIView *titleView;

/**
 *  分段按钮
 */
@property (strong, nonatomic) UISegmentedControl *segControl;

/**
 *  滚动线
 */
@property (strong, nonatomic) UIView *line;

/**
 *  子视图数组
 */
@property (assign, nonatomic) int pageCount;


@end

@implementation lwBasePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - user Action
- (void)segmentedControledValueChanged:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    
    [self.pageView scrollRectToVisible:[self contentFrame:index] animated:YES];
    
    CGFloat left = ( self.pageView.contentOffset.x / _pageCount / lW) * [self titleWidth];

    [_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.bounces = NO;
    
    CGFloat left = (scrollView.contentOffset.x / _pageCount / lW) * [self titleWidth];
    
    [_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat index = scrollView.contentOffset.x / lW;
    [self.segControl setSelectedSegmentIndex:index];
}

#pragma mark - loadView
- (void)setupView{
    
    [self.navigationItem setTitleView:self.titleView];
    
    [self.view addSubview:self.pageView];
    
    WS(ws);
    
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [self.pageView layoutIfNeeded];
    
    for (UIViewController *aView in self.pages) {
        @autoreleasepool {
            NSInteger index = [self.pages indexOfObject:aView];
            [aView.view setFrame:[self contentFrame:index]];
    
            [self.pageView addSubview:aView.view];
            [self addChildViewController:aView];
        }
    }
}

#pragma mark - setter

- (CGRect)contentFrame:(NSInteger)index{
    return _tabbarHidden ? CGRectMake(index * lW, 0, lW, lH) : CGRectMake(index * lW, 0, lW, lH - lNavH - lTabbarH);
}

- (CGSize)contentSize:(NSInteger)index{
    return _tabbarHidden ? CGSizeMake((lW * index), lH - lNavH) : CGSizeMake((lW * index), lH - lNavH - lTabbarH);
}

- (CGFloat)titleWidth{
    return (lW - leftPadding * 2);
}

- (void)topLabels:(NSArray<NSString *> *)labels Controllers:(NSArray<NSString *> *)controllers{
    _labels = labels;
    _controllers = controllers;
    _pageCount = (int)labels.count;
}

#pragma mark - getter

- (UISegmentedControl *)segControl{
    if (_segControl == nil) {
        _segControl = [UISegmentedControl createSegmentedControl:self.labels];
        [_segControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSForegroundColorAttributeName:[UIColor biliPinkColor]} forState:UIControlStateNormal];
        [_segControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor biliPinkColor]} forState:UIControlStateSelected];
        [_segControl setTintColor:[UIColor clearColor]];
        _segControl.backgroundColor = [UIColor clearColor];
        [_segControl addTarget:self action:@selector(segmentedControledValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segControl;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor biliPinkColor];
    }
    return _line;
}

- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, 20, [self titleWidth], 32)];
        [_titleView addSubview:self.segControl];
        [_titleView addSubview:self.line];
        
        WS(ws);
        
        [_segControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo([self titleWidth] / ws.pageCount);
            make.top.mas_equalTo(ws.segControl.mas_bottom);
            make.height.mas_equalTo(2);
        }];
        
    }
    return _titleView;
}

- (UIScrollView *)pageView{
    if (_pageView == nil) {
        _pageView = [[UIScrollView alloc] init];
        _pageView.delegate = self;
        _pageView.pagingEnabled = YES;
        _pageView.contentSize = [self contentSize:_pageCount];
        _pageView.showsVerticalScrollIndicator = NO;
        _pageView.showsHorizontalScrollIndicator = NO;
    }
    return _pageView;
}

- (NSMutableArray <UIViewController *> *)pages{
    if (_pages == nil) {
        _pages = [NSMutableArray new];
        for (NSString *controllerName in self.controllers) {
            if (![controllerName isNull]) {
                Class class = NSClassFromString(controllerName);
                if (class && [class isSubclassOfClass:[UIViewController class]]) {
                    UIViewController *page = (UIViewController *)[[class alloc] init];
                    [_pages addObject:page];
                }
            }
        }
        
    }
    return _pages;
}

@end

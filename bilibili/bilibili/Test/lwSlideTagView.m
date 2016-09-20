//
//  lwLabelView.m
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSlideTagView.h"

#define padding 5
#define marign 8
#define labelHeight 21

#define btnSize CGSizeMake(30,30)
#define MAXHEIGHT 65

@interface lwSlideTagView ()

@property (copy, nonatomic) NSArray *items;

@property (strong, nonatomic) UIView *line;

@end

@implementation lwSlideTagView

#pragma mark - init
- (id)initWithItems:(NSArray <NSString *> *)items{
    self = [super init];
    if (self) {
        [self loadView];
        self.items = items;
        [self createdView:items];
    }
    return self;
}

#pragma mark - lifeCycle
- (void)dealloc{
}

#pragma mark - user action
- (void)tagButtonClick:(UIButton *)btn{
    // 以下普通使用肯定是没有问题了
    // 判断是否在同一行
    if (btn.y > _line.y) {
        // 往下面移动
        [UIView animateWithDuration:0.15 animations:^{
            // 选移动X轴
            _line.frame = CGRectMake(self.width - _line.width , _line.y, btn.width, 2);
        }completion:^(BOOL finished) {
            if (finished) {
                // 完成之后 改变X轴 Y轴更换成当前标签所在行 （去掉动画）
                _line.frame = CGRectMake(0, btn.y + btn.height, _line.width, 2);
                [UIView animateWithDuration:0.15 animations:^{
                    // 接着 更新X轴
                    _line.frame = CGRectMake(btn.x, btn.y + btn.height, btn.width, 2);
                }];
            }
        }];
    }else if(btn.y + btn.height == _line.y){
        // 同行移动
        [UIView animateWithDuration:0.3 animations:^{
            // 直接改变X轴即可
            _line.frame = CGRectMake(btn.x, btn.y + btn.height, btn.width, 2);
        }];
    }else{
        // 往上面移动
        [UIView animateWithDuration:0.15 animations:^{
            // 同理还是先移动X轴
            _line.frame = CGRectMake(10 , _line.y, _line.width, 2);
        }completion:^(BOOL finished) {
            if (finished) {
                // 完成之后 改变X轴 Y轴更换成当前标签所在行 （去掉动画）
                _line.frame = CGRectMake(self.width - _line.width, btn.y + btn.height, _line.width, 2);
                [UIView animateWithDuration:0.15 animations:^{
                    // 最后更新X轴
                    _line.frame = CGRectMake(btn.x, btn.y + btn.height, btn.width, 2);
                }];
            }
        }];
    }
    
    if ([_delegate respondsToSelector:@selector(slideTagViewButtonClick:)]) {
        [_delegate slideTagViewButtonClick:btn.tag];
    }
    
}

#pragma mark - loadView
- (void)loadView{
    self.backgroundColor = [UIColor biliPinkColor];
    [self addSubview:self.line];
}

- (void)createdView:(NSArray *)itemArray{
    UIButton *lastButton = nil;
    
    CGFloat sumWidth = 0.0;
    int itemCount = 0;
    int row = 1;
    int lastRow = 1;
    
    for (int i = 0; i<itemArray.count; i++) {
        UIButton *button = [self newButton];
        [button setTitle:itemArray[i] forState:UIControlStateNormal];
        [button setTag:i];
        [self addSubview:button];
        
        sumWidth += [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width +10;
        
        CGFloat nowWidth = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width +10;
        
        if (i == 0) {
            [_line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(button);
                make.top.mas_equalTo(button.mas_bottom);
                make.height.mas_equalTo(2);
            }];
        }
        
        if (lW - ((sumWidth - nowWidth)+(marign*(itemCount+1))) <= nowWidth) {
            // 不在同一行
            row++;
            itemCount = 1;
            sumWidth = nowWidth;
        }else{
            // 在同一行
            itemCount++;
        }
        
        if (!lastButton) {
            // 第一个按钮
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(5);
                make.left.mas_equalTo(marign);
                make.height.mas_equalTo(21);
                CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                make.width.mas_equalTo(width);
            }];
        }else{
            // 后续按钮
            if (lastRow == row) {
                // 还在同一行
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastButton.mas_right).offset(marign);
                    make.top.equalTo(lastButton);
                    make.height.mas_equalTo(21);
                    CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                    make.width.mas_equalTo(width);
                }];
            }else{
                // 换行后的
                lastRow ++ ;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marign);
                    make.top.mas_equalTo(marign * (row - 1) + labelHeight * (row - 1));
                    make.height.mas_equalTo(21);
                    CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                    make.width.mas_equalTo(width);
                }];
            }
        }
        lastButton = button;
    }
    
    _tagViewHeight = row * labelHeight + row * marign;
    
}

- (UIButton *)newButton{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - getter
- (UIView *)line{
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}

@end

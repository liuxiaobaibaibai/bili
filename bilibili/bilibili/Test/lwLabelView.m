//
//  lwLabelView.m
//  bilibili
//
//  Created by lw on 16/9/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwLabelView.h"

#define padding 5
#define marign 8
#define labelHeight 21

#define btnSize CGSizeMake(30,30)
#define MAXHEIGHT 65

@interface lwLabelView ()

@property (copy, nonatomic) NSArray *items;

@property (strong, nonatomic) UIView *line;

@end

@implementation lwLabelView

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
    
    [UIView animateWithDuration:0.3 animations:^{
        _line.frame = CGRectMake(btn.x, btn.height + btn.y, btn.width, 2);
    }];
}

#pragma mark - loadView
- (void)loadView{
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

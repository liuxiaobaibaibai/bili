//
//  lwSrarchHeaderView.h
//  bilibili
//
//  Created by lw on 16/9/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lwSearchHeaderViewDelegate <NSObject>

- (void)headerButtonClick:(UIButton *)btn;

@end


@interface lwSrarchHeaderView : UIView

@property (strong, nonatomic) UIButton *searchBtn;

@property (strong, nonatomic) UIButton *qrBtn;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *moreBtn;

@property (assign, nonatomic) id <lwSearchHeaderViewDelegate>delegate;

@end

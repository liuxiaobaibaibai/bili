//
//  UIButton+lwButton.m
//  JuYingBao
//
//  Created by lw on 16/5/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIButton+lwButton.h"

#import "UIImage+lwImage.h"

@implementation UIButton (lwButton)

+ (UIButton *)createButton:(NSString *)text TitleColor:(UIColor *)titleColor Target:(id)target action:(SEL)selector{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setNumberOfLines:0];
    return btn;
}

+ (UIButton *)createLabelButton:(NSString *)title Tag:(NSInteger)tag Target:(id)target Action:(SEL)selector{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[UIColor JDColor] forState:UIControlStateNormal];
    [button setTag:tag];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
//    button.layer.masksToBounds = YES;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setImageViewWithSource:(NSString *)source Local:(BOOL)local{
    [self setImageViewWithSource:source Local:local Zoom:YES];
}

- (void)setImageViewWithSource:(NSString *)source Local:(BOOL)local Zoom:(BOOL)zoom{
    if (!source) {
        return;
    }
    if (local) {
        [self setImageViewWithName:source];
    }else{
        [self setImageViewWithSource:source Zoom:zoom];
    }
}

- (void)setImageViewWithName:(NSString *)name{
    if (!name) {
        return;
    }
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    
}

- (void)setImageViewWithSource:(NSString *)source Size:(CGSize)size{
    if (!source) {
        return;
    }
    
    if (![lwCommon validateUrlpath:source]) {
        return;
    }
    
    [self layoutIfNeeded];

    NSURL *url = [NSURL URLWithString:source];
    
    __block NSData *imgData = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        imgData = [NSData dataWithContentsOfURL:url];
        
        if (imgData) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *img = [UIImage imageWithData:imgData];
                
                img = [img imageByScalingToSize:size];
                
                [self setImage:img forState:UIControlStateNormal];
                
            });
            
        }
        
    });
}

- (void)setImageViewWithSource:(NSString *)source Zoom:(BOOL)zoom{
    if (!source) {
        return;
    }
    
    if (![lwCommon validateUrlpath:source]) {
        return;
    }
    
    [self layoutIfNeeded];
    
    CGSize size = self.frame.size;
    
    NSURL *url = [NSURL URLWithString:source];
    
    __block NSData *imgData = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        imgData = [NSData dataWithContentsOfURL:url];
        
        if (imgData) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *img = [UIImage imageWithData:imgData];
                
                if (zoom) {
                    img = [img imageByScalingToSize:CGSizeMake(size.width/2, size.height/2)];
                }
                
                [self setImage:img forState:UIControlStateNormal];
                
            });
            
        }
        
    });
}

- (void)setImageViewWithSource:(NSString *)source Scale:(CGFloat)scale{
    if (!source) {
        return;
    }
    
    if (![lwCommon validateUrlpath:source]) {
        return;
    }
    
    [self layoutIfNeeded];
    
    CGSize size = self.frame.size;
    
    NSURL *url = [NSURL URLWithString:source];
    
    __block NSData *imgData = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        imgData = [NSData dataWithContentsOfURL:url];
        
        if (imgData) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *img = [UIImage imageWithData:imgData];
                
                img = [img imageByScalingToSize:CGSizeMake(size.width * scale, size.height * scale)];
                
                [self setImage:img forState:UIControlStateNormal];
                
                [self setNeedsDisplay];
            });
            
        }
        
    });
}

- (void)ButtonImageTitleTopBottomEdgeInsets{
    
    [self layoutIfNeeded];

    CGSize size = self.frame.size;
    
    CGPoint buttonBoundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGFloat space =(size.height -CGRectGetHeight(self.imageView.bounds)-CGRectGetHeight(self.titleLabel.bounds))/3; //纵向间隔均分
    
    // 找出imageView最终的center
    CGPoint endImageViewCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetMidY(self.imageView.bounds) +space);
    // 找出titleLabel最终的center
    CGPoint endTitleLabelCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetHeight(self.bounds)-CGRectGetMidY(self.titleLabel.bounds) -space);
    
    // 取得imageView最初的center
    CGPoint startImageViewCenter = self.imageView.center;
    
    // 取得titleLabel最初的center
    CGPoint startTitleLabelCenter = self.titleLabel.center;
    
    // 设置imageEdgeInsets
    
    CGFloat imageEdgeInsetsTop = endImageViewCenter.y - startImageViewCenter.y;
    
    CGFloat imageEdgeInsetsLeft = endImageViewCenter.x - startImageViewCenter.x;
    
    CGFloat imageEdgeInsetsBottom = -imageEdgeInsetsTop;
    
    CGFloat imageEdgeInsetsRight = -imageEdgeInsetsLeft;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    
    CGFloat titleEdgeInsetsTop = endTitleLabelCenter.y - startTitleLabelCenter.y;
    
    CGFloat titleEdgeInsetsLeft = endTitleLabelCenter.x - startTitleLabelCenter.x;
    
    CGFloat titleEdgeInsetsBottom = -titleEdgeInsetsTop;
    
    CGFloat titleEdgeInsetsRight = -titleEdgeInsetsLeft;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
    
}


@end

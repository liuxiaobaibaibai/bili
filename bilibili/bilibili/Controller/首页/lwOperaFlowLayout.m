//
//  lwOperaFlowLayout.m
//  bilibili
//
//  Created by lw on 2016/9/26.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwOperaFlowLayout.h"

@implementation lwOperaFlowLayout

//返回contentsize的总大小
-(CGSize)collectionViewContentSize{
    CGFloat height = ceil([[self collectionView]numberOfItemsInSection:0]/5)* lW/2;
    return CGSizeMake(lW, height);
}

//自定义布局必须YES
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//返回每个cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path{
    return [self layoutAttributesForElementsInRect:CGRectMake(0, 0, lW, lH)][path.row];
}

//返回所有cell的布局属性
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [array count]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end

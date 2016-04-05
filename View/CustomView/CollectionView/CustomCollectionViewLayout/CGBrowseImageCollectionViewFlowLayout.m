//
//  CGBrowseImageCollectionViewFlowLayout.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowseImageCollectionViewFlowLayout.h"

#import "UIView+CGSetupFrame.h"

@implementation CGBrowseImageCollectionViewFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint targetPoint = CGPointZero;
    
    CGRect visibleRect  = (CGRect){self.collectionView.contentOffset, self.collectionView.size};
    CGPoint center      = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    //获取可视区域下的布局属性
    NSArray< UICollectionViewLayoutAttributes *> *layoutAttributes = [self layoutAttributesForElementsInRect:visibleRect];
    
    CGPoint firstOrigin = [layoutAttributes firstObject].frame.origin;
    CGPoint lastOrigin  = [layoutAttributes lastObject].frame.origin;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        //横向滑动时
        CGFloat horizontalVelocity  = velocity.x;
        if (horizontalVelocity < 0.5 && horizontalVelocity > - 0.5) {
            
            CGFloat firstSpace  = fabs([layoutAttributes firstObject].center.x - center.x);
            CGFloat lastSpace   = fabs([layoutAttributes lastObject].center.x - center.x);
            targetPoint         = firstSpace > lastSpace ? lastOrigin : firstOrigin;
        }else if (horizontalVelocity >= 0.5) {
            targetPoint = lastOrigin;
        }else {
            targetPoint = firstOrigin;
        }
    }else {
        NSAssert(nil, @"竖向滑动没有实现");
    }
    return targetPoint;
}

@end

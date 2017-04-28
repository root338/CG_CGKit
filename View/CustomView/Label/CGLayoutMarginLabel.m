//
//  CGLayoutMarginLabel.m
//  QuickAskCommunity
//
//  Created by DY on 2017/4/26.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGLayoutMarginLabel.h"

#import "UIView+CG_CGAreaCalculate.h"

@implementation CGLayoutMarginLabel

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    if (self.text.length) {
        
        size    = CG_CGMaxSizeWidthSize(size, self.marginEdgeInsets);
    }
    return size;
}

- (void)drawTextInRect:(CGRect)rect
{
    
    if (CGRectGetMinX(rect) < self.marginEdgeInsets.left) {
        rect.origin.x   = self.marginEdgeInsets.left;
    }
    if (CGRectGetMinY(rect) < self.marginEdgeInsets.top) {
        rect.origin.y   = self.marginEdgeInsets.top;
    }
    CGFloat textMaxWidth    = CGRectGetWidth(self.bounds) - self.marginEdgeInsets.right;
    if (CGRectGetMaxX(rect) > textMaxWidth) {
        rect.size.width     = textMaxWidth;
    }
    CGFloat textMaxHeight   = CGRectGetHeight(self.bounds) - self.marginEdgeInsets.bottom;
    if (CGRectGetMaxY(rect) > textMaxHeight) {
        rect.size.height    = textMaxHeight;
    }
    [super drawTextInRect:rect];
}

@end

//
//  UIScrollView+CGSetupValue.m
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import "UIScrollView+CGSetupValue.h"

@implementation UIScrollView (CGSetupValue)

@dynamic offsetX, offsetY;

#pragma mark - 偏移量
- (CGFloat)offsetX
{
    return self.contentOffset.x;
}

- (void)setOffsetX:(CGFloat)offsetX
{
    [self setContentOffsetX:offsetX animated:NO];
}

- (CGFloat)offsetY
{
    return self.contentOffset.y;
}

- (void)setOffsetY:(CGFloat)offsetY
{
    [self setContentOffsetY:offsetY animated:NO];
}

- (void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.x = offsetX;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = offsetY;
    [self setContentOffset:offset animated:animated];
}
@end

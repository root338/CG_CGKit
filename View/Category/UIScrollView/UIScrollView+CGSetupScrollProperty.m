//
//  UIScrollView+CGSetupValue.m
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import "UIScrollView+CGSetupScrollProperty.h"

#import "UIView+CGSetupFrame.h"

@implementation UIScrollView (CGSetupScrollProperty)

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

- (void)scrollingWithType:(CGSlideDirectionType)slideType
{
    [self scrollingWithType:slideType animated:NO];
}

- (void)scrollingWithType:(CGSlideDirectionType)slideType animated:(BOOL)animated
{
    CGPoint contentOffset = CGPointZero;
    if (slideType & CGSlideDirectionTypeTop) {
        contentOffset.y = 0;
    }
    
    if (slideType & CGSlideDirectionTypeLeft) {
        contentOffset.x = 0;
    }
    
    if (slideType & CGSlideDirectionTypeBottom) {
        contentOffset.y = MAX(self.contentSize.height - self.height, 0);
    }
    
    if (slideType & CGSlideDirectionTypeRight) {
        contentOffset.x = MAX(self.contentSize.width - self.width, 0);
    }
    
    if (!CGPointEqualToPoint(contentOffset, self.contentOffset)) {
        [self setContentOffset:contentOffset animated:animated];
    }
}

@end

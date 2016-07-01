//
//  UIScrollView+CGSetupValue.m
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import "UIScrollView+CGSetupScrollProperty.h"

#import "UIView+CGSetupFrame.h"
#import "UIScrollView+CGProperty.h"

#import "CGPrintLogHeader.h"
#import "NSError+CGCreateError.h"

#import <objc/runtime.h>

@implementation UIScrollView (CGSetupScrollProperty)

@dynamic offsetX, offsetY;

#pragma mark - 偏移量
- (CGFloat)offsetX
{
    return self.contentOffset.x;
}

- (void)setOffsetX:(CGFloat)offsetX
{
    [self setContentOffsetX:offsetX animated:!self.hideAnimatedScrolling];
}

- (CGFloat)offsetY
{
    return self.contentOffset.y;
}

- (void)setOffsetY:(CGFloat)offsetY
{
    [self setContentOffsetY:offsetY animated:!self.hideAnimatedScrolling];
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
    [self scrollingWithType:slideType animated:!self.hideAnimatedScrolling];
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

- (void)scrollingWithTargetView:(UIView *)targetView
{
    [self scrollingWithTargetView:targetView animated:!self.hideAnimatedScrolling];
}

- (void)scrollingWithTargetView:(UIView *)targetView animated:(BOOL)animated
{
    [self scrollingWithTargetView:targetView animated:animated failure:nil];
}

- (void)scrollingWithTargetView:(UIView *)targetView animated:(BOOL)animated failure:(void (^ _Nullable)(NSError * _Nonnull))failure
{
    NSError *error  = nil;
    if (![targetView isDescendantOfView:self]) {
        //当指定视图不在scrollView上
        if (failure) {
            error   = [NSError cg_createWithErrorMessage:@"目标视图不在ScrollView上"];
            failure(error);
        }
        CGDebugAssert(nil, @"目标视图不在ScrollView上");
        return;
    }
    
    //目标视图在scrollView的显示区域
    CGRect targetViewFrameToScrollView  = [targetView.superview convertRect:targetView.frame toView:self];
    CGRect scrollViewVisibleFrame       = self.scrollVisibleRect;
    
    CGPoint contentOffset               = self.contentOffset;
    
    CGFloat scrollViewHeight            = CGRectGetHeight(scrollViewVisibleFrame);
    CGFloat scrollViewWidth             = CGRectGetWidth(scrollViewVisibleFrame);
    
    CGFloat minVisibleOriginY           = CGRectGetMinY(scrollViewVisibleFrame);
    CGFloat maxVisibleOriginY           = CGRectGetMaxY(scrollViewVisibleFrame);
    CGFloat minVisibleOriginX           = CGRectGetMinX(scrollViewVisibleFrame);
    CGFloat maxVisibleOriginX           = CGRectGetMaxX(scrollViewVisibleFrame);
    
    CGFloat targetViewMinY              = CGRectGetMinY(targetViewFrameToScrollView);
    CGFloat targetViewMaxY              = CGRectGetMaxY(targetViewFrameToScrollView);
    CGFloat targetViewMinX              = CGRectGetMinX(targetViewFrameToScrollView);
    CGFloat targetViewMaxX              = CGRectGetMaxX(targetViewFrameToScrollView);
    
    //目标视图在scrollView可视区域对比
    if (targetViewMaxY < minVisibleOriginY || targetViewMinY < minVisibleOriginY) {
        //在上方或部分在上方
        contentOffset.y = targetViewMinY;
    }
    
    if (targetViewMinY > maxVisibleOriginY || targetViewMaxY > maxVisibleOriginY) {
        //在下方或部分在下方
        contentOffset.y = targetViewMaxY - scrollViewHeight;
    }
    
    if (targetViewMaxX < minVisibleOriginX || targetViewMinX < minVisibleOriginX) {
        //在左边或部分在左边
        contentOffset.x = targetViewMinX;
    }
    
    if (targetViewMinX > maxVisibleOriginX || targetViewMaxX > maxVisibleOriginX) {
        //在右边或部分在右边
        contentOffset.x = targetViewMaxX - scrollViewWidth;
    }
    
    if (!CGPointEqualToPoint(contentOffset, self.contentOffset)) {
        [self setContentOffset:contentOffset animated:animated];
    }
}

#pragma mark

- (void)setHideAnimatedScrolling:(BOOL)hideAnimated
{
    objc_setAssociatedObject(self, @selector(hideAnimatedScrolling), @(hideAnimated), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hideAnimatedScrolling
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end

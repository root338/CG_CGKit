//
//  CGCycleScrollView+CGScrollAnimation.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCycleScrollView+CGScrollAnimation.h"
#import "CGAngleRadianHeader.h"

#import "UIView+CGSetupFrame.h"

@interface UIView (CGCycleScrollViewAnimation)

- (void)cg_scrollOneAnimationWithScrollView:(UIScrollView *)scrollView;

@end

@implementation CGCycleScrollView (CGScrollAnimation)

- (void)cg_scrollWithScrollView:(UIScrollView *)scrollView animationStyle:(CGCycleViewScrollAnimationStyle)style
{
    if (style == CGCycleViewScrollAnimationStyleNone) {
        return;
    }
    NSArray *subviews = scrollView.subviews;
    [subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (style) {
            case CGCycleViewScrollAnimationStyleAnimation1:
            {
                [obj cg_scrollOneAnimationWithScrollView:scrollView];
            }
                break;
                
            default:
                break;
        }
    }];
}

@end

@implementation UIView (CGCycleScrollViewAnimation)

- (void)cg_scrollOneAnimationWithScrollView:(UIScrollView *)scrollView
{
    CALayer *layer  = self.layer;
    if (layer.allowsEdgeAntialiasing != YES) {
        layer.allowsEdgeAntialiasing    = YES;
    }
    
    CGRect scrollViewVisibleRect    = (CGRect){scrollView.contentOffset, scrollView.size};
    
    /** 最大旋转角度 */
    CGFloat maxAngle        = 5.0;
    CGFloat angle           = 0;
    CGFloat space           = CGRectGetMidX(scrollViewVisibleRect) - self.xCenter;
    
    if (space < -scrollView.width) {
        
        angle   = -maxAngle;
    }else if (space > scrollView.width) {
        
        angle   = maxAngle;
    }else {
        
        angle   = space * (maxAngle / scrollView.width);
        
    }
    
    CGFloat radian          = _CG_RadianForAngle(angle);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34           = -1.0 / 300;
    transform               = CATransform3DRotate(transform, radian, 0, 1, 0);
//    layer.anchorPoint       = CGPointMake(0, 0.5);
    layer.transform         = transform;
}

@end
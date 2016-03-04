//
//  CGCycleScrollView+CGScrollAnimation.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCycleScrollView+CGScrollAnimation.h"

@interface UIView (CGCycleScrollViewAnimation)

- (void)cg_scrollOneAnimationWithScrollView:(UIScrollView *)scrollView;

@end

@implementation CGCycleScrollView (CGScrollAnimation)

- (void)cg_scrollWithScrollView:(UIScrollView *)scrollView previousView:(UIView *)previousView currentView:(UIView *)currentView nextView:(UIView *)nextView animationStyle:(CGCycleViewScrollAnimationStyle)style
{
    switch (style) {
        case CGCycleViewScrollAnimationStyleAnimation1:
        {
            [previousView cg_scrollOneAnimationWithScrollView:scrollView];
            [currentView cg_scrollOneAnimationWithScrollView:scrollView];
            [nextView cg_scrollOneAnimationWithScrollView:scrollView];
        }
            break;
            
        default:
            break;
    }
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
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34           = -1.0 / 200;
    
    /** 最大旋转角度 */
    CGFloat maxAngle        = 3.0;
    CGFloat maxScaleX       = 1.0;
    CGFloat scaleX          = maxScaleX;
    CGFloat scaleY          = maxScaleX;
    CGFloat scaleZ          = maxScaleX;
    CGFloat angle           = 0;
    CGFloat space           = CGRectGetMidX(scrollViewVisibleRect) - self.centerX;
    
    if (space < -scrollView.width) {
        angle   = -maxAngle;
        
    }else if (space > scrollView.width) {
        angle   = maxAngle;
    }else {
        angle   = space * (maxAngle / scrollView.width);
//        scaleX  = space * (maxScaleX / scrollView.width);
//        scaleY  = space * (maxScaleX / scrollView.width);
        
    }
    
    CGFloat radian          = angle / 180.0 * M_PI;
    
    transform               = CATransform3DScale(transform, scaleX, scaleY, scaleZ);
    transform               = CATransform3DRotate(transform, radian, 0, 1, 0);
    layer.transform         = transform;
}

@end
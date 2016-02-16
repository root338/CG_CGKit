//
//  CGDefaultPopAnimation.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGDefaultPopAnimation.h"

@implementation CGDefaultPopAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

/** 动画的执行时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

/** 进行动画的设置 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //转场开始的视图控制器
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //转场到的视图控制器
    UIViewController *toViewController      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.transform   = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//
//}

@end

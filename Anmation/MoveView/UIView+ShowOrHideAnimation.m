//
//  UIView+Animation.m
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+ShowOrHideAnimation.h"

@implementation UIView (ShowOrHideAnimation)

- (void)areaSubviewStartCenterPoint:(CGPoint *)startCenterPoint endCenterPoint:(CGPoint *)endCenterPoint isShow:(BOOL)isShow animationType:(ShowHideAnimationType)animationType
{
    //获取当前视图父视图的坐标信息
    CGSize supersize = self.superview.bounds.size;
    CGSize subviewSize = self.bounds.size;
    CGPoint superInCenter = CGPointMake(supersize.width / 2, supersize.height / 2);
    
    //设置视图中心坐标在父视图底部
    CGPoint tPoint1;
    //设置视图中心坐标在父视图显示区域时的坐标位置
    CGPoint tPoint2;
    
    switch (animationType) {
        case ShowHideAnimationTypeFromBottom:
        {
            //向上滑入动画的坐标设置
            tPoint1 = CGPointMake(superInCenter.x, supersize.height + subviewSize.height / 2);
            tPoint2 = CGPointMake(tPoint1.x, supersize.height - subviewSize.height / 2);
        }
            break;
        case ShowHideAnimationTypeFromTop:
        {
            //向下滑入动画的坐标设置
            tPoint1 = CGPointMake(superInCenter.x, -subviewSize.height / 2);
            tPoint2 = CGPointMake(tPoint1.x, subviewSize.height / 2);
        }
            break;
        case ShowHideAnimationTypeFromLeft:
        {
            //向右滑入动画的坐标设置
            tPoint1 = CGPointMake(-subviewSize.width / 2, superInCenter.y);
            tPoint2 = CGPointMake(subviewSize.width / 2, tPoint1.y);
        }
            break;
        case ShowHideAnimationTypeFromRight:
        {
            //向左滑入动画的坐标设置
            tPoint1 = CGPointMake(supersize.width + subviewSize.width / 2, superInCenter.y);
            tPoint2 = CGPointMake(supersize.width - subviewSize.width / 2, tPoint1.y);
        }
            break;
        default:
            break;
    }
    
    
    if (isShow) {
        *startCenterPoint = tPoint1;
        *endCenterPoint = tPoint2;
    }else {
        *startCenterPoint = tPoint2;
        *endCenterPoint = tPoint1;
    }
}

- (void)showViewDuration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL))completion
{
    [self switchingViewIsShow:YES duration:duration animationType:animationType completion:completion];
}

- (void)hideViewDuration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL))completion
{
    [self switchingViewIsShow:NO duration:duration animationType:animationType completion:completion];
}

- (void)switchingViewIsShow:(BOOL)isShow duration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL))completion
{
    NSAssert(self.superview, @" --> 视图没有父视图，添加后再执行吧");
    
    //设置子视图的起止坐标
    CGPoint startCenterPoint, endCenterPoint;
    
    //设置视图的起止位置
    [self areaSubviewStartCenterPoint:&startCenterPoint endCenterPoint:&endCenterPoint isShow:isShow animationType:animationType];
    
    //判断视图的当前位置是否与动画结束后的位置是否一致
    //若一致时不执行动画
    if ((CGPointEqualToPoint(self.center, endCenterPoint))) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    //重置子视图的起始坐标
    self.center = startCenterPoint;
    
    //执行显示动画
    [UIView animateWithDuration:duration animations:^{
        
        //设置子视图的终止坐标
        self.center = endCenterPoint;
    } completion:completion];
}
@end

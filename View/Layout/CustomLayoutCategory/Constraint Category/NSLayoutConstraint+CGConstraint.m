//
//  NSLayoutConstraint+CGConstraint.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSLayoutConstraint+CGConstraint.h"

#import "UIView+CGSearchView.h"

@implementation NSLayoutConstraint (CGConstraint)

- (UIView *)cg_getDidAddLayoutConstraintView
{
    
    if ([self.firstItem respondsToSelector:@selector(constraints)]) {
        if ([[self.firstItem constraints] containsObject:self]) {
            return self.firstItem;
        }
    }
    if ([self.secondItem respondsToSelector:@selector(constraints)]) {
        if ([[self.secondItem constraints] containsObject:self]) {
            return self.secondItem;
        }
    }
    
    BOOL firstItemIsView    = [self.firstItem isKindOfClass:[UIView class]];
    BOOL secondItemIsView   = [self.secondItem isKindOfClass:[UIView class]];
    
    if (firstItemIsView && secondItemIsView) {
        //获取共同父视图
        UIView *commonSuperview = [self.firstItem cg_searchCommonSuperviewWithView:self.secondItem];
        while (commonSuperview) {
            if ([commonSuperview.constraints containsObject:self]) {
                break;
            }
            commonSuperview = commonSuperview.superview;
        }
        
        return commonSuperview;
    }
    
    //由于其他状况为 与UIViewController 的topLayoutGuide或bottomLayoutGuide的约束，这样无法获取其父视图对象
    //所以就获取其中一个视图对象来循环遍历吧
    if (firstItemIsView || secondItemIsView) {
        
        UIView *tempTargetView  = nil;
        if (firstItemIsView) {
            tempTargetView  = [self.firstItem superview];
        }else {
            tempTargetView  = [self.secondItem superview];
        }
        
        while (tempTargetView) {
            if ([tempTargetView.constraints containsObject:self]) {
                break;
            }
            tempTargetView  = tempTargetView.superview;
        }
        return tempTargetView;
    }
    
    //其他情况就是两个都不是UIView视图了，这种情况就想到一个两个UIViewController 的 topLayoutGuide或bottomLayoutGuide 的约束，我至少没有碰到这种情况，呵呵
    //此方法不适合这个
    
    return nil;
}

- (void)setupLayoutPriority:(UILayoutPriority)priority
{
    if (priority > 0 && priority <= UILayoutPriorityRequired) {
        self.priority   = priority;
    }
}

@end

//
//  UIView+CGAddConstraintsForSubviews.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGAddConstraintsForSubviews.h"

#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"

#import "CGTwoSubviewsConstraintsAppearance.h"

@implementation UIView (CGAddConstraintsForSubviews)

- (NSArray<NSLayoutConstraint *> *)cg_autoTwoSubviewsWithConfig:(CGTwoSubviewsConstraintsAppearance *)config
{
    NSArray *twoSubviews    = [config getTwoSubviewsWithSuperview:self];
    if (!twoSubviews) {
        return nil;
    }
    
    UIView *firstView   = [twoSubviews firstObject];
    UIView *secondView  = [twoSubviews objectAtIndex:1];
    UIView *superview   = firstView.superview;
    
    NSMutableArray  *constraints    = [NSMutableArray array];
    
    CGAxis  axis;
    CGLayoutEdge        firstViewExcludingLayoutEdge;
    CGLayoutEdge        secondViewExcludingEdge;
    
    CGLayoutOptionEdge  firstViewExcludingOptionEdge;
    CGLayoutOptionEdge  secondViewExcludingOptionEdge;
    
    //设置指定对齐方式后，第一个视图与第二个视图之间可以对齐的边
    CGLayoutOptionEdge (^equalOptionEqual)(CGAlignmentType, CGLayoutOptionEdge) = ^(CGAlignmentType alignmentType, CGLayoutOptionEdge equalEdge) {
        
        CGLayoutOptionEdge edge = 0;
        if (alignmentType == CGAlignmentTypeHorizontal) {
            if (equalEdge & CGLayoutOptionEdgeTop) {
                edge    |= CGLayoutOptionEdgeTop;
            }
            if (equalEdge & CGLayoutOptionEdgeBottom) {
                edge    |= CGLayoutOptionEdgeBottom;
            }
        }else {
            if (equalEdge & CGLayoutOptionEdgeLeading || equalEdge & CGLayoutOptionEdgeLeft) {
                edge    |= CGLayoutOptionEdgeLeading;
            }else if (equalEdge & CGLayoutOptionEdgeTrailing || equalEdge & CGLayoutOptionEdgeRight) {
                edge    |= CGLayoutOptionEdgeTrailing;
            }
        }
        return edge;
    };
    
    CGLayoutOptionEdge  firstViewEqualSecondViewEdge    = equalOptionEqual(config.alignmentType, config.firstViewEqualSecondViewEdge);
    CGLayoutOptionEdge  secondViewEqualFirstViewEdge    = equalOptionEqual(config.alignmentType, config.secondViewEqualFirstViewEdge);
    
    CGFloat firstViewExcludingOffset;
    CGFloat secondViewExcludingOffset;
    
    //计算指定对齐时，并设置两子视图有对齐之后，与父视图之间的约束边值设置
    CGLayoutOptionEdge (^centerOptionEdge) (CGAlignmentType, CGLayoutOptionEdge) = ^(CGAlignmentType alignmentType, CGLayoutOptionEdge optionEdge) {
        
        CGLayoutOptionEdge centerOptionEdge = 0;
        
        if (alignmentType == CGAlignmentTypeHorizontal) {
            
            if (!(optionEdge & CGLayoutOptionEdgeTop)) {
                centerOptionEdge   |= CGLayoutOptionEdgeTop;
            }
            if (!(optionEdge & CGLayoutOptionEdgeBottom)) {
                centerOptionEdge   |= CGLayoutOptionEdgeBottom;
            }
        }else {
            
            if (!(optionEdge & CGLayoutOptionEdgeLeft) && !(optionEdge & CGLayoutOptionEdgeLeading)) {
                centerOptionEdge    |= CGLayoutOptionEdgeLeading;
            }
            if (!(optionEdge & CGLayoutOptionEdgeRight) && !(optionEdge & CGLayoutOptionEdgeTrailing)) {
                centerOptionEdge    |= CGLayoutOptionEdgeTrailing;
            }
        }
        
        return centerOptionEdge;
    };
    
    CGLayoutOptionEdge firstViewCenterOptionEdge    = centerOptionEdge(config.alignmentType, firstViewEqualSecondViewEdge);
    CGLayoutOptionEdge secondViewCenterOptionEdge   = centerOptionEdge(config.alignmentType, secondViewEqualFirstViewEdge);
    
    if (config.alignmentType == CGAlignmentTypeHorizontal) {
        
        firstViewExcludingLayoutEdge    = CGLayoutEdgeTrailing;
        secondViewExcludingEdge         = CGLayoutEdgeLeading;
        
        firstViewExcludingOptionEdge    = CGLayoutOptionEdgeTrailing;
        secondViewExcludingOptionEdge   = CGLayoutOptionEdgeLeading;
        
        axis                            = CGAxisHorizontal;
        
        firstViewExcludingOffset    = config.firstViewEdgeInsets.left;
        secondViewExcludingOffset   = config.secondViewEdgeInsets.right;
        
    }else {
        
        firstViewExcludingLayoutEdge    = CGLayoutEdgeBottom;
        secondViewExcludingEdge         = CGLayoutEdgeTop;
        
        firstViewExcludingOptionEdge    = CGLayoutOptionEdgeBottom;
        secondViewExcludingOptionEdge   = CGLayoutOptionEdgeTop;
        
        axis                            = CGAxisVertical;
        
        firstViewExcludingOffset    = config.firstViewEdgeInsets.top;
        secondViewExcludingOffset   = config.secondViewEdgeInsets.bottom;
        
    }
    
    if (firstViewEqualSecondViewEdge) {
        [firstView cg_autoAttributeOptionEqual:firstViewEqualSecondViewEdge toItem:secondView];
    }
    if (secondViewEqualFirstViewEdge) {
        [secondView cg_autoAttributeOptionEqual:secondViewEqualFirstViewEdge toItem:firstView];
    }
    
    if (config.firstViewCenter) {
        
        [firstView cg_autoAxis:axis toSameAxisOfView:superview];
        [firstView cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)secondViewExcludingEdge withOffset:firstViewExcludingOffset];
        
        [firstView cg_autoEdgesToSuperviewEdgesWithEdge:firstViewCenterOptionEdge | config.firstViewExcludingOptionEdge insets:config.firstViewEdgeInsets relation:NSLayoutRelationGreaterThanOrEqual];
    }else {
        
        CGLayoutOptionEdge optionEdge = firstViewEqualSecondViewEdge | firstViewExcludingOptionEdge | config.firstViewExcludingOptionEdge;
        [firstView cg_autoEdgesToSuperviewEdgesWithInsets:config.firstViewEdgeInsets excludingOptionEdge:optionEdge];
    }
    
    if (config.secondViewCenter) {
        
        [secondView cg_autoAxis:axis toSameAxisOfView:superview];
        [secondView cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)firstViewExcludingLayoutEdge withOffset:secondViewExcludingOffset];
        [secondView cg_autoEdgesToSuperviewEdgesWithEdge:secondViewCenterOptionEdge insets:config.secondViewEdgeInsets relation:NSLayoutRelationGreaterThanOrEqual];
    }else {
        
        CGLayoutOptionEdge optionEdge   = secondViewEqualFirstViewEdge | secondViewExcludingOptionEdge | config.secondViewExcludingOptionEdge;
        [secondView cg_autoEdgesToSuperviewEdgesWithInsets:config.secondViewEdgeInsets excludingOptionEdge:optionEdge];
    }
    
    [firstView cg_autoInverseAttribute:firstViewExcludingLayoutEdge toItem:secondView relatedBy:config.betweenSpaceLayoutRelation constant:config.firstViewToSecondViewSpace];
    
    CGFloat minSize = 0.0001;
    if (config.firstViewWidth > minSize) {
        [firstView cg_autoDimension:CGDimensionWidth fixedLength:config.firstViewWidth];
    }
    if (config.firstViewHeight > minSize) {
        [firstView cg_autoDimension:CGDimensionHeight fixedLength:config.firstViewHeight];
    }
    if (config.secondViewWidth > minSize) {
        [secondView cg_autoDimension:CGDimensionWidth fixedLength:config.secondViewWidth];
    }
    if (config.secondViewHeight > minSize) {
        [secondView cg_autoDimension:CGDimensionHeight fixedLength:config.secondViewHeight];
    }
    
    if (config.widthEqual) {
        [firstView cg_autoDimension:CGDimensionWidth equalView:secondView];
    }
    if (config.heightEqual) {
        [firstView cg_autoDimension:CGDimensionHeight equalView:secondView];
    }
    
    return constraints;
}

@end

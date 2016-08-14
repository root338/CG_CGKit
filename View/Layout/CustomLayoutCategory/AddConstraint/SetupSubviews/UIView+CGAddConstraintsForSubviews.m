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
    CGLayoutEdge firstViewExcludingEdge;
    CGLayoutEdge secondViewExcludingEdge;
    CGLayoutEdge firstViewEqualSecondViewEdge   = 0;
    
    CGFloat firstViewExcludingOffset;
    CGFloat secondViewExcludingOffset;
    
    CGLayoutOptionEdge subviewsOptionEdge;
    
    if (config.alignmentType == CGAlignmentTypeHorizontal) {
        
        firstViewExcludingEdge  = CGLayoutEdgeTrailing;
        secondViewExcludingEdge = CGLayoutEdgeLeading;
        
        axis                    = CGAxisHorizontal;
        subviewsOptionEdge      = CGLayoutOptionEdgeVertical;
        
        firstViewExcludingOffset    = config.firstViewEdgeInsets.left;
        secondViewExcludingOffset   = config.secondViewEdgeInsets.right;
        
        if (config.firstViewEqualSecondViewEdge == CGLayoutEdgeTop || config.firstViewEqualSecondViewEdge == CGLayoutEdgeBottom) {
            firstViewEqualSecondViewEdge    = config.firstViewEqualSecondViewEdge;
        }
    }else {
        
        firstViewExcludingEdge  = CGLayoutEdgeBottom;
        secondViewExcludingEdge = CGLayoutEdgeTop;
        
        axis                    = CGAxisVertical;
        subviewsOptionEdge      = CGLayoutOptionEdgeHorizontal;
        
        firstViewExcludingOffset    = config.firstViewEdgeInsets.top;
        secondViewExcludingOffset   = config.secondViewEdgeInsets.bottom;
        
        if (config.firstViewEqualSecondViewEdge == CGLayoutEdgeLeading || config.firstViewEqualSecondViewEdge == CGLayoutEdgeLeft || config.firstViewEqualSecondViewEdge == CGLayoutEdgeTrailing || config.firstViewEqualSecondViewEdge == CGLayoutEdgeRight) {
            firstViewEqualSecondViewEdge    = config.firstViewEqualSecondViewEdge;
        }
    }
    
    if (config.firstViewCenter || firstViewEqualSecondViewEdge) {
        
        if (config.firstViewCenter) {
            [firstView cg_autoAxis:axis toSameAxisOfView:superview];
        }else {
            [firstView cg_attribute:(NSLayoutAttribute)firstViewEqualSecondViewEdge toItem:secondView];
        }
        
        [firstView cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)secondViewExcludingEdge withOffset:firstViewExcludingOffset];
        [firstView cg_autoEdgesToSuperviewEdgesWithEdge:subviewsOptionEdge insets:config.firstViewEdgeInsets relation:NSLayoutRelationGreaterThanOrEqual];
    }else {
        
        [firstView cg_autoEdgesToSuperviewEdgesWithInsets:config.firstViewEdgeInsets excludingEdge:firstViewExcludingEdge];
    }
    
    if (config.secondViewCenter || firstViewEqualSecondViewEdge) {
        
        if (config.secondViewCenter) {
            [secondView cg_autoAxis:axis toSameAxisOfView:superview];
        }
        
        [secondView cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)firstViewExcludingEdge withOffset:secondViewExcludingOffset];
        [secondView cg_autoEdgesToSuperviewEdgesWithEdge:subviewsOptionEdge insets:config.secondViewEdgeInsets relation:NSLayoutRelationGreaterThanOrEqual];
    }else {
        
        [secondView cg_autoEdgesToSuperviewEdgesWithInsets:config.secondViewEdgeInsets excludingEdge:secondViewExcludingEdge];
    }
    
    [firstView cg_autoInverseAttribute:firstViewExcludingEdge toItem:secondView constant:config.firstViewToSecondViewSpace];
    
    CGFloat minSize = 0.0001;
    if (config.firstViewWidth > minSize) {
        [firstView cg_autoDimension:CGDimensionWidth fixedLength:config.firstViewWidth];
    }
    if (config.firstViewWidth > minSize) {
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
        [secondView cg_autoDimension:CGDimensionHeight equalView:secondView];
    }
    
    return constraints;
}

@end

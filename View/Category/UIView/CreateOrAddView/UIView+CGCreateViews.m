//
//  UIView+CGCreateViews.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIView+CGCreateViews.h"

#import "CGAddSubviewsAppearance.h"

#import "Value+Constant.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"

@implementation UIView (CGCreateViews)

- (BOOL)isStopAddSubviews:(BOOL (^ __nullable) (CGAddSubviewsErrorType errorType))stopAddSubviews errorType:(CGAddSubviewsErrorType)errorType
{
    BOOL isStopAddSubviews  = NO;
    if (CGAddSubviewsErrorTypeNone == errorType && stopAddSubviews) {
        isStopAddSubviews   = stopAddSubviews(errorType);
    }
    return isStopAddSubviews;
}

- (CGSize)cg_createViewsWithRule:(__kindof CGAddSubviewsAppearance *)viewsRule stopAddSubviews:(BOOL (^ _Nullable)(CGAddSubviewsErrorType))stopAddSubviews subview:(nonnull __kindof UIView * _Nonnull (^)(NSInteger))setupSubview
{
    CGSize  calculateSize   = CGSizeZero;
    __block CGAddSubviewsErrorType _errorType;
    __block CGFloat width, height, itemWidth, itemHeight;
    
    [viewsRule cg_getWidthWithSuperview:self completion:^(CGAddSubviewsErrorType errorType, CGFloat paramWidth, CGFloat superWidth) {
        
        _errorType  = errorType;
        width       = superWidth;
        itemWidth   = paramWidth;
    }];
    
    CGDebugAssert(!_errorType, @"设置的布局数值有问题");
    if ([self isStopAddSubviews:stopAddSubviews errorType:_errorType]) {
        return calculateSize;
    }
    
    [viewsRule cg_getHeightWithSuperview:self completion:^(CGAddSubviewsErrorType errorTye, CGFloat paramHeight, CGFloat superHeight) {
        
        _errorType  = errorTye;
        height      = superHeight;
        itemHeight  = paramHeight;
    }];
    
    CGDebugAssert(!_errorType, @"设置的布局数值有问题");
    if ([self isStopAddSubviews:stopAddSubviews errorType:_errorType]) {
        return calculateSize;
    }
    
    for (NSInteger index = 0; index < viewsRule.subviewsTotal; index++) {
        
        UIView *subview = setupSubview(index);
        
        subview.frame   = CGRectMake(viewsRule.marginEdgeInset.left + (index % viewsRule.count) * (itemWidth + viewsRule.horizontalSpace), viewsRule.marginEdgeInset.top + (index / viewsRule.count) * (itemHeight + viewsRule.verticalSpace), itemWidth, itemHeight);
        [self addSubview:subview];
    }
    
    if (viewsRule.isAutoSetupViewWidth) {
        self.width  = width;
    }
    if (viewsRule.isAutoSetupViewHeight) {
        self.height = height;
    }
    
    calculateSize   =   CGSizeMake(width, height);
    
    return calculateSize;
}

@end

@implementation UIView (CGCreateView)

+ (instancetype)cg_createViewWithBackgroundColor:(UIColor *)backgroundColor
{
    UIView *view            = [[self alloc] initWithFrame:CGRectZero];
    view.backgroundColor    = backgroundColor;
    return view;
}

@end
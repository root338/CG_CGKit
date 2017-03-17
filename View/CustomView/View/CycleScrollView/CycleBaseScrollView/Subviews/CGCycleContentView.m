//
//  CGCycleContentView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleContentView.h"
#import "CGCycleScrollView.h"

#import "UIView+CGCreate.h"
#import "UIView+CGSearchView.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"

@interface CGCycleContentView ()
{
    
}

@end

@implementation CGCycleContentView

/** 固定视图样式 */
+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    CGErrorConditionLog(buttonType != UIButtonTypeCustom, @"按钮样式只能是UIButtonTypeCustom，已自动转换");
    return [super buttonWithType:UIButtonTypeCustom];
}

+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index
{
    return [self cg_createCycleContentViewWithContentView:contentView index:index marginEdgeInsets:UIEdgeInsetsZero];
}

+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index marginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    CGCycleContentView *cycleContentView    = [self cg_createView];
    
    cycleContentView.contentView            = contentView;
    cycleContentView.viewIndex              = index;
    cycleContentView.marginEdgeInsets       = marginEdgeInsets;
    
    return cycleContentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame          = CG_CGRectWithMargin(self.bounds, self.marginEdgeInsets);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        
    }
}

#pragma mark - 事件
- (void)handleClickAction:(id)sender
{
    CGCycleScrollView *scrollView = (CGCycleScrollView *)[self searchSuperViewWithClass:[CGCycleScrollView class]];
    if ([scrollView.delegate respondsToSelector:@selector(cycleScrollView:didSelectRowAtIndex:)]) {
        [scrollView.delegate cycleScrollView:scrollView didSelectRowAtIndex:self.viewIndex];
    }
}

#pragma mark - 设置属性
- (void)setContentView:(UIView *)contentView
{
    if (contentView != _contentView) {
        if (_contentView.superview) {
            [_contentView removeFromSuperview];
        }
        
        _contentView = contentView;
        
        [self addSubview:contentView];
        contentView.frame = self.bounds;
    }
}

@end

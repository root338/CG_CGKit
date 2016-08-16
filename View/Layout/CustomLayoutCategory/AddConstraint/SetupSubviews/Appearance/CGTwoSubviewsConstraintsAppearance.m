//
//  CGTwoSubviewsConstraintsAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTwoSubviewsConstraintsAppearance.h"

#import "CGPrintLogHeader.h"

@implementation CGTwoSubviewsConstraintsAppearance

+ (instancetype)createConfigWithSuperview:(UIView *)superview
{
    CGTwoSubviewsConstraintsAppearance *config  = [[self alloc] init];
    config.superView    = superview;
    return config;
}

- (instancetype)init
{
    self    = [super init];
    if (self) {
        
        _alignmentType  = CGAlignmentTypeHorizontal;
        _firstViewEdgeInsets    = UIEdgeInsetsZero;
        _secondViewEdgeInsets   = UIEdgeInsetsZero;
        _betweenSpaceLayoutRelation = NSLayoutRelationEqual;
        
        _firstViewToSecondViewSpace = 0;
        
        _firstViewWidth     = 0;
        _firstViewHeight    = 0;
        _secondViewWidth    = 0;
        _secondViewHeight   = 0;
    }
    return self;
}

- (NSArray<UIView *> *)getTwoSubviewsWithSuperview:(UIView *)superview
{
    if (self.firstView && self.secondView) {
        if (self.firstView.superview != self.secondView.superview) {
            CGDebugAssert(nil, @"设置的第一个视图与第二个视图的父视图不相同");
            return nil;
        }
        return @[self.firstView, self.secondView];
    }
    
    if (!superview) {
        superview   = self.superView;
    }
    
    if (superview.subviews.count < 2) {
        CGDebugAssert(nil, @"父视图的子视图必须大于2");
        return nil;
    }
    
    UIView *firstView   = nil;
    UIView *secondView  = nil;
    
    if (self.firstView) {
        
        firstView   = self.firstView;
    }else {
        firstView  = [superview.subviews firstObject];
    }
    if (self.secondView) {
        
        secondView  = self.secondView;
    }else {
        
        secondView  = [superview.subviews objectAtIndex:1];
    }
    
    return @[firstView, secondView];
}

#pragma mark - 设置属性
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    self.firstViewEdgeInsets    = edgeInsets;
    self.secondViewEdgeInsets   = edgeInsets;
}

- (void)setCenter:(BOOL)center
{
    self.firstViewCenter    = center;
    self.secondViewCenter   = center;
}

- (void)setFirstViewSize:(CGSize)firstViewSize
{
    self.firstViewWidth     = firstViewSize.width;
    self.firstViewHeight    = firstViewSize.height;
}

- (void)setSecondViewSize:(CGSize)secondViewSize
{
    self.secondViewWidth    = secondViewSize.width;
    self.secondViewHeight   = secondViewSize.height;
}

- (void)setSize:(CGSize)size
{
    self.firstViewSize  = size;
    self.secondViewSize = size;
}

- (void)setSizeEqual:(BOOL)sizeEqual
{
    self.widthEqual     = sizeEqual;
    self.heightEqual    = sizeEqual;
}

@end

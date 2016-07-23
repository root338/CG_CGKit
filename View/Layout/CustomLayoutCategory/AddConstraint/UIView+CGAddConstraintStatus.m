//
//  UIView+CGAddConstraintStatus.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGAddConstraintStatus.h"

#import "UIView+CGSearchView.h"
#import "NSLayoutConstraint+CGVerifyConstraint.h"

#import <objc/runtime.h>

@implementation UIView (CGAddConstraintStatus)

- (NSLayoutConstraint *)cg_updateConstraintWithAtt1:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)item2 att2:(NSLayoutAttribute)att2 multiplier:(CGFloat)multiplier constant:(CGFloat)c commonSuperview:(nullable UIView *)commonSuperview
{
    NSLayoutConstraint *layoutConstraint    = nil;
    
    layoutConstraint    = [self cg_searchAttribute:att1 relatedBy:relation toItem:item2 attribute:att2 commonSuperview:commonSuperview];
    
    if (layoutConstraint) {
        
        if (layoutConstraint.multiplier != multiplier) {
            
            [commonSuperview removeConstraint:layoutConstraint];
            layoutConstraint    = nil;
        }else {
            
            layoutConstraint.constant   = c;
        }
    }
    return layoutConstraint;
}

#pragma mark - 设置属性
- (void)setIsUpdateAddConstraint:(BOOL)isUpdate
{
    objc_setAssociatedObject(self, @selector(isUpdateAddConstraint), @(isUpdate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isUpdateAddConstraint
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLayoutPriorityForConstraint:(UILayoutPriority)layoutPriority
{
    objc_setAssociatedObject(self, @selector(layoutPriorityForConstraint), @(layoutPriority), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILayoutPriority)layoutPriorityForConstraint
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end

@implementation UIView (CGSearchConstraint)

- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2
{
    UIView *targetCommonSuperview = [self cg_searchCommonSuperviewWithView:view2];
    
    return [self cg_searchAttribute:att1 relatedBy:relation toItem:view2 attribute:attr2 commonSuperview:targetCommonSuperview];
}

- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 commonSuperview:(UIView *)commonSuperview
{
    __block NSLayoutConstraint *targetLayoutConstraint  = nil;
    
    [commonSuperview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL isResult = [obj cg_verifyWithItem:self attribute:att1 relatedBy:relation toItem:view2 attribute:attr2 searchType:nil];
        if (isResult) {
            targetLayoutConstraint  = obj;
            *stop   = YES;
        }
    }];
    
    return targetLayoutConstraint;
}

@end
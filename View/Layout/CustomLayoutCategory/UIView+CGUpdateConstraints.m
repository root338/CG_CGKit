//
//  UIView+CGUpdateConstraints.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGUpdateConstraints.h"

#import "UIView+CGSearchView.h"
#import "NSLayoutConstraint+CGVerifyConstraint.h"

#pragma mark - 添加多个约束

@implementation UIView (CGUpdateViewControllerConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesInsetsZeroToViewController:(UIViewController *)viewController
{
    return [self cg_updateAutoEdgesToViewController:viewController withInsets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    
    [constraints addObject:[self cg_updateTopLayoutGuideOfViewController:viewController withInset:insets.top]];
    [constraints addObject:[self cg_updateAttribute:NSLayoutAttributeLeading toItem:viewController.view constant:insets.left]];
    [constraints addObject:[self cg_updateAttribute:NSLayoutAttributeTrailing toItem:viewController.view constant:insets.right]];
    [constraints addObject:[self cg_updateBottomLayoutGuideOfViewController:viewController withInset:insets.bottom]];
    
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        [constraints addObject:[self cg_updateTopLayoutGuideOfViewController:viewController withInset:insets.top]];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        [constraints addObject:[self cg_updateAttribute:NSLayoutAttributeLeading toItem:viewController.view constant:insets.left]];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        [constraints addObject:[self cg_updateBottomLayoutGuideOfViewController:viewController withInset:insets.bottom]];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        [constraints addObject:[self cg_updateAttribute:NSLayoutAttributeTrailing toItem:viewController.view constant:insets.right]];
    }
    
    return constraints;
}

@end

@implementation UIView (CGUpdateSuperviewConstranints)

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesInsetsZeroToSuperview
{
    return [self cg_updateAutoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    
    [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top]];
    [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left]];
    [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom]];
    [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right]];
    
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top]];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left]];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom]];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        [constraints addObject:[self cg_updateAutoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right]];
    }
    
    return constraints;
}

@end

#pragma mark - 添加单个约束
@implementation UIView (CGUpdateSuperviewConstranint)

- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute
{
    return [self cg_updateAutoConstrainToSuperviewAttribute:attribute withOffset:0 relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation
{
    return [self cg_updateAutoConstrainToSuperviewAttribute:attribute withOffset:0 relation:relation];
}

- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset
{
    return [self cg_updateAutoConstrainToSuperviewAttribute:attribute withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self cg_updateAttribute:attribute toItem:self.superview relatedBy:relation constant:offset];
}

@end

@implementation UIView (CGSuperViewControllerConstraint)


- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_updateTopLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_updateTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    
    NSLayoutAttribute attr1 = NSLayoutAttributeTop;
    NSLayoutAttribute attr2 = NSLayoutAttributeBottom;
    CGFloat multiplier      = 1.0;
    
    NSLayoutConstraint *layoutConstraint    = [self cg_searchAttribute:attr1 relatedBy:relation toItem:viewController.topLayoutGuide attribute:attr2 commonSuperview:viewController.view];
    if (layoutConstraint) {
        
        if (layoutConstraint.multiplier != multiplier) {
            
            [viewController.view removeConstraint:layoutConstraint];
            layoutConstraint    = nil;
        }else {
            
            layoutConstraint.constant   = inset;
        }
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:viewController.topLayoutGuide attribute:attr2 multiplier:multiplier constant:inset];
        [viewController.view addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_updateBottomLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_updateBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    
    inset   = -inset;
    if (NSLayoutRelationGreaterThanOrEqual == relation) {
        relation    = NSLayoutRelationLessThanOrEqual;
    }else if (NSLayoutRelationLessThanOrEqual == relation) {
        relation    = NSLayoutRelationGreaterThanOrEqual;
    }
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    
    NSLayoutAttribute attr1 = NSLayoutAttributeBottom;
    NSLayoutAttribute attr2 = NSLayoutAttributeTop;
    CGFloat multiplier      = 1.0;
    
    NSLayoutConstraint *layoutConstraint    = [self cg_searchAttribute:attr1 relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:attr2 commonSuperview:viewController.view];
    if (layoutConstraint) {
        
        if (layoutConstraint.multiplier != multiplier) {
            
            [viewController.view removeConstraint:layoutConstraint];
            layoutConstraint    = nil;
        }else {
            
            layoutConstraint.constant   = inset;
        }
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:attr2 multiplier:multiplier constant:inset];
        [viewController.view addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

@end

@implementation UIView (CGUpdateViewAxisConstraint)

- (NSLayoutConstraint *)cg_updateAutoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView
{
    return [self cg_updateAttribute:(NSLayoutAttribute)axis toItem:otherView];
}

- (NSLayoutConstraint *)cg_updateAutoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self cg_updateAttribute:(NSLayoutAttribute)axis toItem:otherView constant:offset];
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoCenterToSameAxisOfView:(UIView *)otherView
{
    return [self cg_updateAutoCenterToSameAxisOfView:otherView withOffset:CGPointZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoCenterToSameAxisOfView:(UIView *)otherView withOffset:(CGPoint)offset
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    
    [constraints addObject:[self cg_updateAutoAxis:CGAxisVertical toSameAxisOfView:otherView withOffset:offset.x]];
    [constraints addObject:[self cg_updateAutoAxis:CGAxisHorizontal toSameAxisOfView:otherView withOffset:offset.y]];
    
    return constraints;
}

@end

@implementation UIView (CGUpdateViewDimensionConstraint)

- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength
{
    return [self cg_updateAutoDimension:dimension fixedLength:fixedLength relation:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_updateAutoSetupViewSize:(CGSize)viewSize
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    
    [constraints addObject:[self cg_updateAutoDimension:CGDimensionWidth fixedLength:viewSize.width]];
    [constraints addObject:[self cg_updateAutoDimension:CGDimensionHeight fixedLength:viewSize.height]];
    
    return constraints;
}

- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    
    NSLayoutAttribute attr1 = (NSLayoutAttribute)dimension;
    NSLayoutAttribute attr2 = NSLayoutAttributeNotAnAttribute;
    
    NSLayoutConstraint *layoutConstraint    = [self cg_searchAttribute:attr1 relatedBy:relation toItem:nil attribute:attr2 commonSuperview:self];
    if (layoutConstraint) {
            
        layoutConstraint.constant   = fixedLength;
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint  = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:nil attribute:attr2 multiplier:0 constant:fixedLength];
        [self addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension equalView:(UIView *)view
{
    return [self cg_updateAutoDimension:dimension view:view relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation
{
    return [self cg_updateAttribute:(NSLayoutAttribute)dimension toItem:view relatedBy:relation constant:0];
}

@end

@implementation UIView (CGUpdateConstraint)

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2
{
    return [self cg_updateAttribute:attribute toItem:view2 constant:0];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 constant:(CGFloat)c
{
    return [self cg_updateAttribute:attribute toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    if (attribute == NSLayoutAttributeTrailing || attribute == NSLayoutAttributeRight || attribute == NSLayoutAttributeBottom) {
        c = -c;
        
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation    = NSLayoutRelationLessThanOrEqual;
        }else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
    }
    
    NSLayoutAttribute att2 = attribute;
    return [self cg_updateAttribute:attribute relatedBy:relation toItem:view2 attribute:att2 multiplier:1.0 constant:c];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_updateAttribute:attribute toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_updateAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_updateAttribute:attribute relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 constant:c];
}

- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_updateAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
}

/** 设置两对象之间的约束(边值类型，约束类型，间距，比例值) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    NSAssert(self.superview, @"请添加到父视图中再添加约束");
    
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    // !!! warning : view2 视图不能将 translatesAutoresizingMaskIntoConstraints 自动设置为NO
    
    UIView *commonSuperview  = [self cg_searchCommonSuperviewWithView:view2];
    NSAssert(commonSuperview, @"添加约束的两视图没有共同父视图");
    
    NSLayoutConstraint *layoutConstraint    = [self cg_searchAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 commonSuperview:commonSuperview];
    if (layoutConstraint) {
        
        if (layoutConstraint.multiplier != multiplier) {
            
            [commonSuperview removeConstraint:layoutConstraint];
            layoutConstraint    = nil;
        }else {
            
            layoutConstraint.constant   = c;
        }
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
        [commonSuperview addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
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
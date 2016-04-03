//
//  UIView+CGAddConstraints.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGAddConstraints.h"
#import "UIView+CGSearchView.h"

#pragma mark - 添加多个约束

@implementation UIView (CGViewControllerConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToViewController:(UIViewController *)viewController
{
    return [self cg_autoEdgesToViewController:viewController withInsets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    
    [constraints addObject:[self cg_topLayoutGuideOfViewController:viewController withInset:insets.top]];
    [constraints addObject:[self cg_attribute:NSLayoutAttributeLeading toItem:viewController.view constant:insets.left]];
    [constraints addObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:viewController.view constant:insets.right]];
    [constraints addObject:[self cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom]];
    
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        [constraints addObject:[self cg_topLayoutGuideOfViewController:viewController withInset:insets.top]];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeLeading toItem:viewController.view constant:insets.left]];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        [constraints addObject:[self cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom]];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:viewController.view constant:insets.right]];
    }
    
    return constraints;
}

@end

@implementation UIView (CGSuperviewConstranints)

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperview
{
    return [self cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    
    [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top]];
    [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left]];
    [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom]];
    [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right]];
    
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top]];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left]];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom]];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right]];
    }
    
    return constraints;
}

@end

#pragma mark - 添加单个约束
@implementation UIView (CGSuperviewConstranint)

- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute
{
    return [self cg_autoConstrainToSuperviewAttribute:attribute withOffset:0 relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation
{
    return [self cg_autoConstrainToSuperviewAttribute:attribute withOffset:0 relation:relation];
}

- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset
{
    return [self cg_autoConstrainToSuperviewAttribute:attribute withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self cg_attribute:attribute toItem:self.superview relatedBy:relation constant:offset];
}

@end

@implementation UIView (CGViewDimensionConstraint)

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength
{
    return [self cg_autoDimension:dimension fixedLength:fixedLength relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *constraint  = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)dimension relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:fixedLength];
    [self addConstraint:constraint];
    return constraint;
}

@end

@implementation UIView (CGViewControllerConstraint)


- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_topLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_topLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:inset];
    [viewController.view addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_bottomLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_bottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    inset   = -inset;
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:inset];
    [viewController.view addConstraint:layoutConstraint];
    return layoutConstraint;
}

@end

@implementation UIView (CGAddConstraint)

//- (NSLayoutConstraint *)cg_attributeBy:(CGLayoutAttribute)layoutAttribute
//{
//    
//}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2
{
    return [self cg_attribute:attribute toItem:view2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 constant:(CGFloat)c
{
    return [self cg_attribute:attribute toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    if (attribute == NSLayoutAttributeTrailing || attribute == NSLayoutAttributeRight || attribute == NSLayoutAttributeBottom) {
        c = -c;
    }
    NSLayoutAttribute att2 = attribute;
    return [self cg_attribute:attribute relatedBy:relation toItem:view2 attribute:att2 multiplier:1.0 constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    NSAssert(self.superview, @"请添加到父视图中再添加约束");
    
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    // !!! warning : view2 视图不能将 translatesAutoresizingMaskIntoConstraints 自动设置为NO
    
    UIView *commonSuperview  = [self cg_searchCommonSuperviewWithView:view2];
    NSAssert(commonSuperview, @"添加约束的两视图没有共同父视图");
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    [commonSuperview addConstraint:layoutConstraint];
    
    return layoutConstraint;
}

@end

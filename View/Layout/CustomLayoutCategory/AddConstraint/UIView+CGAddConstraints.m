//
//  UIView+CGAddConstraints.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGAddConstraints.h"
#import "UIView+CGCreateConstraint.h"

#import "UIView+CGSearchView.h"
#import "UIView+CGCreateConstraint.h"
#import "NSLayoutConstraint+CGVerifyConstraint.h"

#import "CGPrintLogHeader.h"
#pragma mark - 添加多个约束

@implementation UIView (CGViewAndViewConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgeEqualWithViews:(NSArray<UIView *> *)views layoutAttribute:(NSLayoutAttribute)layoutAttribute
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:views.count];
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[self cg_attribute:layoutAttribute toItem:obj]];
    }];
    return constraints;
}

@end

@implementation UIView (CGViewControllerConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToViewController:(UIViewController *)viewController
{
    return [self cg_autoEdgesToViewController:viewController withInsets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToViewController:(UIViewController *)viewController exculdingEdge:(CGLayoutEdge)edge
{
    return [self cg_autoEdgesToViewController:viewController withInsets:UIEdgeInsetsZero exculdingEdge:edge];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets
{
    return [[self cg_d_autoEdgesToViewController:viewController withInsets:insets] allValues];
}

- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets
{
    return [self cg_d_autoEdgesToViewController:viewController withInsets:insets exculdingEdge:CGLayoutEdgeNone];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge
{
    return [[self cg_d_autoEdgesToViewController:viewController withInsets:insets exculdingEdge:edge] allValues];
}

- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge
{
    NSMutableDictionary *constraints    = [NSMutableDictionary dictionaryWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        
        [constraints setObject:[self cg_topLayoutGuideOfViewController:viewController withInset:insets.top]
                        forKey:@(NSLayoutAttributeTop)];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        
        [constraints setObject:[self cg_attribute:NSLayoutAttributeLeading toItem:viewController.view constant:insets.left]
                        forKey:@(NSLayoutAttributeLeading)];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        
        [constraints setObject:[self cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom]
                        forKey:@(NSLayoutAttributeBottom)];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        
        [constraints setObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:viewController.view constant:insets.right]
                        forKey:@(NSLayoutAttributeTrailing)];
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
    return [[self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets] allValues];
}

- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    return [self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets excludingEdge:CGLayoutEdgeNone];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge
{
    return [[self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets excludingEdge:edge] allValues];
}

- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge
{
    NSMutableDictionary *constraints    = [NSMutableDictionary dictionaryWithCapacity:3];
    
    if (edge != CGLayoutEdgeTop) {
        [constraints setObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top]
                        forKey:@(NSLayoutAttributeTop)];
    }
    
    if (edge != CGLayoutEdgeLeading && edge != CGLayoutEdgeLeft) {
        [constraints setObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left]
                        forKey:@(NSLayoutAttributeLeading)];
    }
    
    if (edge != CGLayoutEdgeBottom) {
        [constraints setObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom]
                        forKey:@(NSLayoutAttributeBottom)];
    }
    
    if (edge != CGLayoutEdgeRight && edge != CGLayoutEdgeTrailing) {
        [constraints setObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right]
                        forKey:@(NSLayoutAttributeTrailing)];
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

@implementation UIView (CGViewAxisConstraint)

- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView
{
    return [self cg_attribute:(NSLayoutAttribute)axis toItem:otherView];
}

- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self cg_attribute:(NSLayoutAttribute)axis toItem:otherView constant:offset];
}

- (NSLayoutConstraint *)cg_autoCenterToSuperviewWithAxis:(CGAxis)axis
{
    return [self cg_autoAxis:axis toSameAxisOfView:self.superview];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSuperview
{
    return [self cg_autoCenterToSameAxisOfView:self.superview];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSameAxisOfView:(UIView *)otherView
{
    return [self cg_autoCenterToSameAxisOfView:otherView withOffset:CGPointZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSameAxisOfView:(UIView *)otherView withOffset:(CGPoint)offset
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    
    [constraints addObject:[self cg_autoAxis:CGAxisVertical toSameAxisOfView:otherView withOffset:offset.x]];
    [constraints addObject:[self cg_autoAxis:CGAxisHorizontal toSameAxisOfView:otherView withOffset:offset.y]];
    
    return constraints;
}

@end

@implementation UIView (CGViewDimensionConstraint)

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength
{
    return [self cg_autoDimension:dimension fixedLength:fixedLength relation:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupViewSize:(CGSize)viewSize
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    
    [constraints addObject:[self cg_autoDimension:CGDimensionWidth fixedLength:viewSize.width]];
    [constraints addObject:[self cg_autoDimension:CGDimensionHeight fixedLength:viewSize.height]];
    
    return constraints;
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *constraint  = nil;
    
    if (self.isUpdateAddConstraint) {
        constraint  = [self cg_updateConstraintWithAtt1:(NSLayoutAttribute)dimension relatedBy:relation toItem:nil att2:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fixedLength commonSuperview:self];
    }
    
    if (!constraint) {
        
        constraint  = [self cg_createDimension:dimension fixedLength:fixedLength relation:relation];
        [self addConstraint:constraint];
    }
    
    return constraint;
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)view
{
    return [self cg_autoDimension:dimension view:view relatedBy:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoDimensionEqualView:(UIView *)view
{
    NSMutableArray *array   = [NSMutableArray arrayWithCapacity:2];
    [array addObject:[self cg_autoDimension:CGDimensionWidth equalView:view]];
    [array addObject:[self cg_autoDimension:CGDimensionHeight equalView:view]];
    return array;
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation
{
    return [self cg_attribute:(NSLayoutAttribute)dimension toItem:view relatedBy:relation constant:0];
}

- (NSLayoutConstraint *)cg_autoDimensionScale:(CGFloat)scale
{
    return [self cg_attribute:NSLayoutAttributeWidth
                    relatedBy:NSLayoutRelationEqual
                       toItem:self
                    attribute:NSLayoutAttributeHeight
                   multiplier:scale
                     constant:0];
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
    return [self cg_topLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation multiplier:1.0];
}

- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier
{
    UIView *commonSuperview  = [self cg_searchCommonSuperviewWithView:viewController.view];
    CGDebugAssert(commonSuperview, @"self视图父视图必须是viewController.view");
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *layoutConstraint    = nil;
    
    if (self.isUpdateAddConstraint) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide att2:NSLayoutAttributeBottom multiplier:multiplier constant:inset commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        layoutConstraint    = [self cg_createTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
        [viewController.view addConstraint:layoutConstraint];
    }
    
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
    return [self cg_bottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation multiplier:1.0];
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier
{
    UIView *commonSuperview = [self cg_searchCommonSuperviewWithView:viewController.view];
    CGDebugAssert(commonSuperview, @"self视图父视图必须是viewController.view");
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *layoutConstraint    = nil;
    
    if (self.isUpdateAddConstraint) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:NSLayoutAttributeBottom relatedBy:relation toItem:viewController.bottomLayoutGuide att2:NSLayoutAttributeTop multiplier:multiplier constant:inset commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [self cg_createBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
        [viewController.view addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

@end

@implementation UIView (CGAddConstraint)

- (void)cg_autoSetPriority:(UILayoutPriority)priority forConstraints:(nonnull CGSetupConstraintsForChangePriority)constraints
{
    self.layoutPriorityForConstraint    = priority;
    if (constraints) {
        constraints(self);
    }
    self.layoutPriorityForConstraint    = UILayoutPriorityRequired;
}

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
    return [self cg_attribute:attribute relatedBy:relation toItem:view2 attribute:attribute multiplier:1.0 constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_attribute:attribute toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 constant:c];
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
    
    NSLayoutConstraint *layoutConstraint    = nil;
    
    if (self.isUpdateAddConstraint) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:attr1 relatedBy:relation toItem:view2 att2:attr2 multiplier:multiplier constant:c commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [self cg_createAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
        [commonSuperview addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

@end

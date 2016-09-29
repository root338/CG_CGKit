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

#import "NSLayoutConstraint+CGConstraint.h"

#import "CGPrintLogHeader.h"

/** 存储约束优先级的数组 */
static NSMutableArray<NSNumber *> *cg_constraintsLayoutPriority;
static NSMutableArray<NSNumber *> *cg_constraintsLayoutIsUpdate;

@interface UIView (CGSetupGlobalConstraintsPriority)

+ (NSMutableArray<NSNumber *> *)cg_constraintsLayoutPriority;

+ (CGFloat)cg_currentConstraintsLayoutPriority;

+ (BOOL)cg_isExecutingPriorityConstraintsBlock;

+ (NSMutableArray<NSNumber *> *)cg_constraintsLayoutIsUpdate;

+ (BOOL)cg_currentConstraintsLayoutIsUpdate;

+ (BOOL)cg_isExecutingConstraintsLayoutIsUpdate;
@end

@implementation UIView (CGSetupGlobalConstraintsPriority)

+ (NSMutableArray<NSNumber *> *)cg_constraintsLayoutPriority
{
    if (!cg_constraintsLayoutPriority) {
        cg_constraintsLayoutPriority    = [NSMutableArray array];
    }
    return cg_constraintsLayoutPriority;
}

+ (CGFloat)cg_currentConstraintsLayoutPriority
{
    NSMutableArray *globalConstraintsPriority   = [self cg_constraintsLayoutPriority];
    if (globalConstraintsPriority.count == 0) {
        return UILayoutPriorityRequired;
    }
    
    return [[globalConstraintsPriority lastObject] floatValue];
}

+ (BOOL)cg_isExecutingPriorityConstraintsBlock
{
    return [[self cg_constraintsLayoutPriority] count] > 0;
}

+ (NSMutableArray<NSNumber *> *)cg_constraintsLayoutIsUpdate
{
    if (!cg_constraintsLayoutIsUpdate) {
        cg_constraintsLayoutIsUpdate    = [NSMutableArray array];
    }
    return cg_constraintsLayoutIsUpdate;
}

+ (BOOL)cg_currentConstraintsLayoutIsUpdate
{
    NSMutableArray *globalConstraintsIsUpdate   = [self cg_constraintsLayoutIsUpdate];
    if (globalConstraintsIsUpdate.count == 0) {
        return NO;
    }
    return [[globalConstraintsIsUpdate lastObject] boolValue];
}

+ (BOOL)cg_isExecutingConstraintsLayoutIsUpdate
{
    return [[self cg_constraintsLayoutIsUpdate] count] > 0;
}

@end

@interface UIView (CGViewCategoryPrivateMethod)

/** 通过不包含的边值，获取包含的边值 */
- (CGLayoutOptionEdge)getNeedOptionEdgeWithExcludingOptionEdge:(CGLayoutOptionEdge)edge;

@end

@implementation UIView (CGViewCategoryPrivateMethod)

/** 通过不包含的边值，获取包含的边值 */
- (CGLayoutOptionEdge)getNeedOptionEdgeWithExcludingOptionEdge:(CGLayoutOptionEdge)edge
{
    CGLayoutOptionEdge optionEdge   = CGLayoutOptionEdgeAll;
    if (edge & CGLayoutOptionEdgeLeft || edge & CGLayoutOptionEdgeLeading) {
        optionEdge -= CGLayoutOptionEdgeLeading;
    }
    
    if (edge & CGLayoutOptionEdgeTop) {
        optionEdge -= CGLayoutOptionEdgeTop;
    }
    
    if (edge & CGLayoutOptionEdgeRight || edge & CGLayoutOptionEdgeTrailing) {
        optionEdge -= CGLayoutOptionEdgeTrailing;
    }
    
    if (edge & CGLayoutOptionEdgeBottom) {
        optionEdge -= CGLayoutOptionEdgeBottom;
    }
    
    return optionEdge;
}

@end

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

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets edge:(CGLayoutOptionEdge)edge
{
    return [self cg_autoEdgesToViewController:viewController withInsets:insets edge:edge relation:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets edge:(CGLayoutOptionEdge)edge relation:(NSLayoutRelation)relation
{
    NSMutableArray *constraints   = [NSMutableArray array];
    
    if (edge & CGLayoutOptionEdgeTop) {
        [constraints addObject:[self cg_topLayoutGuideOfViewController:viewController withInset:insets.top relatedBy:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeLeft || edge & CGLayoutOptionEdgeLeading) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left relation:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeBottom) {
        [constraints addObject:[self cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom relatedBy:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeRight || edge & CGLayoutOptionEdgeTrailing) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right relation:relation]];
    }
    
    return constraints;
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

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperviewExcludingEdge:(CGLayoutEdge)layoutEdge
{
    return [self cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:layoutEdge];
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

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingOptionEdge:(CGLayoutOptionEdge)edge
{
    CGLayoutOptionEdge optionEdge = [self getNeedOptionEdgeWithExcludingOptionEdge:edge];
    
    return [self cg_autoEdgesToSuperviewEdgesWithEdge:optionEdge insets:insets];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperviewEdgesWithEdge:(CGLayoutOptionEdge)edge
{
    return [self cg_autoEdgesToSuperviewEdgesWithEdge:edge insets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithEdge:(CGLayoutOptionEdge)edge insets:(UIEdgeInsets)insets
{
    return [self cg_autoEdgesToSuperviewEdgesWithEdge:edge insets:insets relation:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithEdge:(CGLayoutOptionEdge)edge insets:(UIEdgeInsets)insets relation:(NSLayoutRelation)relation
{
    NSMutableArray *constraints   = [NSMutableArray array];
    
    if (edge & CGLayoutOptionEdgeTop) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top relation:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeLeft || edge & CGLayoutOptionEdgeLeading) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left relation:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeBottom) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom relation:relation]];
    }
    
    if (edge & CGLayoutOptionEdgeRight || edge & CGLayoutOptionEdgeTrailing) {
        [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right relation:relation]];
    }
    
    return constraints;
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
    
    UILayoutPriority layoutPriority = [UIView cg_currentConstraintsLayoutPriority];
    if ([UIView cg_currentConstraintsLayoutIsUpdate]) {
        constraint  = [self cg_updateConstraintWithAtt1:(NSLayoutAttribute)dimension relatedBy:relation toItem:nil att2:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fixedLength layoutPriority:layoutPriority commonSuperview:self];
    }
    
    if (!constraint) {
        
        constraint  = [self cg_createDimension:dimension fixedLength:fixedLength relation:relation];
        [constraint setupLayoutPriority:layoutPriority];
        [self addConstraint:constraint];
    }
    
    return constraint;
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)view
{
    return [self cg_autoDimension:dimension view:view relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)view scale:(CGFloat)scale
{
    NSLayoutAttribute att = (NSLayoutAttribute)dimension;
    return [self cg_attribute:att relatedBy:NSLayoutRelationEqual toItem:view attribute:att multiplier:scale constant:0];
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
    
    UILayoutPriority layoutPriority = [UIView cg_currentConstraintsLayoutPriority];
    if ([UIView cg_currentConstraintsLayoutIsUpdate]) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide att2:NSLayoutAttributeBottom multiplier:multiplier constant:inset layoutPriority:layoutPriority commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        layoutConstraint    = [self cg_createTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
        [layoutConstraint setupLayoutPriority:layoutPriority];
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
    
    UILayoutPriority layoutPriority = [UIView cg_currentConstraintsLayoutPriority];
    if ([UIView cg_currentConstraintsLayoutIsUpdate]) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:NSLayoutAttributeBottom relatedBy:relation toItem:viewController.bottomLayoutGuide att2:NSLayoutAttributeTop multiplier:multiplier constant:inset layoutPriority:layoutPriority commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [self cg_createBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
        [layoutConstraint setupLayoutPriority:layoutPriority];
        [viewController.view addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

@end

@implementation UIView (CGAddConstraintForInverse)

- (CGLayoutEdge)inverseAttribute:(CGLayoutEdge)attribute
{
    CGLayoutEdge layoutEdge;
    switch (attribute) {
        case CGLayoutEdgeTop:
            layoutEdge  = CGLayoutEdgeBottom;
            break;
        case CGLayoutEdgeLeft:
        case CGLayoutEdgeLeading:
            layoutEdge  = CGLayoutEdgeTrailing;
            break;
        case CGLayoutEdgeBottom:
            layoutEdge  = CGLayoutEdgeTop;
            break;
        case CGLayoutEdgeTrailing:
        case CGLayoutEdgeRight:
            layoutEdge  = CGLayoutEdgeLeading;
            break;
        default:
            layoutEdge  = CGLayoutEdgeTop;
            break;
    }
    return layoutEdge;
}

- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2
{
    return [self cg_autoInverseAttribute:attribute toItem:view2 constant:0];
}

- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 constant:(CGFloat)c
{
    return [self cg_autoInverseAttribute:attribute toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation
{
    return [self cg_autoInverseAttribute:attribute toItem:view2 relatedBy:relation constant:0];
}

- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    return [self cg_attribute:(NSLayoutAttribute)attribute relatedBy:relation toItem:view2 attribute:(NSLayoutAttribute)[self inverseAttribute:attribute] constant:c];
}

@end

@implementation UIView (CGAddConstraint)

+ (void)cg_autoSetPriority:(UILayoutPriority)priority forConstraints:(nonnull CGSetupConstraints)constraints
{
    [[self cg_constraintsLayoutPriority] addObject:@(priority)];
    if (constraints) {
        constraints();
    }
    [[self cg_constraintsLayoutPriority] removeLastObject];
}

+ (void)cg_autoUpdateConstraints:(CGSetupConstraints)constraints
{
    [self cg_autoSetUpdate:YES forConstraints:constraints];
}

+ (void)cg_autoSetUpdate:(BOOL)updateConstraints forConstraints:(CGSetupConstraints)constraints
{
    [[self cg_constraintsLayoutIsUpdate] addObject:@(updateConstraints)];
    if (constraints) {
        constraints();
    }
    [[self cg_constraintsLayoutIsUpdate] removeLastObject];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2
{
    return [self cg_attribute:attribute toItem:view2 constant:0];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2
{
    return [self cg_autoAttributeOptionEqual:optionEdge toItem:view2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 constant:(CGFloat)c
{
    return [self cg_attribute:attribute toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2 constant:(CGFloat)c
{
    return [self cg_autoAttributeOptionEqual:optionEdge toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    return [self cg_attribute:attribute relatedBy:relation toItem:view2 attribute:attribute multiplier:1.0 constant:c];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (optionEdge & CGLayoutOptionEdgeTop) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeTop toItem:view2 relatedBy:relation constant:c]];
    }
    if (optionEdge & CGLayoutOptionEdgeLeading || optionEdge & CGLayoutOptionEdgeLeft) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeLeading toItem:view2 relatedBy:relation constant:c]];
    }
    if (optionEdge & CGLayoutOptionEdgeBottom) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeBottom toItem:view2 relatedBy:relation constant:c]];
    }
    if (optionEdge & CGLayoutOptionEdgeTrailing || optionEdge & CGLayoutOptionEdgeRight) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:view2 relatedBy:relation constant:c]];
    }
    
    return constraints;
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
    
    UILayoutPriority layoutPriority = [UIView cg_currentConstraintsLayoutPriority];
    if ([UIView cg_currentConstraintsLayoutIsUpdate]) {
        
        layoutConstraint    = [self cg_updateConstraintWithAtt1:attr1 relatedBy:relation toItem:view2 att2:attr2 multiplier:multiplier constant:c layoutPriority:layoutPriority commonSuperview:commonSuperview];
    }
    
    if (!layoutConstraint) {
        
        layoutConstraint    = [self cg_createAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
        [layoutConstraint setupLayoutPriority:layoutPriority];
        [commonSuperview addConstraint:layoutConstraint];
    }
    
    return layoutConstraint;
}

@end

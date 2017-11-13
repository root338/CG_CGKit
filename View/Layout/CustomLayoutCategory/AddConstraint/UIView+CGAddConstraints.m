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
#import "CGLayoutTypeTransform.h"

/** 存储约束优先级的数组 */
static NSMutableArray<NSNumber *> *cg_constraintsLayoutPriority;
static NSMutableArray<NSNumber *> *cg_constraintsLayoutIsUpdate;

@interface UIView (_CGConstantProperty)

@property (nonatomic, assign, readonly) CGFloat cg_defalutConstantProperty;
@property (nonatomic, assign, readonly) CGFloat cg_defalutMultiplierProperty;
@property (nonatomic, assign, readonly) UIEdgeInsets cg_defalutInsetsProperty;
@property (nonatomic, readonly, readonly) NSLayoutRelation cg_defalutLayoutRelationProperty;

@end

@implementation UIView (_CGConstantProperty)

@dynamic cg_defalutConstantProperty;
@dynamic cg_defalutMultiplierProperty;
@dynamic cg_defalutInsetsProperty;
@dynamic cg_defalutLayoutRelationProperty;

- (CGFloat)cg_defalutConstantProperty
{
    return 0.0;
}

- (CGFloat)cg_defalutMultiplierProperty
{
    return 1.0;
}

- (NSLayoutRelation)cg_defalutLayoutRelationProperty
{
    return NSLayoutRelationEqual;
}

- (UIEdgeInsets)cg_defalutInsetsProperty
{
    return UIEdgeInsetsZero;
}

@end

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
    return [self cg_autoEdgeEqualWithViews:views layoutAttribute:layoutAttribute relation:NSLayoutRelationEqual constant:0];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgeEqualWithViews:(NSArray<UIView *> *)views layoutAttribute:(NSLayoutAttribute)layoutAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:views.count];
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[self cg_attribute:layoutAttribute toItem:obj relatedBy:relation constant:constant]];
    }];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgeWithView:(UIView *)view optionEdge:(CGLayoutOptionEdge)optionEdge insets:(UIEdgeInsets)insets
{
    return [self cg_autoEdgeWithView:view optionEdge:optionEdge insets:insets relation:NSLayoutRelationEqual];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgeWithView:(UIView *)view optionEdge:(CGLayoutOptionEdge)optionEdge insets:(UIEdgeInsets)insets relation:(NSLayoutRelation)relation
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    if (optionEdge & CGLayoutOptionEdgeTop) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeTop toItem:view relatedBy:relation constant:insets.top]];
    }
    
    if (optionEdge & CGLayoutOptionEdgeLeft || optionEdge & CGLayoutOptionEdgeLeading) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeLeading toItem:view relatedBy:relation constant:insets.left]];
    }
    
    if (optionEdge & CGLayoutOptionEdgeBottom) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeBottom toItem:view relatedBy:relation constant:insets.bottom]];
    }
    
    if (optionEdge & CGLayoutOptionEdgeRight || optionEdge & CGLayoutOptionEdgeTrailing) {
        [constraints addObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:view relatedBy:relation constant:insets.right]];
    }
    
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

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperviewExcludingEdge:(CGLayoutEdge)excludingLayoutEdge optionEdge:(CGLayoutEdge)optionEdge
{
    return [self cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:excludingLayoutEdge optionEdge:optionEdge];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    return [[self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets] allValues];
}

- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    return [self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets excludingEdge:CGLayoutEdgeNone];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperviewOptionEdge:(CGLayoutEdge)optionEdge
{
    return [self cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero optionEdge:optionEdge];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets optionEdge:(CGLayoutEdge)optionEdge
{
    
    return [self cg_autoEdgesToSuperviewEdgesWithInsets:insets excludingEdge:CGLayoutEdgeNone optionEdge:optionEdge];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge
{
    return [[self cg_d_autoEdgesToSuperviewEdgesWithInsets:insets excludingEdge:edge] allValues];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)excludingEdge optionEdge:(CGLayoutEdge)optionEdge
{
    CGFloat offset = [CGLayoutTypeTransform offsetWithInsets:insets edge:optionEdge];
    
    NSLayoutAttribute optionAttribute = [CGLayoutTypeTransform layoutAttributeWithEdge:optionEdge];
    
    CGLayoutOptionEdge layoutOptionEdge = CGLayoutOptionEdgeNone;
    if (CGLayoutEdgeTop != optionEdge && CGLayoutEdgeTop != excludingEdge) {
        layoutOptionEdge |= CGLayoutOptionEdgeTop;
    }
    if ((CGLayoutEdgeLeading != optionEdge && CGLayoutEdgeLeading != excludingEdge) || (CGLayoutEdgeLeft != optionEdge && CGLayoutEdgeLeft != excludingEdge)) {
        layoutOptionEdge |= CGLayoutOptionEdgeLeading;
    }
    if ((CGLayoutEdgeTrailing != optionEdge && CGLayoutEdgeTrailing != excludingEdge) && (CGLayoutEdgeRight != optionEdge && CGLayoutEdgeRight != excludingEdge)) {
        layoutOptionEdge |= CGLayoutOptionEdgeTrailing;
    }
    
    if (CGLayoutEdgeBottom != optionEdge && CGLayoutEdgeBottom != excludingEdge) {
        layoutOptionEdge |= CGLayoutOptionEdgeBottom;
    }
    
    NSMutableArray *constraints = [NSMutableArray arrayWithArray:[self cg_autoEdgesToSuperviewEdgesWithEdge:layoutOptionEdge insets:insets]];
    if (optionEdge != CGLayoutEdgeNone && excludingEdge != optionEdge) {
        [UIView cg_autoSetPriority:999 forConstraints:^{
            [constraints addObject:[self cg_autoConstrainToSuperviewAttribute:optionAttribute withOffset:offset]];
        }];
    }
    
    return constraints;
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

//@implementation UIView (CGSuperviewToSubviewsConstraints)
//
//- (NSArray<NSLayoutConstraint *> *)cg_autoConstraintsToSuperviewLayoutGuideAxis:(CGLayoutGuideAxis)layoutGuideAxis subviews:(NSArray<UIView *> *)subviews
//{
//    UILayoutGuide *layoutGuide = [[UILayoutGuide alloc] init];
//    
//}
//
//@end

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
    if (self.translatesAutoresizingMaskIntoConstraints != NO) {
        self.translatesAutoresizingMaskIntoConstraints  = NO;
    }
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

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension view:(UIView *)view constant:(CGFloat)constant
{
    return [self cg_autoDimension:dimension view:view relatedBy:NSLayoutRelationEqual constant:constant];
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

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation constant:(CGFloat)constant
{
    return [self cg_attribute:(NSLayoutAttribute)dimension toItem:view relatedBy:relation constant:constant];
}

- (NSLayoutConstraint *)cg_autoDimensionWidthEqualHeight
{
    return [self cg_autoDimensionScale:1.0];
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
    if (self.translatesAutoresizingMaskIntoConstraints != NO) {
        self.translatesAutoresizingMaskIntoConstraints  = NO;
    }
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
    
    if (self.translatesAutoresizingMaskIntoConstraints != NO) {
        self.translatesAutoresizingMaskIntoConstraints  = NO;
    }
    
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
    
    if (self.translatesAutoresizingMaskIntoConstraints != NO) {
        self.translatesAutoresizingMaskIntoConstraints  = NO;
    }
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

@implementation UIView (CGEqualViewConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_constraintsWithEqualView:(UIView *)view
{
    NSMutableArray<NSLayoutConstraint *> *atts  = [NSMutableArray arrayWithCapacity:4];
    [atts addObject:[self cg_attribute:NSLayoutAttributeTop toItem:view]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeLeading toItem:view]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeBottom toItem:view]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeTrailing toItem:view]];
    return atts;
}

- (NSArray<NSLayoutConstraint *> *)cg_constraintsWithCenterIncludeView:(UIView *)view
{
    return [self cg_constraintsWithCenterIncludeView:view offset:CGPointZero insets:UIEdgeInsetsZero];
}

- (NSArray<NSLayoutConstraint *> *)cg_constraintsWithCenterIncludeView:(UIView *)view offset:(CGPoint)offset insets:(UIEdgeInsets)insets
{
    NSMutableArray *atts = [NSMutableArray arrayWithCapacity:6];
    
    [atts addObjectsFromArray:[self cg_autoCenterToSameAxisOfView:view withOffset:offset]];
    
    [atts addObject:[self cg_attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                toItem:view
                             attribute:NSLayoutAttributeTop
                              constant:insets.top]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeLeading
                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                toItem:view
                             attribute:NSLayoutAttributeLeading
                              constant:insets.left]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                toItem:view
                             attribute:NSLayoutAttributeBottom
                              constant:insets.bottom]];
    [atts addObject:[self cg_attribute:NSLayoutAttributeTrailing
                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                toItem:view
                             attribute:NSLayoutAttributeTrailing
                              constant:insets.right]];
    
    return atts;
}

@end

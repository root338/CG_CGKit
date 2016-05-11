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

#pragma mark - 添加多个约束

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

@implementation UIView (CGViewAxisConstraint)

- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView
{
    return [self cg_attribute:(NSLayoutAttribute)axis toItem:otherView];
}

- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self cg_attribute:(NSLayoutAttribute)axis toItem:otherView constant:offset];
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
    NSLayoutConstraint *constraint  = [self cg_createDimension:dimension fixedLength:fixedLength relation:relation];
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)view
{
    return [self cg_autoDimension:dimension view:view relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation
{
    return [self cg_attribute:(NSLayoutAttribute)dimension toItem:view relatedBy:relation constant:0];
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
    NSLayoutConstraint *layoutConstraint    = [self cg_createTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
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
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *layoutConstraint    = [self cg_createBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation];
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
        
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation    = NSLayoutRelationLessThanOrEqual;
        }else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
    }
    
    NSLayoutAttribute att2 = attribute;
    return [self cg_attribute:attribute relatedBy:relation toItem:view2 attribute:att2 multiplier:1.0 constant:c];
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
    
    NSLayoutConstraint *layoutConstraint    = [self cg_createAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    [commonSuperview addConstraint:layoutConstraint];
    
    return layoutConstraint;
}

@end




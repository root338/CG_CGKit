//
//  UIView+CGCreateConstraint.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGCreateConstraint.h"
#import "UIView+CGAddConstraintStatus.h"
#import "NSLayoutConstraint+CGConstraint.h"

@implementation UIView (CGCreateSuperviewConstranint)

- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute
{
    return [self cg_createConstrainToSuperviewAttribute:attribute withOffset:0 relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation
{
    return [self cg_createConstrainToSuperviewAttribute:attribute withOffset:0 relation:relation];
}

- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset
{
    return [self cg_createConstrainToSuperviewAttribute:attribute withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self cg_createAttribute:attribute toItem:self.superview relatedBy:relation constant:offset];
}

@end

@implementation UIView (CGCreateViewControllerConstraint)

- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_createTopLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_createTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    return [self cg_createTopLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation multiplier:1.0];
}

- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier
{
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:multiplier constant:inset];
    
    return layoutConstraint;
}

- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController
{
    return [self cg_createBottomLayoutGuideOfViewController:viewController withInset:0];
}

- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_createBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    return [self cg_createBottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:relation multiplier:1.0];
}

- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier
{
    inset   = -inset;
    if (NSLayoutRelationGreaterThanOrEqual == relation) {
        relation    = NSLayoutRelationLessThanOrEqual;
    }else if (NSLayoutRelationLessThanOrEqual == relation) {
        relation    = NSLayoutRelationGreaterThanOrEqual;
    }
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:multiplier constant:inset];
    
    return layoutConstraint;
}

@end

@implementation UIView (CGCreateViewAxisConstraint)

- (NSLayoutConstraint *)cg_createAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView
{
    return [self cg_createAttribute:(NSLayoutAttribute)axis toItem:otherView];
}

- (NSLayoutConstraint *)cg_createAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self cg_createAttribute:(NSLayoutAttribute)axis toItem:otherView constant:offset];
}

@end

@implementation UIView (CGCreateViewDimensionConstraint)

- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength
{
    return [self cg_createDimension:dimension fixedLength:fixedLength relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint  = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)dimension relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:fixedLength];
    
    return constraint;
}

- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension equalView:(UIView *)view
{
    return [self cg_createDimension:dimension view:view relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation
{
    return [self cg_createAttribute:(NSLayoutAttribute)dimension toItem:view relatedBy:relation constant:0];
}

@end

@implementation UIView (CGCreateConstraint)

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2
{
    return [self cg_createAttribute:attribute toItem:view2 constant:0];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 constant:(CGFloat)c
{
    return [self cg_createAttribute:attribute toItem:view2 relatedBy:NSLayoutRelationEqual constant:c];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c
{
    
    NSLayoutAttribute att2 = attribute;
    return [self cg_createAttribute:attribute relatedBy:relation toItem:view2 attribute:att2 multiplier:1.0 constant:c];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_createAttribute:attribute toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_createAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_createAttribute:attribute relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 constant:c];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_createAttribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
}

- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (attr1 == NSLayoutAttributeTrailing || attr1 == NSLayoutAttributeRight || attr1 == NSLayoutAttributeBottom) {
        c = -c;
        
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation    = NSLayoutRelationLessThanOrEqual;
        }else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
    }
    
    NSAssert(self.superview, @"请添加到父视图中再添加约束");
    
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    
    return layoutConstraint;
}

@end
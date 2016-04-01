//
//  UIView+CGAddConstraints.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGAddConstraints.h"

@implementation UIView (CGViewControllerConstraints)

- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_topLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    return [self cg_attribute:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide attribute:NSLayoutAttributeTop constant:inset];
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    return [self cg_bottomLayoutGuideOfViewController:viewController withInset:inset relatedBy:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation
{
    
    return [self cg_attribute:NSLayoutAttributeBottom relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:NSLayoutAttributeBottom constant:inset];
}

@end

@implementation UIView (CGAddConstraints)

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2
{
    return [self cg_attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 constant:0];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c
{
    return [self cg_attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
}

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    NSAssert(!self.translatesAutoresizingMaskIntoConstraints, @"translatesAutoresizingMaskIntoConstraints 必须是 NO");
    if ([view2 respondsToSelector:@selector(translatesAutoresizingMaskIntoConstraints)]) {
        NSAssert(![view2 translatesAutoresizingMaskIntoConstraints], @"translatesAutoresizingMaskIntoConstraints 必须是 NO");
    }
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    return layoutConstraint;
}

@end

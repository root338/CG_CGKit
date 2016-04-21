//
//  UIView+CGCreateConstraint.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGCreateConstraint.h"

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
    if (attribute == NSLayoutAttributeTrailing || attribute == NSLayoutAttributeRight || attribute == NSLayoutAttributeBottom) {
        c = -c;
        
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation    = NSLayoutRelationLessThanOrEqual;
        }else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
    }
    
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
    NSAssert(self.superview, @"请添加到父视图中再添加约束");
    
    NSLayoutConstraint *layoutConstraint    = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    
    return layoutConstraint;
}

@end
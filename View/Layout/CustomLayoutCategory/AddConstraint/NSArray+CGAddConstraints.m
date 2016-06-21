//
//  NSArray+CGAddConstraints.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/17.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSArray+CGAddConstraints.h"

#import "UIView+CGAddConstraints.h"

#import <objc/runtime.h>

@implementation NSArray (CGAddViewSubviewsConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayout
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeHorizontal marginInsets:UIEdgeInsetsZero setupSubviewsSpace:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayout
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeVertical marginInsets:UIEdgeInsetsZero setupSubviewsSpace:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeVertical marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeHorizontal marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoArrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:nil setupSubviewLayoutRelation:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation
{
    return [self cg_autoArrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:setupSubviewsLayoutRelation setupSubviewLayoutRelation:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation
{
    return [self cg_autoViewController:nil arrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:setupSubviewsLayoutRelation setupSubviewLayoutRelation:setupSubviewLayoutRelation];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoViewController:(UIViewController *)viewController arrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoViewController:viewController arrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:nil setupSubviewLayoutRelation:nil];
}

- (UIView *)previousViewWithObject:(UIView *)view
{
    NSInteger index = [self indexOfObject:view];
    if (index == 0) {
        return nil;
    }
    return [self objectAtIndex:index - 1];
}

- (UIView *)nextViewWithObject:(UIView *)view
{
    NSInteger index = [self indexOfObject:view];
    if (index < self.count - 1) {
        return [self objectAtIndex:index + 1];
    }
    return nil;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoViewController:(nullable UIViewController *)viewController arrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation
{
    
    CGSetupSubviewLayoutRelation viewForSuperviewLayoutRelation = ^(UIView *view, CGLayoutEdge layoutEdge) {
        
        if (setupSubviewLayoutRelation) {
            return setupSubviewLayoutRelation(view, layoutEdge);
        }
        return NSLayoutRelationEqual;
    };
    CGSetupSubviewsLayoutRelation subviewsLayoutRelation  = ^(UIView *view1, CGLayoutEdge view1LayoutEdge, UIView *view2, CGLayoutEdge view2LayoutEdge) {
        
        if (setupSubviewsLayoutRelation) {
            return setupSubviewsLayoutRelation(view1, view1LayoutEdge, view2, view2LayoutEdge);
        }
        return NSLayoutRelationEqual;
    };
    NSMutableArray *constraints = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *previousView    = [self previousViewWithObject:obj];
        UIView *nextView        = [self nextViewWithObject:obj];
        
        //添加必须的约束
        if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
            
            if (viewController) {
                
                
                [constraints addObject:[obj cg_topLayoutGuideOfViewController:viewController withInset:marginInsets.top relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                
                [constraints addObject:[obj cg_bottomLayoutGuideOfViewController:viewController withInset:marginInsets.bottom relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
            }else {
                
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:marginInsets.top relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:marginInsets.bottom relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
            }
            
        }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
            
            [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:marginInsets.left relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeLeading)]];
            [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:marginInsets.right relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTrailing)]];
        }
        
        if (previousView) {
            //存在上一视图
            CGFloat space = 0;
            if (setupSubviewsSpaceBlock) {
                space   = setupSubviewsSpaceBlock(previousView, obj);
            }else {
                space   = self.subviewsSpaceValue;
            }
            
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                [constraints addObject:[previousView cg_attribute:NSLayoutAttributeTrailing
                                                        relatedBy:subviewsLayoutRelation(previousView, CGLayoutEdgeTrailing, obj, CGLayoutEdgeLeading)
                                                           toItem:obj
                                                        attribute:NSLayoutAttributeLeading
                                                         constant:space]];
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                [constraints addObject:[previousView cg_attribute:NSLayoutAttributeBottom
                                                        relatedBy:subviewsLayoutRelation(previousView, CGLayoutEdgeBottom, obj, CGLayoutEdgeTop)
                                                           toItem:obj
                                                        attribute:NSLayoutAttributeTop
                                                         constant:space]];
            }
            
        }else {
            //不存在上一视图，说明是顶部视图
            
            //顶部视图
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:marginInsets.left relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeLeading)]];
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                if (viewController) {
                    
                    [constraints addObject:[obj cg_topLayoutGuideOfViewController:viewController withInset:marginInsets.top relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                }else {
                    
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:marginInsets.top relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                }
            }
        }
        
        if (!nextView) {
            //底部视图
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:marginInsets.right relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTrailing)]];
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                if (viewController) {
                    
                    [constraints addObject:[obj cg_bottomLayoutGuideOfViewController:viewController withInset:marginInsets.bottom relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                }else {
                    
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:marginInsets.bottom relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                }
                
            }
        }
    }];
    
    return constraints;
}

#pragma mark - 视图大小

- (NSArray<NSLayoutConstraint *> *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength
{
    NSMutableArray *constraints = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[obj cg_autoDimension:dimension fixedLength:fixedLength]];
    }];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)equalView
{
    NSMutableArray *constraints = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[obj cg_autoDimension:dimension equalView:equalView]];
    }];
    return constraints;
}

#pragma mark - 设置属性值

- (void)setSubviewsSpaceValue:(CGFloat)space
{
    objc_setAssociatedObject(self, @selector(subviewsSpaceValue), @(space), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)subviewsSpaceValue
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
@end

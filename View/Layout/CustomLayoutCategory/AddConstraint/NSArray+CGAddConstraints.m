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

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutWithViewController:(UIViewController *)viewController
{
    return [self cg_autoViewController:viewController
                       arrangementType:CGSubviewsArrangementTypeHorizontal
                          marginInsets:UIEdgeInsetsZero
                    setupSubviewsSpace:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutWithViewController:(UIViewController *)viewController
{
    return [self cg_autoViewController:viewController
                       arrangementType:CGSubviewsArrangementTypeVertical
                          marginInsets:UIEdgeInsetsZero
                    setupSubviewsSpace:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeVertical marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoArrangementType:CGSubviewsArrangementTypeHorizontal marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewLayoutExculdingEdge:(CGSetupSubviewExculdingEdge)setupSubviewExculdingEdge
{
    return [self cg_autoViewController:nil arrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:nil setupSubviewsLayoutRelation:nil setupSubviewLayoutRelation:nil setupSubviewExculdingEdge:setupSubviewExculdingEdge setupSubviewMarginEdgeInsets:nil];
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
    return [self cg_autoViewController:nil arrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:setupSubviewsLayoutRelation setupSubviewLayoutRelation:setupSubviewLayoutRelation setupSubviewExculdingEdge:nil setupSubviewMarginEdgeInsets:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation setupSubviewMarginEdgeInsets:(CGSetupSubViewMarginEdgeInsets)setupSubviewMarginEdgeInsets
{
    return [self cg_autoViewController:nil arrangementType:arrangementType marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:setupSubviewsLayoutRelation setupSubviewLayoutRelation:setupSubviewLayoutRelation setupSubviewExculdingEdge:nil setupSubviewMarginEdgeInsets:setupSubviewMarginEdgeInsets];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation setupSubviewExculdingEdge:(CGSetupSubviewExculdingEdge)setupSubviewExculdingEdge setupSubviewMarginEdgeInsets:(CGSetupSubViewMarginEdgeInsets)setupSubviewMarginEdgeInsets
{
    return [self cg_autoViewController:nil arrangementType:arrangementType marginInsets:UIEdgeInsetsZero setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:setupSubviewsLayoutRelation setupSubviewLayoutRelation:setupSubviewLayoutRelation setupSubviewExculdingEdge:setupSubviewExculdingEdge setupSubviewMarginEdgeInsets:setupSubviewMarginEdgeInsets];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoViewController:(UIViewController *)viewController arrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoViewController:viewController arrangementType:arrangementType marginInsets:marginInsets setupSubviewsSpace:setupSubviewsSpaceBlock setupSubviewsLayoutRelation:nil setupSubviewLayoutRelation:nil setupSubviewExculdingEdge:nil setupSubviewMarginEdgeInsets:nil];
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

- (NSArray<NSLayoutConstraint *> *)cg_autoViewController:(nullable UIViewController *)viewController arrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation setupSubviewExculdingEdge:(CGSetupSubviewExculdingEdge)setupSubviewExculdingEdge setupSubviewMarginEdgeInsets:(nullable CGSetupSubViewMarginEdgeInsets)setupSubviewMarginEdgeInsets
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
    CGSetupSubviewExculdingEdge viewForSuperviewExculdingEdgeBlock  = ^(UIView *view, CGLayoutEdge exculdingEdge) {
        
        BOOL isExculdingEdge = NO;
        if (setupSubviewExculdingEdge) {
            isExculdingEdge = setupSubviewExculdingEdge(view, exculdingEdge);
        }
        return isExculdingEdge;
    };
    CGSetupSubViewMarginEdgeInsets subviewMarginEdgeInsetsForSuperview  = ^(UIView *view) {
        UIEdgeInsets insets;
        if (setupSubviewMarginEdgeInsets) {
            insets  = setupSubviewMarginEdgeInsets(view);
        }else {
            insets  = marginInsets;
        }
        return insets;
    };
    
    NSMutableArray *constraints = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *previousView    = [self previousViewWithObject:obj];
        UIView *nextView        = [self nextViewWithObject:obj];
        
        UIEdgeInsets insets     = subviewMarginEdgeInsetsForSuperview(obj);
        //添加必须的约束
        if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
            
            BOOL isExculdingEdgeTop     = viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeTop);
            BOOL isExculdingEdgeBottom  = viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeBottom);
            
            if (viewController) {
                
                if (!isExculdingEdgeTop) {
                    
                    [constraints addObject:[obj cg_topLayoutGuideOfViewController:viewController withInset:insets.top relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                }
                
                if (!isExculdingEdgeBottom) {
                    [constraints addObject:[obj cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                }
                
            }else {
                
                if (!isExculdingEdgeTop) {
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                }
                if (!isExculdingEdgeBottom) {
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                }
            }
            
        }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
            
            if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeLeading)) {
                
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeLeading)]];
            }
            if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeTrailing)) {
                [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTrailing)]];
            }
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
                
                if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeLeading)) {
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeLeading withOffset:insets.left relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeLeading)]];
                }
                
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeTop)) {
                    if (viewController) {
                        
                        [constraints addObject:[obj cg_topLayoutGuideOfViewController:viewController withInset:insets.top relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                    }else {
                        
                        [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTop withOffset:insets.top relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTop)]];
                    }
                }
                
            }
        }
        
        if (!nextView) {
            //底部视图
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeTrailing)) {
                    [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeTrailing withOffset:insets.right relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeTrailing)]];
                }
                
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                if (!viewForSuperviewExculdingEdgeBlock(obj, CGLayoutEdgeBottom)) {
                    
                    if (viewController) {
                        
                        [constraints addObject:[obj cg_bottomLayoutGuideOfViewController:viewController withInset:insets.bottom relatedBy:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                    }else {
                        
                        [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom withOffset:insets.bottom relation:viewForSuperviewLayoutRelation(obj, CGLayoutEdgeBottom)]];
                    }
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

#pragma mark - 视图对齐
- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSuperviewWithAxis:(CGAxis)axis
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[obj cg_autoCenterToSuperviewWithAxis:axis]];
    }];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[obj cg_autoAxis:axis toSameAxisOfView:otherView]];
    }];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [constraints addObject:[obj cg_attribute:attribute toItem:view]];
    }];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:marginInsets
                                                                 setupSubviewsSpace:setupSubviewsSpaceBlock
                                                        setupSubviewsLayoutRelation:nil
                                                         setupSubviewLayoutRelation:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(nullable CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation
{
    return [self cg_autoSetupSubviewsLayoutAxisWithArrangementType:CGSubviewsArrangementTypeHorizontal
                                                      marginInsets:marginInsets
                                                setupSubviewsSpace:setupSubviewsSpaceBlock
                                       setupSubviewsLayoutRelation:setupSubviewsLayoutRelation
                                        setupSubviewLayoutRelation:setupSubviewLayoutRelation];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutAxisVerticalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock
{
    return [self cg_autoSetupVerticalSubviewsLayoutAxisVerticalWithMarginInsets:marginInsets
                                                             setupSubviewsSpace:setupSubviewsSpaceBlock
                                                    setupSubviewsLayoutRelation:nil
                                                     setupSubviewLayoutRelation:nil];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutAxisVerticalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation
{
    return [self cg_autoSetupSubviewsLayoutAxisWithArrangementType:CGSubviewsArrangementTypeVertical
                                                      marginInsets:marginInsets
                                                setupSubviewsSpace:setupSubviewsSpaceBlock
                                       setupSubviewsLayoutRelation:setupSubviewsLayoutRelation
                                        setupSubviewLayoutRelation:setupSubviewLayoutRelation];
}

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupSubviewsLayoutAxisWithArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(nullable CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation
{
    CGSetupSubviewSpace subviewsSpaceBlock  = ^(UIView *view1, UIView *view2) {
        
        CGFloat subviewsSpace;
        if (setupSubviewsSpaceBlock) {
            subviewsSpace   = setupSubviewsSpaceBlock(view1, view2);
        }else {
            subviewsSpace   = self.subviewsSpaceValue;
        }
        return subviewsSpace;
    };
    
    CGSetupSubviewLayoutRelation marginInsetsRelationBlock  = ^(UIView *view, CGLayoutEdge layoutEdge){
        
        if (setupSubviewLayoutRelation) {
            return setupSubviewLayoutRelation(view, layoutEdge);
        }else {
            return NSLayoutRelationEqual;
        }
    };
    
    CGSetupSubviewsLayoutRelation subviewsLayoutRelationBlock   = ^(UIView *view1, CGLayoutEdge view1LayoutEdge, UIView *view2, CGLayoutEdge view2LayoutEdge) {
        
        if (setupSubviewsLayoutRelation) {
            return setupSubviewsLayoutRelation(view1, view1LayoutEdge, view2, view2LayoutEdge);
        }else {
            return NSLayoutRelationEqual;
        }
    };
    
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            //第一个视图
            
            CGFloat             offset;
            NSLayoutAttribute   att;
            CGLayoutEdge        edge;
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                offset  = marginInsets.left;
                att     = NSLayoutAttributeLeading;
                edge    = CGLayoutEdgeLeading;
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                offset  = marginInsets.top;
                att     = NSLayoutAttributeTop;
                edge    = CGLayoutEdgeTop;
            }
            
            [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:att
                                                                  withOffset:offset
                                                                    relation:marginInsetsRelationBlock(obj, edge)]];
        }
        if (idx == self.count - 1) {
            //最后一个视图
            
            CGFloat             offset;
            NSLayoutAttribute   att;
            CGLayoutEdge        edge;
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
             
                offset  = marginInsets.right;
                att     = NSLayoutAttributeTrailing;
                edge    = CGLayoutEdgeTrailing;
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                offset  = marginInsets.bottom;
                att     = NSLayoutAttributeBottom;
                edge    = CGLayoutEdgeBottom;
            }
            
            [constraints addObject:[obj cg_autoConstrainToSuperviewAttribute:att
                                                                  withOffset:offset
                                                                    relation:marginInsetsRelationBlock(obj, edge)]];
        }
        
        if (idx + 1 < self.count) {
            
            NSLayoutAttribute att1, att2;
            CGLayoutEdge edge1, edge2;
            id item1, item2;
            
            item1   = obj;
            item2   = self[idx + 1];
            if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
                
                att1    = NSLayoutAttributeTrailing;
                att2    = NSLayoutAttributeLeading;
                
                edge1   = CGLayoutEdgeTrailing;
                edge2   = CGLayoutEdgeLeading;
            }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
                
                att1    = NSLayoutAttributeBottom;
                att2    = NSLayoutAttributeTop;
                
                edge1   = CGLayoutEdgeBottom;
                edge2   = CGLayoutEdgeTop;
            }
            
            //后面还有视图
            [constraints addObject:[obj cg_attribute:att1
                                           relatedBy:subviewsLayoutRelationBlock(item1, edge1, item2, edge2)
                                              toItem:item2
                                           attribute:att2
                                            constant:subviewsSpaceBlock(item1, item2)]];
        }
        
        if (arrangementType == CGSubviewsArrangementTypeHorizontal) {
            
            [constraints addObjectsFromArray:[obj cg_autoEdgesToSuperviewEdgesWithEdge:CGLayoutOptionEdgeVertical insets:marginInsets]];
        }else if (arrangementType == CGSubviewsArrangementTypeVertical) {
            
            [constraints addObjectsFromArray:[obj cg_autoEdgesToSuperviewEdgesWithEdge:CGLayoutOptionEdgeHorizontal insets:marginInsets]];
        }
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

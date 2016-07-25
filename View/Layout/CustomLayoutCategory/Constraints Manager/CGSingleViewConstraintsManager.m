////
////  CGSingleViewConstraintsManager.m
////  TestCG_CGKit
////
////  Created by apple on 16/7/24.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//#import "CGSingleViewConstraintsManager.h"
//
//#import "UIView+CGSearchView.h"
//#import "NSLayoutConstraint+CGConstraint.h"
//
//#import "CGPrintLogHeader.h"
//
//@interface CGSingleViewConstraintsManager ()
//
///**
// *  包含所有约束的集合
// */
//@property (nullable, nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *allRelatedConstraintsDictionary;
//
//@end
//
//@implementation CGSingleViewConstraintsManager
//
////- (NSLayoutConstraint *)cg_getConstraintsWithLayoutAttribute:(NSLayoutAttribute)att
////{
////    return [self.allRelatedConstraintsDictionary objectForKey:[self key:att]];
////}
//
//- (BOOL)setupDidAddToConstraint:(NSLayoutConstraint *)constraint
//{
//    NSLayoutAttribute targetLayoutAttribute;
//    if (constraint.firstItem == self.targetView) {
//        targetLayoutAttribute   = constraint.firstAttribute;
//    }else if (constraint.secondItem == self.targetView) {
//        targetLayoutAttribute   = constraint.secondAttribute;
//    }else {
//        CGDebugAssert(nil, @"添加的约束不是该视图相关约束");
//        return NO;
//    }
//    
//    [self setConstraint:constraint targetLayoutAttribute:targetLayoutAttribute];
//    
//    return YES;
//}
//
//- (void)setConstraint:(NSLayoutConstraint *)constraint targetLayoutAttribute:(NSLayoutAttribute)targetLayoutAttribute
//{
//    if (!self.allRelatedConstraintsDictionary) {
//        self.allRelatedConstraintsDictionary    = [NSMutableArray arrayWithObject:constraint];
//    }else {
//        
//        
//            if ([self.delegate respondsToSelector:@selector(constraintsManager:existedConstraint:newConstraint:)]) {
//                constraint = [self.delegate constraintsManager:self existedConstraint:value newConstraint:constraint];
//            }else {
//                
//                UIView *targetView  = [constraint cg_getDidAddLayoutConstraintView];
//                if (targetView) {
//                    [targetView removeConstraint:value];
//                }
//                
//            }
//    }
//}
//
//- (BOOL)removeConstraint:(NSLayoutConstraint *)constraint existingView:(UIView *)existingView
//{
//    return NO;
//}
//
//#pragma mark - 设置属性
//
//
//@end

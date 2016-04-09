//
//  NSLayoutConstraint+CGVerifyConstraint.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSearchConstraintTypeHeader.h"

@interface NSLayoutConstraint (CGVerifyConstraint)

/** 验证当前的约束与需要设置的约束是否相等 */
- (BOOL)cg_verifyWithItem:(id)view1 attribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 searchType:(CGSearchConstraintType *)searchType;

@end

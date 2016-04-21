//
//  NSLayoutConstraint+CGVerifyConstraint.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSLayoutConstraint+CGVerifyConstraint.h"

@implementation NSLayoutConstraint (CGVerifyConstraint)

- (BOOL)cg_verifyWithItem:(id)view1 attribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 searchType:(CGSearchConstraintType *)searchType
{
    CGSearchConstraintType type = CGSearchConstraintTypeUnknown;
    
    BOOL isResult   = [self cg_verifyWithItem:view1 attribute:att1 relatedBy:relation toItem:view2 attribute:attr2];
    if (!isResult) {
        
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation    = NSLayoutRelationLessThanOrEqual;
        }else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
        
        isResult    = [self cg_verifyWithItem:view2 attribute:attr2 relatedBy:relation toItem:view1 attribute:att1];
        if (isResult) {
            type    = CGSearchConstraintTypeReverse;
        }
    }else {
        type    = CGSearchConstraintTypeForward;
    }
    
    if (searchType) {
        *searchType = type;
    }
    
    return isResult;
}

- (BOOL)cg_verifyWithItem:(id)view1 attribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2
{
    BOOL isResult   = NO;
    if (self.firstItem == view1 && self.firstAttribute == att1) {
        //当设置的第一个视图与约束边值类型相同时
        if (view2) {
            //第二个视图是否为空
            if (self.secondItem == view2 && self.secondAttribute == attr2) {
                //当设置的第二个视图与约束边值类型相同时
                if (relation == self.relation) {
                    //当设置的约束类型相同时，为需要找的约束
                    isResult  = YES;
                }
            }
        }else {
            
            if (!self.secondItem && self.relation == relation) {
                //当没有第二个视图，且约束类型相同时
                isResult = YES;
            }
        }
    }
    return isResult;
}

@end

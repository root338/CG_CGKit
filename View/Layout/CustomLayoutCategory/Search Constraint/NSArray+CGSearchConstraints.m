//
//  NSArray+CGSearchConstraints.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSArray+CGSearchConstraints.h"

#import "NSLayoutConstraint+CGVerifyConstraint.h"

#import "CGPrintLogHeader.h"
@implementation NSArray (CGSearchConstraints)

- (NSLayoutConstraint *)cg_searchConstraintWithOptions:(NSEnumerationOptions)options item1:(nonnull id)item1 attribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nonnull id)item2 attribute:(NSLayoutAttribute)att2
{
    __block NSLayoutConstraint *layoutConstraint    = nil;
    [self enumerateObjectsWithOptions:options usingBlock:^(NSLayoutConstraint *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL isResult = [obj isKindOfClass:[NSLayoutConstraint class]];
        CGDebugAssert(isResult, @"数组中的对象必须为NSLayoutConstraint类型");
        
        if (isResult) {
            BOOL isSuccess  = [obj cg_verifyWithItem:item1 attribute:att1 relatedBy:relation toItem:item2 attribute:att2 searchType:nil];
            if (isSuccess) {
                layoutConstraint    = obj;
                *stop               = YES;
            }
        }
    }];
    
    return layoutConstraint;
}

@end

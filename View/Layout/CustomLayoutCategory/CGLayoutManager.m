//
//  CGLayoutManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGLayoutManager.h"

#import "UIView+CGSearchView.h"
#import "NSLayoutConstraint+CGConstraint.h"

#import "NSError+CGCreateError.h"

@interface CGLayoutManager ()

/** 
 *  包含所有约束的集合
 *  其中 key 为 @(NSLayoutAttribute) 数字对象类型，obj 为NSLayoutConstraint 类型
 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSNumber *, NSLayoutConstraint *> *constraints;

@end

@implementation CGLayoutManager

- (NSLayoutConstraint *)cg_getConstraintsWithLayoutAttribute:(NSLayoutAttribute)att
{
    return [self.constraints objectForKey:[self key:att]];
}

- (BOOL)setupDidAddToConstraint:(NSLayoutConstraint *)constraint error:(NSError *__autoreleasing  _Nullable *)error
{
    NSLayoutAttribute targetLayoutAttribute;
    if (constraint.firstItem == self.targetView) {
        targetLayoutAttribute   = constraint.firstAttribute;
    }else if (constraint.secondItem == self.targetView) {
        targetLayoutAttribute   = constraint.secondAttribute;
    }else {
        NSError *err = [NSError cg_createWithErrorMessage:@"添加的约束不是该视图相关约束"];
        *error  = err;
        return NO;
    }
    
    [self setConstraint:constraint targetLayoutAttribute:targetLayoutAttribute];
    
    return YES;
}

- (NSNumber *)key:(NSLayoutAttribute)type
{
    return @(type);
}

- (void)setConstraint:(NSLayoutConstraint *)constraint targetLayoutAttribute:(NSLayoutAttribute)targetLayoutAttribute
{
    NSNumber *key = [self key:targetLayoutAttribute];
    if (!self.constraints) {
        self.constraints    = [NSMutableDictionary dictionaryWithObject:constraint forKey:key];
    }else {
        
        NSLayoutConstraint * value = [self.constraints objectForKey:key];
        if (value) {
            if ([self.delegate respondsToSelector:@selector(layoutManager:existedConstraint:newConstraint:)]) {
                constraint = [self.delegate layoutManager:self existedConstraint:value newConstraint:constraint];
            }else {
                
                UIView *targetView  = [constraint cg_getDidAddLayoutConstraintView];
                if (targetView) {
                    [targetView removeConstraint:value];
                }
                
            }
        }
        [self.constraints setObject:constraint forKey:key];
    }
}

@end

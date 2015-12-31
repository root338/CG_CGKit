//
//  NSNotificationCenter+CGCreateNotification.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSNotificationCenter+CGCreateNotification.h"

@implementation NSNotificationCenter (CGCreateNotification)

#pragma mark - 添加通知
+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)aName
{
    [self addObserver:observer selector:selector name:aName object:nil];
}

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:aName object:anObject];
}

+ (void)addObserver:(id)observer selector:(SEL)selector names:(nonnull NSArray<NSString *> *)aNames object:(nonnull id)anObject
{
    [aNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addObserver:observer selector:selector name:obj object:anObject];
    }];
}

#pragma mark - 移除通知
+ (void)removeObserver:(id)observer name:(NSString *)aName
{
    [self removeObserver:observer name:aName object:nil];
}

+ (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:anObject];
}

+ (void)removeObserver:(id)observer names:(NSArray<NSString *> *)aNames object:(id)anObject
{
    [aNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserver:observer name:obj object:anObject];
    }];
}

@end

@implementation NSNotificationCenter (CGCreateKeyboardNotification)

+ (void)cg_addKeyboardObserver:(id)observer selector:(SEL)selector
{
    [NSNotificationCenter addObserver:observer selector:selector name:UIKeyboardWillShowNotification];
    [NSNotificationCenter addObserver:observer selector:selector name:UIKeyboardDidShowNotification];
    [NSNotificationCenter addObserver:observer selector:selector name:UIKeyboardWillHideNotification];
    [NSNotificationCenter addObserver:observer selector:selector name:UIKeyboardDidHideNotification];
}

+ (void)cg_removeKeyboardObserver:(id)observer
{
    [NSNotificationCenter removeObserver:observer name:UIKeyboardWillShowNotification];
    [NSNotificationCenter removeObserver:observer name:UIKeyboardDidShowNotification];
    [NSNotificationCenter removeObserver:observer name:UIKeyboardWillHideNotification];
    [NSNotificationCenter removeObserver:observer name:UIKeyboardDidHideNotification];
}

@end
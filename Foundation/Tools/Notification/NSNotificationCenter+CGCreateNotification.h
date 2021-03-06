//
//  NSNotificationCenter+CGCreateNotification.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSNotificationCenter (CGCreateNotification)

///添加通知的类方法

/** 添加通知 */
+ (void)addObserver:(id)observer selector:(SEL)selector name:(nullable NSString *)aName;

/** 添加通知，需要anObject */
+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)aName object:(nullable id)anObject;

/** 添加通知，同一个目标和方法，监听多个通知对象 */
+ (void)addObserver:(id)observer selector:(SEL)selector names:(NSArray<NSString *> *)aNames object:(nullable id)anObject;

///移除通知

/** 移除通知 */
+ (void)removeObserver:(id)observer name:(nullable NSString *)aName;

/** 移除通知，需要（anObject） */
+ (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;

/** 移除通知，同一个目标和方法，移除多个通知对象 */
+ (void)removeObserver:(id)observer names:(nullable NSArray<NSString *> *)aNames object:(nullable id)anObject;

@end

@interface NSNotificationCenter (CGCreateKeyboardNotification)

/** 
 *  添加UIKeyboardDidHideNotification， UIKeyboardDidShowNotification键盘通知
 */
+ (void)cg_addKeyboardObserver:(id)observer selector:(SEL)selector;
/** 移除UIKeyboardDidHideNotification， UIKeyboardDidShowNotification键盘通知 */
+ (void)cg_removeKeyboardObserver:(id)observer;

/** 添加UIKeyboardWillHideNotification, UIKeyboardWillShowNotification键盘通知 */
+ (void)cg_addWillKeyboardObserver:(id)observer selector:(SEL)selector;
/** 移除UIKeyboardWillHideNotification, UIKeyboardWillShowNotification键盘通知 */
+ (void)cg_removeWillKeyboardObserver:(id)observer;

/** 添加UIKeyboardWillChangeFrameNotification键盘通知 */
+ (void)cg_addKeyboardWillChangeFrameObserver:(id)observer selector:(SEL)selector;
/** 移除UIKeyboardWillChangeFrameNotification键盘通知 */
+ (void)cg_removeKeyboardWillChangeFrameObserver:(id)observer;
@end

NS_ASSUME_NONNULL_END
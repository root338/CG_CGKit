//
//  CGKeyboardManager.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGKeyboardManager.h"

#import "NSNotification+CGKeyboardUserInfo.h"
#import "NSNotificationCenter+CGCreateNotification.h"


#import "UIView+CGSearchView.h"

@implementation CGKeyboardManager

#pragma mark - 键盘通知处理
- (void)handleKeyboardShowHideNotification:(NSNotification *)note
{
    BOOL isDealWith     = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:shouldDealWithNotification:)]) {
        isDealWith      = [self.delegate keyboardManager:self shouldDealWithNotification:note];
    }
    
    if (!isDealWith) {
        return;
    }
    
    NSString *noteName  = note.name;
    if ([noteName isEqualToString:UIKeyboardWillShowNotification] || [noteName isEqualToString:UIKeyboardDidShowNotification]) {
        
        BOOL didShowDealWith    = YES;
        if ([self.delegate respondsToSelector:@selector(keyboardManager:showKeyboardNotification:)]) {
            [self.delegate keyboardManager:self showKeyboardNotification:note];
            
            if ([self.delegate respondsToSelector:@selector(keyboardManager:didShowKeyboardDealWithNotification:)]) {
                didShowDealWith = [self.delegate keyboardManager:self didShowKeyboardDealWithNotification:note];
            }else {
                didShowDealWith = self.didShowKeyboardContinueDealWithNotification;
            }
        }
        
        if (!didShowDealWith) {
            return;
        }
        
    }else if ([noteName isEqualToString:UIKeyboardWillHideNotification] || [noteName isEqualToString:UIKeyboardDidHideNotification]) {
        
        BOOL didHideDealWith    = YES;
        if ([self.delegate respondsToSelector:@selector(keyboardManager:hideKeyboardNotification:)]) {
            
            [self.delegate keyboardManager:self hideKeyboardNotification:note];
            
            if ([self.delegate respondsToSelector:@selector(keyboardManager:didHideKeyboardDealWithNotification:)]) {
                didHideDealWith = [self.delegate keyboardManager:self didHideKeyboardDealWithNotification:note];
            }else {
                didHideDealWith = self.didHideKeyboardContinueDealWithNotification;
            }
        }
        
        if (!didHideDealWith) {
            return;
        }
    }
    
    CGRect keyboardRect = note.keyboardFrame;
    
    CGRect keyboardFrameDidChangeNeedChangeViewFrame;
    if ([self.delegate respondsToSelector:@selector(targetViewFrameWithKeyboardManager:keyboardRect:)]) {
        keyboardFrameDidChangeNeedChangeViewFrame   = [self.delegate targetViewFrameWithKeyboardManager:self keyboardRect:keyboardRect];
    }
    
    NSTimeInterval duration;
    if (self.duration < 0.0001) {
        duration    = note.keyboardDuration;
    }else {
        duration    = self.duration;
    }
    
    NSUInteger curve    = note.keyboardCurve;
    
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:animationsNotification:)]) {
            [self.delegate keyboardManager:self animationsNotification:note];
        }
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:animationCompletionNotification:)]) {
            [self.delegate keyboardManager:self animationCompletionNotification:note];
        }
    }];
}

- (CGKeyboardNotificationType)typeForNotificationName:(NSString *)name
{
    CGKeyboardNotificationType notificationType = 0;
    if ([name isEqualToString:UIKeyboardWillShowNotification]) {
        notificationType    = CGKeyboardNotificationTypeWillShow;
    }else if ([name isEqualToString:UIKeyboardDidShowNotification]) {
        notificationType    = CGKeyboardNotificationTypeDidShow;
    }else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
        notificationType    = CGKeyboardNotificationTypeWillHide;
    }else if ([name isEqualToString:UIKeyboardDidHideNotification]) {
        notificationType    = CGKeyboardNotificationTypeDidHide;
    }
    return notificationType;
}

#pragma mark - 设置键盘通知
- (void)addKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(nonnull id)target selector:(nonnull SEL)selector object:(nullable id)object
{
    [NSNotificationCenter addObserver:target selector:selector names:keyboardNotificationNameArray object:object];
}

- (void)removeKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(id)target object:(id)object
{
    [NSNotificationCenter removeObserver:target names:keyboardNotificationNameArray object:object];
}

#pragma mark - 设置属性
- (void)setOpenKeyboardWillNotification:(BOOL)openKeyboardWillNotification
{
    if (_openKeyboardWillNotification != openKeyboardWillNotification) {
        
        _openKeyboardWillNotification   = openKeyboardWillNotification;
        [NSNotificationCenter cg_addWillKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
    }
}

- (void)setOpenKeyboardDidNotification:(BOOL)openKeyboardDidNotification
{
    if (_openKeyboardDidNotification != openKeyboardDidNotification) {
        
        _openKeyboardDidNotification    = openKeyboardDidNotification;
        [NSNotificationCenter cg_addKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

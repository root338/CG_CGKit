/*!
    RFKeyboard
    RFUI

    Copyright (c) 2012-2014 BB9z
    https://github.com/RFUI/Core

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface RFKeyboard : NSObject
/**
 @abstract Converts a keyboardRect via a UIKeyboard notification to the view´s coordinate system.
 
 @param keyboardRect Keyboard frame rect, usually from an UIKeyboard notification´s userinfo[UIKeyboardFrameEndUserInfoKey].
 
 @return The converted keyboard frame rectangle in view ´s coordinate system. Must not be nil.
 */
+ (CGRect)convertKeyboardFrame:(CGRect)keyboardRect toView:(UIView *)view;

/**
 @abstract Check whether the keyboard is docked or not.
 
 @param keyboardRect Keyboard frame rect, usually from an UIKeyboard notification´s userinfo[UIKeyboardFrameEndUserInfoKey].
 
 @return `YES` if the keyboard is undocked, `NO` if the keyboard is dock at screen bottom.
 */
+ (BOOL)isUndocked:(CGRect)keyboardRect;

+ (CGFloat)keyboardLayoutHeightForNotification:(NSNotification *)note inView:(UIView *)view;

// experimental
+ (void)setEnableAutoDisimssKeyboardWhenTouch:(BOOL)enabled;

+ (instancetype)defaultManager;

/// Experimental, only called when AutoDisimssKeyboardWhenTouch
@property (copy, nonatomic) void (^keyboardShowCallback)(NSNotification *note);
@property (copy, nonatomic) void (^keyboardHideCallback)(NSNotification *note);
@end
NS_ASSUME_NONNULL_END
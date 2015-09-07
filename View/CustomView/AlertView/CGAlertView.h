//
//  YMAlertView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/14.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGAlertView : UIAlertView

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message resultCallback:(void (^)(BOOL isCancel))resultCallback;

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle resultCallback:(void (^)(BOOL isCancel))resultCallback;

+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message;

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;

+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;
@end

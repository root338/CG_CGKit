//
//  YMAlertView.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/14.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGAlertView.h"

@interface CGAlertView ()<UIAlertViewDelegate>
{
    
}

@property (copy, nonatomic) void (^resultCallback) (BOOL isCancel);

@end

@implementation CGAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 可选择提示，根据用户选择执行回调
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message resultCallback:(void (^)(BOOL))resultCallback
{
    return [self showAlertViewWithTitle:title
                                message:message
                            cancelTitle:@"取消"
                             otherTitle:@"确定"
                         resultCallback:resultCallback];
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle resultCallback:(void (^)(BOOL))resultCallback
{
    CGAlertView *alertView = [[CGAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:otherButtonTitle, nil];
    [alertView show];
    alertView.delegate = alertView;
    alertView.resultCallback = resultCallback;
    return alertView;
}

#pragma mark - 仅提示
+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message
{
    return [self showAlertViewWithNoteMessage:message cancelTitle:@"确定"];
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    CGAlertView *alertView = [self showAlertViewWithTitle:title
                                                  message:message
                                              cancelTitle:@"确定"
                                               otherTitle:nil
                                           resultCallback:nil];
    return alertView;
}

+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    return [self showAlertViewWithTitle:@"通知"
                                message:message
                            cancelTitle:cancelTitle
                             otherTitle:nil
                         resultCallback:nil];
}

#pragma mark - 仅提示，无标题
+ (instancetype)showAlertViewWithOnlyMessage:(NSString *)message
{
    return [self showAlertViewWithOnlyMessage:message cancelTitle:@"确定"];
}

+ (instancetype)showAlertViewWithOnlyMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    return [self showAlertViewWithTitle:nil
                                message:message
                            cancelTitle:cancelTitle
                             otherTitle:nil
                         resultCallback:nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.resultCallback) {
        
        self.resultCallback(buttonIndex == alertView.cancelButtonIndex);
    }
    
}

@end

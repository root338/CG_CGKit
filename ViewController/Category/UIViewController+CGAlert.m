//
//  UIViewController+CGAlert.m
//  TestCG_CGKit
//
//  Created by apple on 16/6/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGAlert.h"

#import "CGAlertView.h"
#import "CGAlertController.h"

#import "CGVerifyIOSVersionHeader.h"

@implementation UIViewController (CGAlert)

- (UIAlertController *)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message textInputsCount:(NSInteger)textInputsCount setupTextField:(void (^)(UITextField * _Nonnull, NSInteger))setupTextField cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherButtonTitles resultCallback:(void (^)(UIAlertAction * _Nonnull))resultCallback
{
    CGAlertController *alertController = [CGAlertController createAlertControllerWithTitle:title message:message textInputsCount:textInputsCount setupTextField:setupTextField cancelTitle:cancelTitle otherTitles:otherButtonTitles resultCallback:resultCallback];
    [self presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

- (id)showAlertViewWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    return [self showAlertViewWithTitle:nil
                                message:message
                            cancelTitle:cancelTitle
                             otherTitle:nil
                         resultCallback:nil];
}

- (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle resultCallback:(void (^)(BOOL))resultCallback
{
    
    id targetView   = nil;
    
    if (_CG_IOS_8_0_BEFORE) {
        
        targetView  = [CGAlertView showAlertViewWithTitle:title message:message cancelTitle:cancelTitle otherTitle:otherButtonTitle resultCallback:resultCallback];
    }else {
        
        UIAlertController *alertController = [CGAlertController createAlertControllerWithTitle:title message:message cancelTitle:cancelTitle otherTitle:otherButtonTitle resultCallback:resultCallback];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return targetView;
}

- (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message otherTitle1:(NSString *)otherTitle1 otherTitle2:(NSString *)otherTitle2 resultCallback:(void (^)(NSInteger))resultCallback
{
    id targetView = nil;
    if (_CG_IOS_8_0_BEFORE) {
        targetView  = [CGAlertView showAlertViewWithTitle:title message:message otherTitle1:otherTitle1 otherTitle2:otherTitle2 resultCallback:resultCallback];
    }else {
        
        UIAlertController *alertController = [CGAlertController createAlertControllerWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:nil otherTitles:[NSArray arrayWithObjects:otherTitle1, otherTitle2, nil] resultCallback:^(UIAlertAction * _Nonnull alertAction) {
            
            NSInteger index = 0;
            if ([alertAction.title isEqualToString:otherTitle2]) {
                index = 1;
            }
            
            if (resultCallback) {
                resultCallback(index);
            }
        }];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return targetView;
}

@end

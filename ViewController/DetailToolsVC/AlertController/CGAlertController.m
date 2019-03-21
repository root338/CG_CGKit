//
//  CGAlertController.m
//  TestCG_CGKit
//
//  Created by apple on 16/6/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAlertController.h"

@implementation CGAlertController

+ (instancetype)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message
{
    return [self createAlertControllerWithTitle:title
                                        message:message
                                    cancelTitle:@"确定"];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    return [self createAlertControllerWithTitle:title
                                        message:message
                                    cancelTitle:cancelTitle
                                     otherTitle:nil
                                 resultCallback:nil];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle resultCallback:(void ( ^)(BOOL))resultCallback
{
    return [self createAlertControllerWithTitle:title message:message cancelTitle:cancelTitle otherTitle:otherButtonTitle otherTitleActionStyle:UIAlertActionStyleDefault resultCallback:resultCallback];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle otherTitleActionStyle:(UIAlertActionStyle)otherTitleActionStyle resultCallback:(void ( ^)(BOOL))resultCallback
{
    if (!cancelTitle && !otherButtonTitle) {
        return nil;
    }
    CGAlertController *alertController  = [CGAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (resultCallback) {
                resultCallback(YES);
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    if (otherButtonTitle) {
        
        UIAlertAction *otherAction  = [UIAlertAction actionWithTitle:otherButtonTitle style:otherTitleActionStyle handler:^(UIAlertAction * _Nonnull action) {
            if (resultCallback) {
                resultCallback(NO);
            }
        }];
        [alertController addAction:otherAction];
    }
    
    return alertController;
}

+ (instancetype)createAlertControllerWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherButtonTitles resultCallback:(void ( ^ _Nullable)(UIAlertAction * _Nonnull))resultCallback
{
    return [self createAlertControllerWithPreferredStyle:preferredStyle title:title message:message textInputsCount:0 setupTextField:nil cancelTitle:cancelTitle otherTitles:otherButtonTitles resultCallback:^(UIAlertAction * _Nonnull action, NSArray<UITextField *> * _Nullable textFields) {
        !resultCallback?: resultCallback(action);
    }];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title message:(NSString *)message textInputsCount:(NSInteger)textInputsCount setupTextField:(void (^)(UITextField * _Nonnull, NSInteger))setupTextField cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherButtonTitles resultCallback:(void ( ^)(UIAlertAction * _Nonnull, NSArray<UITextField *> * _Nullable))resultCallback
{
    return [self createAlertControllerWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message textInputsCount:textInputsCount setupTextField:setupTextField cancelTitle:cancelTitle otherTitles:otherButtonTitles resultCallback:resultCallback];
}

+ (instancetype)createAlertControllerWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message textInputsCount:(NSInteger)textInputsCount setupTextField:(void (^ _Nullable)(UITextField * _Nonnull, NSInteger))setupTextField cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherButtonTitles resultCallback:(void ( ^)(UIAlertAction * _Nonnull, NSArray<UITextField *> * _Nullable))resultCallback
{
    CGAlertController *alertController  = [CGAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if (preferredStyle == UIAlertControllerStyleAlert && textInputsCount > 0) {
        
        void (^setupTextFieldBlock) (UITextField *, NSInteger) = ^(UITextField *textField, NSInteger index){
            if (setupTextField) {
                setupTextField(textField, index);
            }
        };
        
        for (NSInteger i = 0; i < textInputsCount; i++) {
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                setupTextFieldBlock(textField, i);
            }];
        }
    }
    
    if (cancelTitle) {
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            !resultCallback?: resultCallback(action, alertController.textFields);
        }];
        [alertController addAction:cancelAction];
    }
    
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action   = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !resultCallback?: resultCallback(action, alertController.textFields);
        }];
        [alertController addAction:action];
    }];
    
    return alertController;
}

@end

//
//  CGTextFieldDelegateManager.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTextFieldDelegateManager.h"

#import "NSString+VerificationString.h"
#import "NSNotificationCenter+CGCreateNotification.h"

@implementation CGTextFieldTextVeriftyObject

@end

@implementation CGTextFieldDelegateManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _minInputCount  = 0;
        _maxInputCount  = 0;
    }
    return self;
}

#pragma mark - Notification
- (void)openTextFieldTextDidChangeNotification
{
    [NSNotificationCenter addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification];
}

- (void)closeTextFieldTextDidChangeNotification
{
    [NSNotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification];
}

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)note
{
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isResult       = NO;
    
    NSString *inputText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    isResult            = [self verityInputString:inputText];
    
    return isResult;
}

#pragma mark - 字符串判断

- (BOOL)verityInputString:(NSString *)inputString
{
    return inputString != nil ? YES : NO;
}

- (void)dealloc
{
    [self closeTextFieldTextDidChangeNotification];
}
@end

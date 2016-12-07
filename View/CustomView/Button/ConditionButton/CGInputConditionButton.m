//
//  CGInputConditionButton.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGInputConditionButton.h"

#import "NSString+CGString.h"

#import "NSNotificationCenter+CGCreateNotification.h"

@interface CGInputConditionButton ()
{
    
}

@end

@implementation CGInputConditionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _disableRemoveWhitespaceAndNewlineCharacterSet = NO;
    }
    return self;
}

- (void)handleInputControlsTextDidChangeNotification:(NSNotification *)note
{
    if (!note.object || ![self.inputControls containsObject:note.object]) {
        return;
    }
    
    [self handleTextDidChangeWithObject:note.object];
}

- (void)updateVerifyAllInputControl
{
    __block BOOL enable = NO;
    [self.inputControls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        enable  = [self handleTextDidChangeWithObject:obj];
        if (enable == NO) {
            *stop   = YES;
        }
    }];
    
    self.enabled    = enable;
}

- (BOOL)updateVerifyWithTargetInputControl:(id)inputControl
{
    return [self handleTextDidChangeWithObject:inputControl];
}

- (BOOL)handleTextDidChangeWithObject:(id)object
{
    __block BOOL isFlag = NO;
    
    NSString *inputText = [self inputTextWithTargetInputControl:object];
    if (self.inputControlDidTextChangeCallback) {
        
        isFlag  = self.inputControlDidTextChangeCallback(object, inputText);
    }else {
        
        isFlag  = inputText.length != 0;
    }
    
    return isFlag;
}

- (NSString *)inputTextWithTargetInputControl:(id)inputControl
{
    NSString *inputText = nil;
    if ([inputControl isKindOfClass:[UITextField class]]) {
        inputText   = [(UITextField *)inputText text];
    }
    if ([inputControl isKindOfClass:[UITextView class]]) {
        inputText   = [(UITextView *)inputText text];
    }
    
    if (!self.disableRemoveWhitespaceAndNewlineCharacterSet) {
        inputText   = [inputText cg_stringIgnoreWhitespaceAndNewlineCharacterSet];
    }
    return inputText;
}

#pragma mark - 设置属性
- (void)setIsOpenTextFieldDidChangeNotification:(BOOL)isOpenTextFieldDidChangeNotification
{
    if (_isOpenTextFieldDidChangeNotification != isOpenTextFieldDidChangeNotification) {
        
        NSString *noteName  = UITextFieldTextDidChangeNotification;
        if (isOpenTextFieldDidChangeNotification) {
            
            [NSNotificationCenter addObserver:self selector:@selector(handleInputControlsTextDidChangeNotification:) name:noteName];
        }else {
            
            [NSNotificationCenter removeObserver:self name:noteName];
        }
        
        _isOpenTextFieldDidChangeNotification   = isOpenTextFieldDidChangeNotification;
    }
}

- (void)setIsOpenTextViewDidChangeNotification:(BOOL)isOpenTextViewDidChangeNotification
{
    if (_isOpenTextViewDidChangeNotification != isOpenTextViewDidChangeNotification) {
        
        NSString *noteName  = UITextViewTextDidChangeNotification;
        if (isOpenTextViewDidChangeNotification) {
            
            [NSNotificationCenter addObserver:self selector:@selector(handleInputControlsTextDidChangeNotification:) name:noteName];
        }else {
            
            [NSNotificationCenter removeObserver:self name:noteName];
        }
        _isOpenTextViewDidChangeNotification    = isOpenTextViewDidChangeNotification;
    }
}

- (void)setInputControls:(NSArray *)inputControls
{
    if (_inputControls != inputControls) {
        
        _inputControls  = inputControls;
        [self handleTextDidChangeWithObject:nil];
    }
}

- (void)dealloc
{
    self.isOpenTextViewDidChangeNotification    = NO;
    self.isOpenTextFieldDidChangeNotification   = NO;
}
@end

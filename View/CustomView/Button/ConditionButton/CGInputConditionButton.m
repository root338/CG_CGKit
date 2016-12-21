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
    BOOL didAutoChangeButtonStatusToWindows;
}

@end

@implementation CGInputConditionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _disableRemoveWhitespaceAndNewlineCharacterSet  = NO;
        _disableDidChangeTextRunLoopAllInputControls    = NO;
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        if (didAutoChangeButtonStatusToWindows == NO) {
            
            [self updateVerifyAllInputControl];
            didAutoChangeButtonStatusToWindows  = YES;
        }
    }
}

- (void)handleInputControlsTextDidChangeNotification:(NSNotification *)note
{
    if (!note.object || ![self.inputControls containsObject:note.object]) {
        return;
    }
    
    BOOL enable = NO;
    if (self.textDidChangeCallback) {
        
        enable  = self.textDidChangeCallback(note.object);
    }else {
        
        enable  = [self handleTextDidChangeWithObject:note.object];
        if (self.disableDidChangeTextRunLoopAllInputControls == NO && enable) {
            
            NSMutableArray *inputControls   = [NSMutableArray arrayWithArray:self.inputControls];
            [inputControls removeObject:note.object];
            enable  = [self updateVerifyButtonStatusWithInputControls:inputControls];
        }
    }
    
    self.enabled    = enable;
}

- (void)updateVerifyAllInputControl
{
    BOOL enable = [self updateVerifyButtonStatusWithInputControls:self.inputControls];
    self.enabled    = enable;
}

- (BOOL)updateVerifyButtonStatusWithInputControls:(NSArray *)inputControls
{
    __block BOOL enable = NO;
    [inputControls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        enable  = [self handleTextDidChangeWithObject:obj];
        if (enable == NO) {
            *stop   = YES;
        }
    }];
    
    return enable;
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

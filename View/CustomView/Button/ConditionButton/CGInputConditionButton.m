//
//  CGInputConditionButton.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGInputConditionButton.h"
#import "NSNotificationCenter+CGCreateNotification.h"

@interface CGInputConditionButton ()
{
    
}

@end

@implementation CGInputConditionButton

- (void)handleInputControlsTextDidChangeNotification:(NSNotification *)note
{
    if (!note.object || ![self.inputControls containsObject:note.object]) {
        return;
    }
    
    [self handleTextDidChangeWithObject:note.object];
}

- (void)handleTextDidChangeWithObject:(id)object
{
    __block BOOL isFlag = NO;
    if (self.textDidChangeCallback) {
        
        isFlag  = self.textDidChangeCallback(object);
    }else {
        
        [self.inputControls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *inputText = nil;
            if ([obj isKindOfClass:[UITextField class]]) {
                inputText   = [(UITextField *)obj text];
            }
            if ([obj isKindOfClass:[UITextView class]]) {
                inputText   = [(UITextView *)obj text];
            }
            
            if (!inputText.length) {
                
                isFlag = NO;
                *stop = YES;
            }else {
                isFlag = YES;
            }
        }];
    }
    
    self.enabled = isFlag;
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

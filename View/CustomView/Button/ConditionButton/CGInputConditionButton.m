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

@property (nonatomic, assign) BOOL isOpenTextFieldDidChangeNotification;
@property (nonatomic, assign) BOOL isOpenTextViewDidChangeNotification;

@end

@implementation CGInputConditionButton

- (void)cg_setupInputChangeNotificationWithIsOpenNote:(BOOL)isOpenNote
{
    if (isOpenNote == self.isOpenTextViewDidChangeNotification && isOpenNote == self.isOpenTextFieldDidChangeNotification) {
        //当已设置过后直接返回
        return;
    }
    if (self.inputControls.count) {
        
        __block BOOL isFlagForTextField = NO;
        __block BOOL isFlagForTextView  = NO;
        [self.inputControls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[UITextField class]]) {
                self.isOpenTextFieldDidChangeNotification = isOpenNote;
                isFlagForTextField = YES;
            }
            if ([obj isKindOfClass:[UITextView class]]) {
                self.isOpenTextViewDidChangeNotification = isOpenNote;
                isFlagForTextView = YES;
            }
            
            if (isFlagForTextView && isFlagForTextField) {
                *stop = YES;
            }
        }];
    }
}

- (void)handleInputControlsTextDidChangeNotification:(NSNotification *)note
{
    __block BOOL isFlag = NO;
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
    
    self.enabled = isFlag;
}

#pragma mark - 重写系统方法
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    BOOL isOpenNote = newWindow ? YES : NO;
    [self cg_setupInputChangeNotificationWithIsOpenNote:isOpenNote];
}

#pragma mark - 设置属性
- (void)setIsOpenTextFieldDidChangeNotification:(BOOL)isOpenTextFieldDidChangeNotification
{
    if (_isOpenTextFieldDidChangeNotification != isOpenTextFieldDidChangeNotification) {
        
        if (isOpenTextFieldDidChangeNotification) {
            
            [NSNotificationCenter addObserver:self selector:@selector(handleInputControlsTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification];
        }else {
            
            [NSNotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification];
        }
        
    }
}

- (void)setIsOpenTextViewDidChangeNotification:(BOOL)isOpenTextViewDidChangeNotification
{
    if (_isOpenTextViewDidChangeNotification != isOpenTextViewDidChangeNotification) {
        
        if (isOpenTextViewDidChangeNotification) {
            
            [NSNotificationCenter addObserver:self selector:@selector(handleInputControlsTextDidChangeNotification:) name:UITextViewTextDidChangeNotification];
        }else {
            
            [NSNotificationCenter removeObserver:self name:UITextViewTextDidChangeNotification];
        }
    }
}

- (void)setInputControls:(NSArray *)inputControls
{
    _inputControls = inputControls;
    if (self.window) {
        [self cg_setupInputChangeNotificationWithIsOpenNote:YES];
    }
}
@end

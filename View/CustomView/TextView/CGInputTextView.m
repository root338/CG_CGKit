//
//  CGInputTextView.m
//  TestProject
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGInputTextView.h"
#import "NSObject+KeyboardNotification.h"

#import "UIView+CGSearchView.h"
#import "UIEdgeInsets+Category.h"

#import "CGBlockdDefinitionHeader.h"

#import "CGPrintLogHeader.h"


@interface CGInputTextView ()
{
    CGInputTextViewNoteType _handleNotificationFailureType;
    CGInputTextViewScrollFailureType _scrollFailureType;
    
    /** 输入字符不大于最大字数 */
    BOOL _isInputTextNotMoreThanMaxWords;
}

@end

@implementation CGInputTextView

- (void)initialization
{
    [super initialization];
    
    _isAutoHandleKeyboardNotification   = YES;
    _isAutoScrollingSuperView           = YES;
    _isAnmiationContentOffset           = NO;
    _priorityScrollSuperView            = NO;
    self.delegate                       = self;
}

#pragma mark - 键盘、滑动事件
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if ([self.cg_delegate respondsToSelector:@selector(cg_textView:willMoveToWindows:)]) {
        [self.cg_delegate cg_textView:self willMoveToWindows:newWindow];
    }
    if (self.isAutoHandleKeyboardNotification) {
        if (newWindow) {
            [self openKeyboardShowHideNotificationWithSelector:@selector(handleKeyboardNotification:)];
            
        }else {
            [self closeKeyboardShowHideNotificationWithSelector:@selector(handleKeyboardNotification:)];
        }
    }
}

- (void)handleNotificationFailureType:(CGInputTextViewNoteType)noteFailureType note:(NSNotification *)note
{
    if ([self.cg_delegate respondsToSelector:@selector(cg_textView:handleKeyboardNotification:noteFailureType:)]) {
        [self.cg_delegate cg_textView:self handleKeyboardNotification:note noteFailureType:noteFailureType];
    }
}

/** 滑动父视图，错误时回调failureBlock */
- (BOOL)scrollSuperViewContentWithMinNeedContentOffsetY:(CGFloat)minNeedContentOffsetY failureBlock:(cg_voidCallback)failureBlock
{
    UIScrollView *scrollView = [self searchSuperViewWithClass:[UIScrollView class]];
    _scrollFailureType = CGInputTextViewScrollFailureTypeNone;
    if (scrollView) {
        
        if (scrollView.contentSize.height >= minNeedContentOffsetY + self.contentOffset.y) {
            
            CGPoint contentOffset = scrollView.contentOffset;
            contentOffset.y += minNeedContentOffsetY;
            [scrollView setContentOffset:contentOffset animated:self.isAnmiationContentOffset];
        }else {
            
            _scrollFailureType = CGInputTextViewScrollFailureTypeContentSizeLessThanNeedMinScrollValue;
        }
        
    }else {
        
        _scrollFailureType = CGInputTextViewScrollFailureTypeNotScrollView;
        CGErrorConditionLog(failureBlock, @"没有可滑动的父视图");
    }
    
    if (_scrollFailureType != CGInputTextViewScrollFailureTypeNone) {
        
        _handleNotificationFailureType = CGInputTextViewNoteTypeAutoScrollSuperViewFailure;
        
        if (failureBlock) {
            failureBlock();
        }
    }
    
    return _scrollFailureType == CGInputTextViewScrollFailureTypeNone;
}

- (void)handleKeyboardNotification:(NSNotification *)note
{
    BOOL isShouldAutoHandleNote = YES;
    _handleNotificationFailureType = CGInputTextViewNoteTypeNone;
    
    if ([self.cg_delegate respondsToSelector:@selector(cg_textView:shouldAutoHandleKeyboardNotification:)]) {
        isShouldAutoHandleNote = [self.cg_delegate cg_textView:self shouldAutoHandleKeyboardNotification:note];
    }
    
    if (!isShouldAutoHandleNote) {
        //不自动处理
        _handleNotificationFailureType = CGInputTextViewNoteTypeDisableAutoHandleNotification;
        [self handleNotificationFailureType:_handleNotificationFailureType note:note];
        return;
    }
    
    if (!self.superview) {
      
        _handleNotificationFailureType = CGInputTextViewNoteTypeNotSuperView;
        [self handleNotificationFailureType:_handleNotificationFailureType note:note];
        CGErrorLog(@"没有父视图!!!");
        return;
    }
    
    if ([note.name isEqualToString:UIKeyboardWillHideNotification]) {
        
        if (_handleNotificationFailureType != CGInputTextViewNoteTypeNone) {
            //处理事件没有错误
            self.contentInset = UIEdgeInsetsZero;
        }else {
            [self handleNotificationFailureType:_handleNotificationFailureType note:note];
        }
        
        _handleNotificationFailureType  = CGInputTextViewNoteTypeNone;
        _scrollFailureType              = CGInputTextViewScrollFailureTypeNone;
        return;
    }
    
    CGRect keybaordFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keybaordFrame];
    
    CGRect frameToWindows = [self.superview convertRect:self.frame toView:nil];
    
    CGFloat keyboaradFrameMinY = CGRectGetMinY(keybaordFrame);
    
//    CGInfoLog(@"notification < name：%@, keyboardFrame：%@, self < frame：%@, to Windows Frame: %@ >", note.name, NSStringFromCGRect(keybaordFrame), NSStringFromCGRect(self.frame), NSStringFromCGRect(frameToWindows));
    
    //输入文本框的区域与键盘区域是否重合
    if (CGRectGetMaxY(frameToWindows) > keyboaradFrameMinY) {
        
        /** 滑动视图最小需要滑动的高度 */
        CGFloat minNeedContentOffsetY = (CGRectGetMinY(frameToWindows) + self.minVisibleHeight) - keyboaradFrameMinY;
        
        //输入文本框的最低可视区域是否在键盘区域之上
        if (minNeedContentOffsetY > 0) {
            
            //当可视区域小于最小值时，判读是否可以移动父视图中的scrollView
            if (self.isAutoScrollingSuperView) {
                
                __weak __block typeof(self) weakself = self;
                [self scrollSuperViewContentWithMinNeedContentOffsetY:minNeedContentOffsetY failureBlock:^{
                    
//                    if ([self.cg_delegate respondsToSelector:@selector(cg_textView:notification:failureType:)]) {
//                    [self.cg_delegate cg_textView:self notification:note failureType:_scrollFailureType];
//                    }
                    [weakself handleNotificationFailureType:_handleNotificationFailureType note:note];
                }];
                
            }else {
                
                _handleNotificationFailureType = CGInputTextViewNoteTypeDisableAutoScrollSuperView;
                [self handleNotificationFailureType:_handleNotificationFailureType note:note];
                return;
            }
        }else {
            
            __weak __block typeof(self) weakself = self;
            cg_voidCallback setupContentInset = ^{
            
                weakself.contentInset = UIEdgeInsetsZeroMakeExcludeBottom(CGRectGetMaxY(frameToWindows) - keyboaradFrameMinY);
            };
            
            if (self.priorityScrollSuperView) {
                
                if (![self scrollSuperViewContentWithMinNeedContentOffsetY:minNeedContentOffsetY failureBlock:nil]) {
                    
                    setupContentInset();
                }
            }else {
                
                setupContentInset();
            }
        }
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)handleInputWords:(NSString *)inputWord
{
    _isInputTextNotMoreThanMaxWords = inputWord.length <= self.maxInputWords;
    if (!_isInputTextNotMoreThanMaxWords && [self.cg_delegate respondsToSelector:@selector(cg_textViewInputWordsMoreThanMaxInputWords:)]) {
        [self.cg_delegate cg_textViewInputWordsMoreThanMaxInputWords:self];
    }
    return _isInputTextNotMoreThanMaxWords;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([self.cg_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
//        return [self.cg_delegate textView:textView shouldChangeTextInRange:range replacementText:text];
//    }
    
    BOOL isShouldChangeText = YES;
    if (self.maxInputWords > 0 && !self.isEnableDidEndEditingHandleWordsLimit) {
        NSString *inputNewText = [textView.text stringByReplacingCharactersInRange:range withString:text];
        isShouldChangeText = [self handleInputWords:inputNewText];
    }
    
    return isShouldChangeText;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
//    if ([self.cg_delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
//        return [self.cg_delegate textViewShouldEndEditing:textView];
//    }
    
    BOOL isShouldEndEditing = YES;
    if (self.maxInputWords > 0 && self.isEnableDidEndEditingHandleWordsLimit) {
        isShouldEndEditing = [self handleInputWords:textView.text];
    }
    
    return isShouldEndEditing;
}


//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if ([self.cg_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
//        return [self.cg_delegate textViewShouldBeginEditing:textView];
//    }
//    return YES;
//}



- (void)dealloc
{
    CGInfoLog(@"已释放");
}

#pragma mark - 设置属性
- (CGFloat)minVisibleHeight
{
    if (_minVisibleHeight > 0) {
        return _minVisibleHeight;
    }
    
    _minVisibleHeight = self.minHeight;
    return _minVisibleHeight;
}

- (CGInputTextViewScrollFailureType)handleScrollFailureType
{
    return _scrollFailureType;
}

- (BOOL)isInputTextNotMoreThanMaxWords
{
    return [self handleInputWords:self.text];
}
@end

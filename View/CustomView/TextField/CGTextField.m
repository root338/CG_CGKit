//
//  CGTextField.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTextField.h"

#import "UIView+CG_CGAreaCalculate.h"

@interface CGTextField ()
{
    BOOL _didSetTextInputMarginEdgeInsets;
    BOOL _didSetLeftViewMarginEdgeInsets;
    BOOL _didSetRightViewMarginEdgeInsets;
}

@end

@implementation CGTextField

#pragma mark - override system method

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    return [self _handleTextRect:rect];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    return [self _handleTextRect:rect];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    if (CGRectGetWidth(rect) == 0 || !_didSetLeftViewMarginEdgeInsets) {
        return rect;
    }
    CGRect leftViewRect = CGRectMake(_leftViewMarginEdgeInsets.left, CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    leftViewRect.origin.y = _leftViewMarginEdgeInsets.top;
    leftViewRect.size.height = CG_CGHeightWithMaxHeight(CGRectGetHeight(bounds), _leftViewMarginEdgeInsets);
    return leftViewRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    if (CGRectGetWidth(rect) == 0 || !_didSetRightViewMarginEdgeInsets) {
        return rect;
    }
    CGRect viewRect = CGRectMake(0, CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    viewRect.origin.x = CG_CGWidthWithMaxWidth(CGRectGetWidth(bounds), _rightViewMarginEdgeInsets) - CGRectGetWidth(viewRect);
    viewRect.origin.y = _rightViewMarginEdgeInsets.top;
    viewRect.size.height = CG_CGHeightWithMaxHeight(CGRectGetHeight(bounds), _rightViewMarginEdgeInsets);
    return viewRect;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    BOOL isCan = [super canPerformAction:action withSender:sender];
    return !self.disableAllPerformActionMenu;
}

#pragma mark - Private
- (CGRect)_handleTextRect:(CGRect)rect {
    CGRect textRect = CG_CGFrameWithMaxFrame(rect, self.textInputMarginEdgeInsets);
    if (_didSetRightViewMarginEdgeInsets) {
        BOOL isShowLeftView = [self _verifyShowView:self.leftView mode:self.leftViewMode];
        if (isShowLeftView) {
            textRect.origin.x += _leftViewMarginEdgeInsets.right;
            textRect.size.width -= _leftViewMarginEdgeInsets.right;
        }
    }
    return textRect;
}

- (BOOL)_verifyShowView:(UIView *)view mode:(UITextFieldViewMode)viewMode {
    if (view == nil) {
        return NO;
    }
    BOOL result = NO;
    switch (viewMode) {
        case UITextFieldViewModeNever: return NO;
        case UITextFieldViewModeWhileEditing:
            result = self.isEditing;
            break;
        case UITextFieldViewModeUnlessEditing:
            result = !self.isEditing;
            break;
        case UITextFieldViewModeAlways: return YES;
    }
    return result;
}

#pragma mark - Getter & Setter
- (void)setTextInputMarginEdgeInsets:(UIEdgeInsets)textInputMarginEdgeInsets {
    _didSetLeftViewMarginEdgeInsets = YES;
    _textInputMarginEdgeInsets = textInputMarginEdgeInsets;
}

- (void)setLeftViewMarginEdgeInsets:(UIEdgeInsets)leftViewMarginEdgeInsets {
    _didSetLeftViewMarginEdgeInsets = YES;
    _leftViewMarginEdgeInsets = leftViewMarginEdgeInsets;
}

- (void)setRightViewMarginEdgeInsets:(UIEdgeInsets)rightViewMarginEdgeInsets {
    _didSetRightViewMarginEdgeInsets = YES;
    _rightViewMarginEdgeInsets = rightViewMarginEdgeInsets;
}

@end

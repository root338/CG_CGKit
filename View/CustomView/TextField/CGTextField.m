//
//  CGTextField.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTextField.h"

#import "UIView+CG_CGAreaCalculate.h"

@implementation CGTextField

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
    if (CGRectGetWidth(rect) == 0) {
        return rect;
    }
    CGRect leftViewRect = CGRectMake(_leftViewMarginEdgeInsets.left, CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    if (_leftViewMarginEdgeInsets.top || _rightViewMarginEdgeInsets.bottom) {
        leftViewRect.origin.y = _leftViewMarginEdgeInsets.top;
        leftViewRect.size.height = CG_CGHeightWithMaxHeight(CGRectGetHeight(bounds), _leftViewMarginEdgeInsets);
    }
    return leftViewRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    return rect;
}

- (CGRect)_handleTextRect:(CGRect)rect {
    CGRect textRect = CG_CGFrameWithMaxFrame(rect, self.textInputMarginEdgeInsets);
    if (_leftViewMarginEdgeInsets.right > 0) {
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

@end

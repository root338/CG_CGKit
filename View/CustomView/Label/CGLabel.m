//
//  CGLabel.m
//  QuickAskCommunity
//
//  Created by DY on 16/2/26.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGLabel.h"
#import "UIEdgeInsets+Category.h"
#import "UIView+CG_CGAreaCalculate.h"

@interface CGLabel () {
    UIEdgeInsets _textTotalMarginInsets;
}

@end

@implementation CGLabel

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    [self _updateTextMarginInsets];
}

- (CGSize)intrinsicContentSize {
    CGFloat width = CGRectGetWidth(self.frame);
    if (width <= 1) {
        width = CGRectGetWidth(UIScreen.mainScreen.bounds);
    }
    CGSize textSize = [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    return textSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.text.length == 0 || self.attributedText.string.length == 0) {
        return CGSizeZero;
    }
    CGSize textSize = [super sizeThatFits:size];
    textSize = CG_CGMaxSizeWidthSize(textSize, _textTotalMarginInsets);
    textSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return textSize;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textAvailableFrame = CG_CGFrameWithMaxFrame(bounds, _textTotalMarginInsets);
    CGRect textBounds = textAvailableFrame;
    textBounds.origin.x = 0;
    CGRect textRect = [super textRectForBounds:textBounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.x += _textTotalMarginInsets.left;
    switch (self.textVerticalAlignment) {
        case CGLabelTextVerticalAlignmentCenter:
            textRect.origin.y += (CGRectGetHeight(textAvailableFrame) - CGRectGetHeight(textRect)) / 2;
            break;
        case CGLabelTextVerticalAlignmentTop:
            textRect.origin.y = CGRectGetMinY(textAvailableFrame);
            break;
        case CGLabelTextVerticalAlignmentBottom:
            textRect.origin.y = CGRectGetMaxY(textAvailableFrame) - CGRectGetHeight(textRect);
            break;
        default:
            break;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:textRect];
}

#pragma mark - Private
- (void)_updateTextMarginInsets {
    if (@available(iOS 11.0, *)) {
        if (_isAddSafeAreaInsets) {
            _textTotalMarginInsets = CG_CGUIEdgeInsetsAdd(_textMarginEdgeInsets, self.safeAreaInsets);
        }else {
            _textTotalMarginInsets = _textMarginEdgeInsets;
        }
    }else {
        _textTotalMarginInsets = _textMarginEdgeInsets;
    }
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        [self invalidateIntrinsicContentSize];
    }else {
        [self setNeedsLayout];
    }
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    CGFloat width = CG_CGWidthWithMaxWidth(CGRectGetWidth(bounds), _textTotalMarginInsets);
    if (self.preferredMaxLayoutWidth != width) {
        self.preferredMaxLayoutWidth = width;
    }
}

- (void)setTextMarginEdgeInsets:(UIEdgeInsets)textMarginEdgeInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_textMarginEdgeInsets, textMarginEdgeInsets)) return;
    _textMarginEdgeInsets = textMarginEdgeInsets;
    [self _updateTextMarginInsets];
}

@end



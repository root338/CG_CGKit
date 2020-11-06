//
//  CGLabel.m
//  QuickAskCommunity
//
//  Created by DY on 16/2/26.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGLabel.h"
#import "UIView+CG_CGAreaCalculate.h"

@implementation CGLabel

- (CGSize)intrinsicContentSize {
    CGSize textSize = [self sizeThatFits:CGSizeMake(self.preferredMaxLayoutWidth, CGFLOAT_MAX)];
    return textSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.text.length == 0 || self.attributedText.string.length == 0) {
        return CGSizeZero;
    }
    CGSize availableSize = CG_CGSizeWidthMaxSize(size, _textMarginEdgeInsets);
    CGSize textSize = [super sizeThatFits:availableSize];
    CGSize resultSize = CG_CGMaxSizeWidthSize(textSize, _textMarginEdgeInsets);
    return resultSize;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textAvailableFrame = CG_CGFrameWithMaxFrame(bounds, _textMarginEdgeInsets);
    CGRect textRect = [super textRectForBounds:textAvailableFrame limitedToNumberOfLines:numberOfLines];
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

@end

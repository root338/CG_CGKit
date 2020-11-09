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
    CGFloat width = self.preferredMaxLayoutWidth;
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
    textSize = CG_CGMaxSizeWidthSize(textSize, _textMarginEdgeInsets);
    textSize = CGSizeMake(MIN(ceil(textSize.width), size.width), MIN(ceil(textSize.height), size.height));
    return textSize;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textAvailableFrame = CG_CGFrameWithMaxFrame(bounds, _textMarginEdgeInsets);
    CGRect textBounds = textAvailableFrame;
    textBounds.origin.x = 0;
    CGRect textRect = [super textRectForBounds:textBounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.x += _textMarginEdgeInsets.left;
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

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    CGFloat width = CGRectGetWidth(bounds);//CG_CGWidthWithMaxWidth(CGRectGetWidth(bounds), _textMarginEdgeInsets);
    if (self.preferredMaxLayoutWidth != width) {
        self.preferredMaxLayoutWidth = width;
    }
}

@end



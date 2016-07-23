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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect     = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    CGRect tempTextRect = textRect;
    switch (self.textVerticalAlignment) {
        case CGLabelTextVerticalAlignmentTop:
            textRect.origin.y   = self.textVerticalAlignmentOffsetLength;
            break;
        case CGLabelTextVerticalAlignmentBottom:
            textRect.origin.y   = CGRectGetHeight(bounds) - (CGRectGetHeight(textRect) + self.textVerticalAlignmentOffsetLength);
            break;
        default:
            break;
    }
    
    if (!CGRectContainsRect(bounds, textRect)) {
        return tempTextRect;
    }
    
    return textRect;
}


- (void)drawTextInRect:(CGRect)rect
{
    CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:textRect];
}

@end

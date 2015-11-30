//
//  UITextView+CGCalculateTextSize.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITextView+CGCalculateTextSize.h"

@implementation UITextView (CGCalculateTextSize)

- (CGSize)calculateLabelTextSize
{
    
    CGSize size = CGSizeZero;
    
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font,
                          };
    
    size = [self.text sizeWithAttributes:dic];
    
    return size;
}

- (CGRect)calculateMultilineLabelTextSizeWithMaxWidth:(CGFloat)maxWidth
{
    return [self calculateMultilineLabelTextSizeWithMaxSize:CGSizeMake(maxWidth, FLT_MAX)];
}

- (CGRect)calculateMultilineLabelTextSizeWithMaxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font,
                          };
    CGRect rect = [self.text boundingRectWithSize:maxSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dic
                                          context:nil];
    return rect;
}

- (CGSize)calculateLabelSizeWithTextRect:(CGRect)textRect
{
    CGSize labelSize = CGSizeMake(textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height);
    return labelSize;
}

- (CGSize)calculateLabelSizeWithMaxWidth:(CGFloat)maxWidth
{
    return [self calculateLabelSizeWithTextRect:[self calculateMultilineLabelTextSizeWithMaxWidth:maxWidth]];
}

@end

//
//  UILabel+CalculateTextSize.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/29.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UILabel+CalculateTextSize.h"

@implementation UILabel (CalculateTextSize)

- (CGSize)calculateLabelTextSize
{
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font,
                          };
    CGSize size = [self.text sizeWithAttributes:dic];
    
    return size;
}

@end

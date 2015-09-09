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
    
    CGSize size = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font,
                          };
    
    size = [self.text sizeWithAttributes:dic];
#else
    
    size = [self.text sizeWithFont:self.font];
#endif
    
    
    return size;
}

@end

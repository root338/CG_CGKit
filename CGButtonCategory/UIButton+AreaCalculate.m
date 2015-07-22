//
//  UIButton+AreaCalculate.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/22.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIButton+AreaCalculate.h"

@implementation UIButton (AreaCalculate)

- (CGSize)calculateButtonCurrentTitleSize
{
    CGSize size = CGSizeZero;
    
    if (self.currentAttributedTitle) {
        
        size = [self.currentAttributedTitle size];
    }else {
        
        size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    }
    
    return size;
}
@end

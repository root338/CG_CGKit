//
//  UIButton+UpdateLocate.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIButton+UpdateLocate.h"

@implementation UIButton (UpdateLocate)

- (void)buttonContentAligeHorizonalTitle_ImageForSpace:(CGFloat)paramSpace
{
//    CGRect bounds = self.bounds;
    
    CGFloat titleLabelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
    
//    bounds.size.width = titleLabelWidth + imageViewWidth + paramSpace;
//    self.bounds = bounds;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleLabelWidth, 0, -titleLabelWidth);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewWidth - paramSpace, 0, imageViewWidth);
}

@end

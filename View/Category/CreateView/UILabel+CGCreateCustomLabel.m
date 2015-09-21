//
//  UILabel+CreateLabel.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UILabel+CGCreateCustomLabel.h"

@implementation UILabel (CGCreateCustomLabel)

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    
    return label;
}

@end

//
//  UIFont+CGCreateFont.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIFont+CGCreateFont.h"

@implementation UIFont (CGCreateFont)

+ (UIFont *)cg_defaultFontWithSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)cg_defaultItalicFontWithSize:(CGFloat)size
{
    return [UIFont italicSystemFontOfSize:size];
}

+ (UIFont *)cg_defaultBoldFontWithSize:(CGFloat)size
{
    return [UIFont boldSystemFontOfSize:size];
}

@end

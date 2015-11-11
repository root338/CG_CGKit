//
//  UILabel+CGSetupAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UILabel+CGSetupAppearance.h"

@implementation UILabel (CGSetupAppearance)

- (void)setupDefaultBackgroundColor
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupDefaultTextAlignment
{
    self.textAlignment = NSTextAlignmentLeft;
}

- (void)setupAllDefaultProperty
{
    //默认属性
    [self setupDefaultBackgroundColor];
    [self setupDefaultTextAlignment];
}

- (void)setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    self.text       = text;
    self.font       = font;
    self.textColor  = textColor;
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    [self setupWithText:text font:font textColor:textColor];
    [self setupAllDefaultProperty];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    [self setupWithText:text font:font textColor:textColor];
    self.textAlignment = textAlignment;
    [self setupDefaultBackgroundColor];
}
@end

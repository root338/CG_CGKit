//
//  UILabel+CGSetupAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UILabel+CGSetupAppearance.h"

static UIColor *labelDefaultBackgroundColor;

@implementation UILabel (CGSetupAppearance)

- (UIColor *)defaultBackgroundColor
{
    if (labelDefaultBackgroundColor == nil) {
        labelDefaultBackgroundColor = [UIColor clearColor];
    }
    return labelDefaultBackgroundColor;
}

- (NSTextAlignment)defaultTextAlignment
{
    return NSTextAlignmentLeft;
}

- (void)cg_setupDefaultLabel
{
    self.backgroundColor    = [self defaultBackgroundColor];
    self.textAlignment      = [self defaultTextAlignment];
}

- (void)cg_setupWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    [self cg_setupWithText:nil font:font textColor:textColor];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    [self cg_setupWithText:text font:font textColor:textColor textAlignment:[self defaultTextAlignment] backgroundColor:nil];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    [self cg_setupWithText:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:nil];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    [self cg_setupWithFrame:CGRectZero text:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:backgroundColor];
}

- (void)cg_setupWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    self.text           = text;
    self.font           = font;
    self.textColor      = textColor;
    self.textAlignment  = textAlignment;
    self.frame          = frame;
    /** 当不设置背景色时，使用系统默认的背景色 */
    !backgroundColor ? nil : (self.backgroundColor = backgroundColor);
}
@end

@implementation NSArray (CGSetupLabelAppearance)

- (UIColor *)defaultBackgroundColor
{
    if (labelDefaultBackgroundColor == nil) {
        labelDefaultBackgroundColor = [UIColor clearColor];
    }
    return labelDefaultBackgroundColor;
}

- (NSTextAlignment)defaultTextAlignment
{
    return NSTextAlignmentLeft;
}

- (void)cg_setupWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    [self cg_setupWithText:nil font:font textColor:textColor];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    [self cg_setupWithText:text font:font textColor:textColor textAlignment:[self defaultTextAlignment]];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    [self cg_setupWithText:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:[self defaultBackgroundColor]];
}

- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    [self cg_setupWithFrame:CGRectZero text:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:backgroundColor];
}

- (void)cg_setupWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    [self enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            [obj cg_setupWithFrame:frame text:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:backgroundColor];
        }
    }];
}

@end

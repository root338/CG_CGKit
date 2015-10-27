//
//  UILabel+CreateLabel.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UILabel+CGCreateCustomLabel.h"
#import "UIView+CGSetupAppearance.h"

@implementation UILabel (CGCreateCustomLabel)

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    
    //默认属性
    label.backgroundColor   = [UIColor clearColor];
    label.textAlignment     = NSTextAlignmentLeft;
    
    return label;
}

+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor];
    
    label.frame = frame;
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor];
    [label cg_setupBorderWithCornerRadius:cornerRadius];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor];
    [label cg_setupBorderWithWidth:borderWidth color:borderColor];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor];
    [label cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:cornerRadius];
    
    return label;
}

+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLabelWithFrame:frame text:text font:font textColor:textColor textAlignment:textAlignment];
    [label cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:cornerRadius];
    
    return label;
}
@end

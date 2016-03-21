//
//  UILabel+CreateLabel.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UILabel+CGCreateCustomLabel.h"

#import "UILabel+CGSetupAppearance.h"

@implementation UILabel (CGCreateCustomLabel)

+ (instancetype)cg_createLabel
{
    return [[self alloc] init];
}

+ (instancetype)cg_createDefaultLabel
{
    UILabel *label = [self cg_createLabel];
    [label cg_setupDefaultLabel];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [self cg_createLabel];
    [label cg_setupWithText:text font:font textColor:textColor];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label  = [self cg_createLabel];
    [label cg_setupWithText:text font:font textColor:textColor textAlignment:textAlignment];
    return label;
}

+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self cg_createLabel];
    [label cg_setupWithFrame:frame text:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:nil];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor borderWidth:0 borderColor:nil cornerRadius:cornerRadius];
    
    return label;
}

+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UILabel *label = [self cg_createLabelWithText:text font:font textColor:textColor borderWidth:borderWidth borderColor:borderColor cornerRadius:0];
    
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

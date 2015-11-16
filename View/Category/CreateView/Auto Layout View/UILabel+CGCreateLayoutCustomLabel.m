//
//  UILabel+CGCreateLayoutCustomLabel.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UILabel+CGCreateLayoutCustomLabel.h"
#import "UIView+CreateAutoLayoutTypeView.h"

#import "UILabel+CGSetupAppearance.h"

@implementation UILabel (CGCreateLayoutCustomLabel)

/** 创建UILabel，设置（文本，字体，字体颜色） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [self newAutoLayoutView];
    [label cg_setupWithText:text font:font textColor:textColor];
    
    return label;
}

/** 创建UILabel，设置（文本，字体，字体颜色，圆角） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLayoutLabelWithText:text font:font textColor:textColor borderWidth:0 borderColor:nil cornerRadius:cornerRadius];
    
    return label;
}

/** 创建UILabel，设置（文本，字体，字体颜色，边框（颜色，宽度）） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UILabel *label = [self cg_createLayoutLabelWithText:text font:font textColor:textColor borderWidth:borderWidth borderColor:borderColor cornerRadius:0];
    return label;
}

/** 创建UILabel，设置（文本，字体，字体颜色，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLayoutLabelWithText:text font:font textColor:textColor];
    [label cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:cornerRadius];
    
    return label;
}

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式） */
+ (instancetype)cg_createLayoutLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self newAutoLayoutView];
    [label cg_setupWithFrame:frame text:text font:font textColor:textColor textAlignment:textAlignment backgroundColor:nil];
    
    return label;
}

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLayoutLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    UILabel *label = [self cg_createLayoutLabelWithFrame:frame text:text font:font textColor:textColor textAlignment:textAlignment];
    [label cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:cornerRadius];
    
    return label;
}


@end

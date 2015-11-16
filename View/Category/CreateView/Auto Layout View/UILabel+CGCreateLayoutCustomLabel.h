//
//  UILabel+CGCreateLayoutCustomLabel.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CGCreateLayoutCustomLabel)

/** 创建UILabel，设置（文本，字体，字体颜色） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

/** 创建UILabel，设置（文本，字体，字体颜色，圆角） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（文本，字体，字体颜色，边框（颜色，宽度）） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/** 创建UILabel，设置（文本，字体，字体颜色，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLayoutLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式） */
+ (instancetype)cg_createLayoutLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLayoutLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

@end

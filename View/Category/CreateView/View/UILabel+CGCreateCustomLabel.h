//
//  UILabel+CreateLabel.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  快捷创建UILabel
 */
@interface UILabel (CGCreateCustomLabel)

/** 创建默认样式的UILabel */
+ (instancetype)cg_createDefaultLabel;

/** 创建UILabel，设置（文本，字体，字体颜色） */
+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

/** 创建UILabel，设置（文本，字体，字体颜色，圆角） */
+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（文本，字体，字体颜色，边框（颜色，宽度）） */
+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/** 创建UILabel，设置（文本，字体，字体颜色，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式） */
+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
@end

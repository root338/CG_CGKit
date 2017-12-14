//
//  UILabel+CreateLabel.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  快捷创建UILabel
 */
@interface UILabel (CGCreateCustomLabel)

/** 创建默认样式的UILabel */
+ (instancetype)cg_createDefaultLabel;

/** 创建UILabel，设置（字体，字体颜色） */
+ (instancetype)cg_createLabelWithFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor;

/** 创建UILabel，设置（文本，字体，字体颜色） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor;

/** 创建UILabel，设置（文本，字体，字体颜色，对齐方式） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 创建UILabel，设置（文本，字体，字体颜色，对齐方式, 背景色） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(nullable UIColor *)backgroundColor;

/** 创建UILabel，设置（文本，字体，字体颜色，圆角） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（文本，字体，字体颜色，边框（颜色，宽度）） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/** 创建UILabel，设置（文本，字体，字体颜色，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLabelWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式） */
+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 创建UILabel，设置（显示区域，文本，字体，字体颜色，对齐方式，边框(颜色，宽度），圆角） */
+ (instancetype)cg_createLabelWithFrame:(CGRect)frame text:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
@end
NS_ASSUME_NONNULL_END

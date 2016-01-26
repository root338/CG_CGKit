//
//  UILabel+CGSetupAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CGSetupAppearance.h"

NS_ASSUME_NONNULL_BEGIN
@interface UILabel (CGSetupAppearance)

/** 设置UILabel 设置系统默认属性 */
- (void)cg_setupDefaultLabel;

/** 设置UILabel（文本，字体，字体颜色） */
- (void)cg_setupWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor;

/** 设置UILabel（文本，字体，字体颜色，对齐方式） */
- (void)cg_setupWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 设置UILabel（文本，字体，字体颜色，对齐方式，背景色） */
- (void)cg_setupWithText:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(nullable UIColor *)backgroundColor;

/** 设置UILabel（显示区域，文本，字体，字体颜色，对齐方式，背景色） */
- (void)cg_setupWithFrame:(CGRect)frame text:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(nullable UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
//
//  UILabel+CGSetupAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CGSetupAppearance.h"

@interface UILabel (CGSetupAppearance)

/** 设置UILabel（文本，字体，字体颜色） */
- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

/** 设置UILabel（文本，字体，字体颜色，对齐方式） */
- (void)cg_setupWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end

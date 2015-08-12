//
//  UIButton+CreateCustomButton.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 创建按钮 */
@interface UIButton (CGCreateCustomButton)

/**
 *  创建按钮
 *
 *  @param type       按钮的样式
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param font       标题字体
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  创建按钮
 *
 *  @param type        样式
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radius:(CGFloat)radius;
@end

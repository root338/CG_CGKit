//
//  UIButton+CreateCustomButton.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGButtonAlignStyleHeader.h"

/** 创建按钮 */
@interface UIButton (CGCreateCustomButton)

/**
 *  创建默认按钮(UIButtonTypeSystem样式按钮)
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createDefaultButton;

/**
 *  创建按钮，设置按钮样式、标题、标题颜色和标题字体
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
 *  创建按钮，设置按钮样式、默认图片、选中图片
 *
 *  @param type            按钮样式
 *  @param normalImage     默认图片
 *  @param selectImageName 选中图片
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName;

/**
 *  创建按钮，设置按钮样式、默认图片名(并且设置按钮的大小为图片大小)
 *
 *  @param type            按钮样式
 *  @param normalImageName 默认图片名
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImageName:(NSString *)normalImage;

/**
 *  创建按钮，设置按钮样式、默认图片(并且设置按钮的大小为图片大小)
 *
 *  @param type            按钮样式
 *  @param normalImageName 默认图片
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImage:(UIImage *)normalImageName;

/**
 *  创建按钮，设置按钮样式、标题、标题颜色、标题字体和圆角
 *
 *  @param type        样式
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param radius      圆角值
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font radius:(CGFloat)radius;

/**
 *  创建按钮，设置按钮样式、标题、标题颜色、标题字体、外边框的宽度、颜色和圆角
 *
 *  @param type        样式
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param radius      圆角值
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radius:(CGFloat)radius;

/** 创建按钮，创建按钮，设置按钮样式、标题（颜色、字体）、图片(UIImage)和标题 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage;

/** 创建按钮，创建按钮，设置按钮样式、标题（颜色、字体）、本地图片名(NSString)和标题 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName;

/**
 *  创建按钮，设置按钮样式、标题（颜色、字体）、图片名(NSString)和标题和图片的间距
 *
 *  @param type             样式
 *  @param title            标题
 *  @param titleColor       标题颜色
 *  @param font             标题字体
 *  @param borderWidth      边框宽度
 *  @param borderColor      边框颜色
 *  @param normalImageName  普通状态下的图片的名字 @warning图片名必须为本地项目，加载图片时使用[UIImage imageName:<图片名>]
 *  @param space            标题与图片之间的间距
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName space:(CGFloat)space;

/**
 *  创建按钮，创建按钮，设置按钮样式、标题（颜色、字体）、图片(UIImage)和标题和图片的间距
 *
 *  @param type        样式
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param normalImage 普通状态下的图片
 *  @param space       标题与图片之间的间距
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage space:(CGFloat)space;

/** 
 *  创建按钮，自动设置大小，设置按钮样式、标题（颜色、字体）、图片(UIImage)、标题和图片的间距
 *  @bug 图片、标题上下对齐时按钮的宽度为图片宽度加标题宽度，若设置其中最大的宽度会导致标题或图片显示不全
 */
+ (instancetype)cg_createButtonAutoSizeWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage alignStyle:(CGButtonStyle)style space:(CGFloat)space;

/**
 *  创建按钮，设置按钮样式、标题（颜色、字体）、图片(UIImage)、标题和图片的间距和按钮大小
 *
 *
 *  @param type        样式
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param normalImage 普通状态下的图片
 *  @param style       对齐样式
 *  @param space       标题与图片之间的间距
 *  @param paramSize   宽度
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage alignStyle:(CGButtonStyle)style space:(CGFloat)space size:(CGSize)paramSize;
@end

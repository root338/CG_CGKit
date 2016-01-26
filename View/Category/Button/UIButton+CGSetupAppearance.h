//
//  UIButton+SetupAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CGSetupAppearance.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIButton (CGSetupAppearance)

/**
 *  设置按钮样式、标题、标题颜色和标题字体
 *
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param font       标题字体
 *
 *  @return 返回创建好的按钮
 */
- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  设置按钮样式、默认图片、选中图片
 *
 *  @param normalImage     默认图片
 *  @param selectImageName 选中图片
 *
 *  @return 返回创建好的按钮
 */
- (void)cg_setupWithNormalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName;

/**
 *  设置按钮样式、标题、标题颜色、标题字体和圆角
 *
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param radius      圆角值
 *
 *  @return 返回创建好的按钮
 */
- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font radius:(CGFloat)radius;

/**
 *  设置按钮样式、标题、标题颜色、标题字体、外边框的宽度、颜色和圆角
 *
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param radius      圆角值
 *
 *  @return 返回创建好的按钮
 */
- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radius:(CGFloat)radius;

/**
 *  设置按钮样式、标题（颜色、字体）、图片名(NSString)和标题和图片的间距
 *
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
//- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName space:(CGFloat)space;

/**
 *  创建按钮，设置按钮样式、标题（颜色、字体）、图片(UIImage)和标题和图片的间距
 *
 *  @param title       标题
 *  @param titleColor  标题颜色
 *  @param font        标题字体
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param normalImage 普通状态下的图片
 *  @param space       标题与图片之间的间距
 *
 *  @return 返回创建好的按钮
 */
//- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage space:(CGFloat)space;

@end
NS_ASSUME_NONNULL_END
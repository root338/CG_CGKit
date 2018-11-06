//
//  UITextField+MLAddView.h
//  QuickAskCommunity
//
//  Created by apple on 2018/11/1.
//  Copyright © 2018 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MLAddView)

/**
 设置 leftView 为 UILabel

 @param text 标题
 @param font 字体
 @param color 字体颜色
 */
- (UILabel *)setLeftViewWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

/**
 设置 leftView 为 UILabel

 @param attributedString UILabel 的富文本
 */
- (UILabel *)setLeftViewWithAttributedString:(NSAttributedString *)attributedString;

/**
 设置 rightView 为 UIImageView

 @param localImageName 本地图片名
 */
- (UIImageView *)setRightViewWithLocalImageName:(NSString *)localImageName;

/**
 设置 rightView 为 UIImageView

 @param image 图片
 */
- (UIImageView *)setRightViewWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

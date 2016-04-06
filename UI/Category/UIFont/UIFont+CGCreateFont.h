//
//  UIFont+CGCreateFont.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIFont (CGCreateFont)

#pragma mark - 创建全局默认的字体

+ (UIFont *)cg_defaultFontWithSize:(CGFloat)size;
+ (UIFont *)cg_defaultItalicFontWithSize:(CGFloat)size;
+ (UIFont *)cg_defaultBoldFontWithSize:(CGFloat)size;

@end
NS_ASSUME_NONNULL_END
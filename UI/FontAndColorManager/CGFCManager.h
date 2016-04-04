//
//  CGFCManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "UIColor+ColorValueTransform.h"


/** 文字，颜色管理类 */
NS_CLASS_DEPRECATED_IOS(2_0, 2_0, "不要使用，只是测试，测试，。。。")
@interface CGFCManager : CGBaseObject

+ (instancetype)sharedManager;

#pragma mark - 获取UIFont
- (UIFont *)cg_systemFontOfSize:(CGFloat)size;
- (UIFont *)cg_boldSystemFontOfSize:(CGFloat)size;
- (UIFont *)cg_italicSystemFontOfSize:(CGFloat)size;
- (UIFont *)cg_fontName:(NSString *)fontName size:(CGFloat)size;

- (UIColor *)cg_colorWithValue:(KCG_16_ColorValueType)colorValue;

@end

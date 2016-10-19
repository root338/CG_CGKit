//
//  UIColor+ColorValueTransform.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/1.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

//16进制色值 创建 UIColor 对象
#define __K_CG_16_VALUE_ACOLOR(__K_16_VALUE) [UIColor colorWithRed:(((__K_16_VALUE) & 0x00FF0000) >> 16) / 255.0 green:(((__K_16_VALUE) & 0X0000FF00) >> 8) / 255.0 blue:((__K_16_VALUE) & 0X000000FF) / 255.0 alpha:(((__K_16_VALUE) & 0xFF000000) >> 24) / 255.0]

#define __K_CG_16_VALUE_COLOR(__K_16_VALUE) __K_CG_16_VALUE_ACOLOR((__K_16_VALUE) | 0xFF000000)

/** 10进制数字，注意：r,g,b的数值应该在 1 ~ 255 闭区间之间 */
#define __K_CG_10_VALUE_COLORA(R, G, B, A) [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:(A)]

#define __K_CG_10_VALUE_COLOR(R, G, B) __K_CG_10_VALUE_COLORA(R, G, B, 1)

/** 枚举的部分16进制色值 */
typedef NS_ENUM(NSUInteger, KCG_16_ColorValueType) {
    
    KCG_16_ColorValueType_0X000000  = 0X000000,
    
    KCG_16_ColorValueType_0X0000FF  = 0X0000FF,
    
    KCG_16_ColorValueType_0X00FF00  = 0X00FF00,
    
    KCG_16_ColorValueType_0X333333  = 0X333333,
    
    KCG_16_ColorValueType_0X666666  = 0X666666,
    
    KCG_16_ColorValueType_0XE3E3E3  = 0XE3E3E3,
    
    KCG_16_ColorValueType_0XE5E5E5  = 0XE5E5E5,
    
    KCG_16_ColorValueType_0XEFEFEF  = 0XEFEFEF,
    
    KCG_16_ColorValueType_0XF2F2F2  = 0XF2F2F2,
    
    KCG_16_ColorValueType_0XFF0000  = 0XFF0000,
    
    KCG_16_ColorValueType_0XFFFFFF  = 0XFFFFFF,
};

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (ColorValueTransform)

+ (UIColor *)colorWithValueType:(KCG_16_ColorValueType)valueType;
+ (UIColor *)colorWithValueType:(KCG_16_ColorValueType)valueType alpha:(CGFloat)alpha;

@end
NS_ASSUME_NONNULL_END

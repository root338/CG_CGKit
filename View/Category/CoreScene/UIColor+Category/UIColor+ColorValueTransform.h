//
//  UIColor+ColorValueTransform.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/1.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

//16进制色值 创建UIColor 对象
#define __K_CG_16_VALUE_COLORA(__K_16_VALUE, A) [UIColor colorWithRed:((__K_16_VALUE) & 0x00FFFF) / 255.0 green:((__K_16_VALUE) & 0X00FF00) / 255.0 blue:((__K_16_VALUE) & 0X0000FF) / 255.0 alpha:(A)]

#define __K_CG_16_VALUE_COLOR(__K_16_VALUE) __K_CG_16_VALUE_COLORA(__K_16_VALUE, 1)

/** 10进制数字，注意：r,g,b的数值应该在 1 ~ 255 闭区间之间 */
#define __K_CG_10_VALUE_COLORA(R, G, B, A) [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:(A)]

#define __K_CG_10_VALUE_COLOR(R, G, B) __K_CG_10_VALUE_COLORA(R, G, B, 1)

/** 枚举的部分16进制色值 */
typedef NS_ENUM(NSUInteger, KCG_16_ColorValueType) {
    
    KCG_16_ColorValueType_0X000000  = 0X000000,
    
    KCG_16_ColorValueType_0X333333  = 0X333333,
    
    KCG_16_ColorValueType_0X666666  = 0X666666,
    
    KCG_16_ColorValueType_0XE3E3E3  = 0XE3E3E3,
    
    KCG_16_ColorValueType_0XEFEFEF  = 0XEFEFEF,
    
    KCG_16_ColorValueType_0XF2F2F2  = 0XF2F2F2,
    
    KCG_16_ColorValueType_0XFFFFFF  = 0xFFFFFF,
};

@interface UIColor (ColorValueTransform)


@end

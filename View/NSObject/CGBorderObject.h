//
//  CGBorderObject.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "UIColor+ColorValueTransform.h"

/** 
 *  用于边框设置
 *  主要用于：CGBorderBaseView 类或其子类的不同边框数据存储
 */
@interface CGBorderObject : CGBaseObject

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

+ (instancetype)cg_createBorderWithColorValue:(KCG_16_ColorValueType)color width:(CGFloat)width;
+ (instancetype)cg_createBorderWithColorObject:(UIColor *)color width:(CGFloat)width;

- (instancetype)initWithColor:(UIColor *)color width:(CGFloat)width;
@end

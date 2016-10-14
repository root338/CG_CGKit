//
//  CGIconConfig.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

//图标基本配置
@interface CGIconConfig : NSObject

#pragma mark - 画布设置
/** 背景色，默认nil */
//@property (nullable, nonatomic, strong) UIColor *backgroundColor;
/** 大小，默认30 x 30 */
@property (nonatomic, assign) CGSize size;
/** 是否不透明，默认NO */
@property (nonatomic, assign) BOOL opaque;
/** 比例因子，默认为[UIScreen mainScreen].scale */
@property (nonatomic, assign) CGFloat scale;

/** 绘制视图与设置大小的边界距离，默认为UIEdgeInsetsZero */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInset;

#pragma mark - 图标设置
/** 图标颜色，默认黑色 */
@property (nullable, nonatomic, strong) UIColor *tintColor;
/** 线宽, 默认2 */
@property (nonatomic, assign) CGFloat lineWidth;

/** 接合类型，默认kCGLineJoinMiter */
@property(nonatomic, assign) CGLineJoin lineJoinStyle;

@property(nonatomic, assign) CGFloat miterLimit; // Used when lineJoinStyle is kCGLineJoinMiter

/** 旋转画布，默认0 */
//@property (nonatomic, assign) CGFloat canvasRotateAngle;

//可用的绘制区域
@property (nonatomic, assign, readonly) CGSize canvasAvailableSize;
//绘制的开始坐标
@property (nonatomic, assign, readonly) CGPoint drawStartPoint;

@end

NS_ASSUME_NONNULL_END

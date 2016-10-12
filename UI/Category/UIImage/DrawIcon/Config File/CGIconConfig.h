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
/** 大小，默认20 x 20 */
@property (nonatomic, assign) CGSize size;
/** 是否不透明，默认NO */
@property (nonatomic, assign) BOOL opaque;
/** 比例因子，默认为[UIScreen mainScreen].scale */
@property (nonatomic, assign) CGFloat scale;

/** 禁止自动调节size大小，默认为NO @warning 为了防止顶点无法绘制尖角和预留一定像素防止锯齿需要额外的画布空间 */
@property (nonatomic, assign) BOOL disableAdjustToSize;

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

@end

NS_ASSUME_NONNULL_END

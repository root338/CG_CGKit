//
//  CGRadioViewAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

#import "CGLineBoxTypeHeader.h"


NS_ASSUME_NONNULL_BEGIN

@class CGTitleRadioCellAppearance, CGRadioViewFlowLayout, CGRadioSliderViewAppearance;

/** 单选视图外观设置 */
@interface CGRadioViewAppearance : CGBaseObject<NSCopying, NSMutableCopying>

//单选视图主视图外观设置
@property (nullable, nonatomic, strong, readonly) UIColor *backgroundColor;
@property (nonatomic, assign, readonly) LineBoxType lineBoxType;
@property (nonatomic, assign, readonly) CGFloat lineLength;
@property (nullable, nonatomic, strong, readonly) UIColor *lineColor;

/**
 仅在使用 CGTitleRadioView 下有效
 */
@property (nullable, nonatomic, strong, readonly) CGTitleRadioCellAppearance *titleRadioCellAppearance;

/**
 设置 cell 的布局
 */
@property (nullable, nonatomic, strong, readonly) CGRadioViewFlowLayout *radioViewFlowLayout;

@property (nonatomic, assign, readonly) BOOL isHideSliderView;
/**
 设置滑块的配置
 */
@property (nullable, nonatomic, strong, readonly) CGRadioSliderViewAppearance *radioSliderViewAppearance;

/** 获取单选视图最适高度 */
- (CGFloat)getRadioViewCompressedHeight;

/** 获取子视图与父视图的边距，为绘制的线提供显示区域 */
- (UIEdgeInsets)getSubviewEdgeInsets;

/** 获取垂直条件下所有设置的间距 */
- (CGFloat)getVerticalAllSpace;

+ (instancetype)defaultRadioAppearance;
@end

@interface CGMutableRadioViewAppearance : CGRadioViewAppearance

@property (nullable, nonatomic) UIColor *backgroundColor;
@property (nonatomic) LineBoxType lineBoxType;
@property (nonatomic) CGFloat lineLength;
@property (nullable, nonatomic) UIColor *lineColor;

@property (nullable, nonatomic) CGTitleRadioCellAppearance *titleRadioCellAppearance;
@property (nullable, nonatomic) CGRadioViewFlowLayout *radioViewFlowLayout;

@property (nonatomic) BOOL isHideSliderView;
@property (nullable, nonatomic) CGRadioSliderViewAppearance *radioSliderViewAppearance;

/** 设置外边线 */
- (void)setupLineBoxType:(LineBoxType)type color:(UIColor *)color width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END

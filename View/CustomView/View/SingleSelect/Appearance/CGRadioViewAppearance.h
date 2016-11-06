//
//  CGRadioViewAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

#import "CGLineBoxTypeHeader.h"
#import "CGRadioSliderViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTitleRadioCellAppearance, CGRadioViewFlowLayout;

/** 单选视图外观设置 */
@interface CGRadioViewAppearance : CGBaseObject

//单选视图主视图外观设置
@property (nullable, nonatomic, strong, readonly) UIColor         *   backgroundColor;
@property (nonatomic, assign, readonly)           LineBoxType         lineBoxType;
@property (nonatomic, assign, readonly)           CGFloat             lineLength;
@property (nullable, nonatomic, strong, readonly) UIColor         *   lineColor;

//设置滑块
@property (nonatomic, assign, readonly)           BOOL                isHideSliderView;
@property (nullable, nonatomic, strong, readonly) UIColor         *   sliderViewBackgroundColor;
@property (nonatomic, assign, readonly)           CGFloat             sliderViewCornerRadius;
@property (nullable, nonatomic, strong, readonly) UIColor         *   sliderViewBorderColor;
@property (nonatomic, assign, readonly)           CGFloat             sliderViewBorderWidth;
@property (nonatomic, assign, readonly)           CGFloat             sliderViewHeight;
@property (nonatomic, assign, readonly)           CGFloat             sliderViewWidth;

@property (nonatomic, assign, readonly)           CGSliderViewPositionType sliderViewPositionType;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign, readonly)           BOOL                moveSliderViewIsAnimation;

/**
 仅在使用 CGTitleRadioView 下有效
 */
@property (nullable, nonatomic, strong, readonly) CGTitleRadioCellAppearance *titleRadioCellAppearance;

/**
 设置 cell 的布局
 */
@property (nullable, nonatomic, strong, readonly) CGRadioViewFlowLayout *radioViewFlowLayout;

- (void)setupRadioViewFlowLayout:(CGRadioViewFlowLayout *)flowLayout;

/** 获取单选视图最适高度 */
- (CGFloat)getRadioViewCompressedHeight;

/** 获取子视图与父视图的边距，为绘制的线提供显示区域 */
- (UIEdgeInsets)getSubviewEdgeInsets;

/** 获取垂直条件下所有设置的间距 */
- (CGFloat)getVerticalAllSpace;

/** 设置外边线 */
- (void)setupLineBoxType:(LineBoxType)type color:(UIColor *)color width:(CGFloat)width;

/** 设置滑块边框／圆角 */
- (void)setupSliderViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)defaultRadioAppearance;
@end

@interface CGMutableRadioViewAppearance : CGRadioViewAppearance

@property (nullable, nonatomic) UIColor         *   backgroundColor;
@property (nonatomic)           LineBoxType         lineBoxType;
@property (nonatomic)           CGFloat             lineLength;
@property (nullable, nonatomic) UIColor         *   lineColor;

@property (nonatomic)           BOOL                isHideSliderView;
@property (nullable, nonatomic) UIColor         *   sliderViewBackgroundColor;
@property (nonatomic)           CGFloat             sliderViewCornerRadius;
@property (nullable, nonatomic) UIColor         *   sliderViewBorderColor;
@property (nonatomic)           CGFloat             sliderViewBorderWidth;
@property (nonatomic)           CGFloat             sliderViewHeight;
@property (nonatomic)           CGFloat             sliderViewWidth;
@property (nonatomic)           CGSliderViewPositionType sliderViewPositionType;
@property (nonatomic)           BOOL                moveSliderViewIsAnimation;
@property (nullable, nonatomic) CGTitleRadioCellAppearance *titleRadioCellAppearance;
@property (nullable, nonatomic) CGRadioViewFlowLayout *radioViewFlowLayout;


@end

NS_ASSUME_NONNULL_END

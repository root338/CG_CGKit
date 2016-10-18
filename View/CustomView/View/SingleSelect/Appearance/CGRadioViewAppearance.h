//
//  CGRadioViewAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioCellAppearance.h"

#import "CGLineBoxTypeHeader.h"
#import "CGRadioSliderViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTitleRadioCellAppearance;

/** 单选视图外观设置 */
@interface CGRadioViewAppearance : CGTitleRadioCellAppearance

//单选视图主视图外观设置
@property (nullable, nonatomic, strong) UIColor         *   backgroundColor;
@property (nonatomic, assign)           LineBoxType         lineBoxType;
@property (nonatomic, assign)           CGFloat             lineLength;
@property (nullable, nonatomic, strong) UIColor         *   lineColor;

//滑动视图的设置
@property (nonatomic, assign)           UIEdgeInsets        marginEdgeInsets;
/** 滑动视图滑动的方向, 默认 UICollectionViewScrollDirectionHorizontal */
@property (nonatomic, assign)           UICollectionViewScrollDirection scrollDirection;

//内部选择按钮设置
/** 自动计算选择按钮 */
@property (nonatomic, assign)           BOOL                isAutoItemSize;
@property (nonatomic, assign)           CGSize              itemSize;
/** 选择按钮之间的间距 */
@property (nonatomic, assign)           CGFloat             itemSpace;

//设置滑块
@property (nullable, nonatomic, strong) UIColor         *   sliderViewBackgroundColor;
@property (nonatomic, assign)           CGFloat             sliderViewCornerRadius;
@property (nullable, nonatomic, strong) UIColor         *   sliderViewBorderColor;
@property (nonatomic, assign)           CGFloat             sliderViewBorderWidth;
@property (nonatomic, assign)           CGFloat             sliderViewHeight;
@property (nonatomic, assign)           CGFloat             sliderViewWidth;

@property (nonatomic, assign)           CGSliderViewPositionType sliderViewPositionType;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign)           BOOL                moveSliderViewIsAnimation;

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
@end

NS_ASSUME_NONNULL_END

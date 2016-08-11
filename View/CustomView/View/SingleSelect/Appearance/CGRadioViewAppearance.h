//
//  CGRadioViewAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioCellAppearance.h"
#import "CGLineBoxTypeHeader.h"

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

/** 移动滑块是否动画执行 */
@property (nonatomic, assign)           BOOL                moveSliderViewIsAnimation;

@end

NS_ASSUME_NONNULL_END
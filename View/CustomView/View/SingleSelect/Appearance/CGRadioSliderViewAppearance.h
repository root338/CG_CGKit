//
//  CGRadioSliderViewAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 2016/11/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGRadioSliderViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGRadioSliderViewAppearance : CGBaseObject<NSCopying, NSMutableCopying>

//设置滑块

@property (nullable, nonatomic, strong, readonly) UIColor *sliderViewBackgroundColor;
@property (nonatomic, assign, readonly) CGFloat sliderViewCornerRadius;
@property (nullable, nonatomic, strong, readonly) UIColor *sliderViewBorderColor;
@property (nonatomic, assign, readonly) CGFloat sliderViewBorderWidth;
@property (nonatomic, assign, readonly) CGFloat sliderViewHeight;
@property (nonatomic, assign, readonly) CGFloat sliderViewWidth;
@property (nonatomic, assign, readonly) CGPoint offset;

// 渐变的颜色集合
@property (nullable, nonatomic, strong, readonly) NSArray<UIColor *> *sliderViewBackgroundColors;
@property (nullable, nonatomic, strong, readonly) NSArray<NSNumber *> *sliderViewBackgroundColorLocations;
@property (nonatomic, assign, readonly) CGPoint startPoint;
@property (nonatomic, assign, readonly) CGPoint endPoint;

@property (nonatomic, assign, readonly) CGSliderViewPositionType sliderViewPositionType;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign, readonly) BOOL moveSliderViewIsAnimation;

@end

@interface CGMutableRadioSliderViewAppearance : CGRadioSliderViewAppearance

@property (nullable, nonatomic) UIColor *sliderViewBackgroundColor;
@property (nonatomic) CGFloat sliderViewCornerRadius;
@property (nullable, nonatomic) UIColor *sliderViewBorderColor;
@property (nonatomic) CGFloat sliderViewBorderWidth;
@property (nonatomic) CGFloat sliderViewHeight;
@property (nonatomic) CGFloat sliderViewWidth;
@property (nonatomic) CGSliderViewPositionType sliderViewPositionType;
@property (nonatomic) BOOL moveSliderViewIsAnimation;
@property (nonatomic) CGPoint offset;

@property (nonatomic) NSArray<UIColor *> *sliderViewBackgroundColors;
@property (nonatomic) NSArray<NSNumber *> *sliderViewBackgroundColorLocations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

/** 设置滑块边框／圆角 */
- (void)setupSliderViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END

//
//  CGRadioSliderViewAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 2016/11/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGRadioSliderViewAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGRadioSliderViewAppearance ()

//设置滑块

@property (nullable, nonatomic, strong, readwrite) UIColor         *   sliderViewBackgroundColor;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewCornerRadius;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   sliderViewBorderColor;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewBorderWidth;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewHeight;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewWidth;

@property (nonatomic, assign, readwrite)           CGSliderViewPositionType sliderViewPositionType;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign, readwrite)           BOOL                moveSliderViewIsAnimation;
@property (nonatomic, assign, readwrite) CGPoint offset;

@end

@implementation CGRadioSliderViewAppearance

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    CGRadioSliderViewAppearance *sliderViewAppearance   = [[[self class] alloc] init];
    [self copyWithAppearance:sliderViewAppearance];
    return sliderViewAppearance;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    CGMutableRadioSliderViewAppearance *appearance  = [[CGMutableRadioSliderViewAppearance alloc] init];
    [self copyWithAppearance:appearance];
    return appearance;
}

- (void)copyWithAppearance:(CGRadioSliderViewAppearance *)appearance
{
    appearance.sliderViewWidth              = self.sliderViewWidth;
    appearance.sliderViewHeight             = self.sliderViewHeight;
    appearance.sliderViewBorderColor        = [self.sliderViewBorderColor copy];
    appearance.sliderViewBorderWidth        = self.sliderViewBorderWidth;
    appearance.sliderViewCornerRadius       = self.sliderViewCornerRadius;
    appearance.sliderViewPositionType       = self.sliderViewPositionType;
    appearance.sliderViewBackgroundColor    = [self.sliderViewBackgroundColor copy];
    appearance.moveSliderViewIsAnimation    = self.moveSliderViewIsAnimation;
    appearance.offset = self.offset;
}

@end

@implementation CGMutableRadioSliderViewAppearance

@dynamic sliderViewWidth;
@dynamic sliderViewHeight;
@dynamic sliderViewBorderColor;
@dynamic sliderViewBorderWidth;
@dynamic sliderViewCornerRadius;
@dynamic sliderViewPositionType;
@dynamic sliderViewBackgroundColor;
@dynamic moveSliderViewIsAnimation;
@dynamic offset;

- (void)setupSliderViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.sliderViewBorderColor  = borderColor;
    self.sliderViewBorderWidth  = borderWidth;
    self.sliderViewCornerRadius = cornerRadius;
}

@end

NS_ASSUME_NONNULL_END

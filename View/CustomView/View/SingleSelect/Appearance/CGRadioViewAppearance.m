//
//  CGRadioViewAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioViewAppearance.h"

#import "CGRadioViewFlowLayout.h"

@interface CGRadioViewAppearance ()

//单选视图主视图外观设置
@property (nullable, nonatomic, strong, readwrite) UIColor         *   backgroundColor;
@property (nonatomic, assign, readwrite)           LineBoxType         lineBoxType;
@property (nonatomic, assign, readwrite)           CGFloat             lineLength;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   lineColor;

//设置滑块
@property (nonatomic, assign, readwrite)           BOOL                isHideSliderView;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   sliderViewBackgroundColor;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewCornerRadius;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   sliderViewBorderColor;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewBorderWidth;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewHeight;
@property (nonatomic, assign, readwrite)           CGFloat             sliderViewWidth;

@property (nonatomic, assign, readwrite)           CGSliderViewPositionType sliderViewPositionType;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign, readwrite)           BOOL                moveSliderViewIsAnimation;

@property (nullable, nonatomic, strong, readwrite) CGTitleRadioCellAppearance *titleRadioCellAppearance;

@property (nullable, nonatomic, strong, readwrite) CGRadioViewFlowLayout *radioViewFlowLayout;


@end

@implementation CGRadioViewAppearance

+ (instancetype)defaultRadioAppearance
{
    return [self new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _lineBoxType        = 0;
        _lineLength         = 0;
    }
    return self;
}

- (void)setupRadioViewFlowLayout:(CGRadioViewFlowLayout *)flowLayout
{
    self.radioViewFlowLayout    = flowLayout;
}

- (void)setupLineBoxType:(LineBoxType)type color:(UIColor *)color width:(CGFloat)width
{
    self.lineBoxType    = type;
    self.lineColor      = color;
    self.lineLength     = width;
}

- (void)setupSliderViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.sliderViewBorderColor  = borderColor;
    self.sliderViewBorderWidth  = borderWidth;
    self.sliderViewCornerRadius = cornerRadius;
}

- (UIEdgeInsets)getSubviewEdgeInsets
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.lineBoxType & LineBoxTypeTop) {
        edgeInsets.top  = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeLeft) {
        edgeInsets.left = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeBottom) {
        edgeInsets.bottom   = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeRight) {
        edgeInsets.right    = self.lineLength;
    }
    return edgeInsets;
}

- (CGFloat)getVerticalAllSpace
{
    UIEdgeInsets insets = [self getSubviewEdgeInsets];
    return insets.top + insets.bottom + self.radioViewFlowLayout.marginEdgeInsets.top + self.radioViewFlowLayout.marginEdgeInsets.bottom;
}

- (CGFloat)getRadioViewCompressedHeight
{
    return self.radioViewFlowLayout.itemSize.height + self.sliderViewHeight;
}

#pragma mark - 属性设置

- (UIColor *)backgroundColor
{
    if (_backgroundColor != nil) {
        return _backgroundColor;
    }
    _backgroundColor    = [UIColor clearColor];
    return _backgroundColor;
}

@end

@implementation CGMutableRadioViewAppearance

@dynamic backgroundColor;
@dynamic lineBoxType;
@dynamic lineLength;
@dynamic lineColor;
@dynamic isHideSliderView;
@dynamic sliderViewWidth;
@dynamic sliderViewHeight;
@dynamic sliderViewBorderColor;
@dynamic sliderViewBorderWidth;
@dynamic sliderViewCornerRadius;
@dynamic sliderViewPositionType;
@dynamic sliderViewBackgroundColor;
@dynamic moveSliderViewIsAnimation;
@dynamic titleRadioCellAppearance;
@dynamic radioViewFlowLayout;

@end

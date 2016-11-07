//
//  CGRadioViewAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioViewAppearance.h"

#import "CGRadioViewFlowLayout.h"
#import "CGTitleRadioCellAppearance.h"
#import "CGRadioSliderViewAppearance.h"

@interface CGRadioViewAppearance ()

//单选视图主视图外观设置
@property (nullable, nonatomic, strong, readwrite) UIColor         *   backgroundColor;
@property (nonatomic, assign, readwrite)           LineBoxType         lineBoxType;
@property (nonatomic, assign, readwrite)           CGFloat             lineLength;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   lineColor;

@property (nullable, nonatomic, strong, readwrite) CGTitleRadioCellAppearance *titleRadioCellAppearance;

@property (nullable, nonatomic, strong, readwrite) CGRadioViewFlowLayout *radioViewFlowLayout;

@property (nonatomic, assign, readwrite)           BOOL                isHideSliderView;
@property (nullable, nonatomic, strong, readwrite) CGRadioSliderViewAppearance *radioSliderViewAppearance;

@end

@implementation CGRadioViewAppearance

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    CGRadioViewAppearance *appearance   = [[[self class] alloc] init];
    [self copyWithAppearance:appearance];
    return appearance;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone
{
    CGMutableRadioViewAppearance *appearance    = [[CGMutableRadioViewAppearance alloc] init];
    [self copyWithAppearance:appearance];
    return appearance;
}

- (void)copyWithAppearance:(CGRadioViewAppearance *)appearance
{
    appearance.backgroundColor          = [self.backgroundColor copy];
    appearance.lineBoxType              = self.lineBoxType;
    appearance.lineLength               = self.lineLength;
    appearance.lineColor                = [self.lineColor copy];
    
    appearance.titleRadioCellAppearance = [self.titleRadioCellAppearance copy];
    appearance.radioViewFlowLayout      = [self.radioViewFlowLayout copy];
    appearance.isHideSliderView         = self.isHideSliderView;
    appearance.radioSliderViewAppearance= [self.radioSliderViewAppearance copy];
}

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
    return self.radioViewFlowLayout.itemSize.height + self.radioSliderViewAppearance.sliderViewHeight;
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
@dynamic titleRadioCellAppearance;
@dynamic radioViewFlowLayout;

@dynamic isHideSliderView;
@dynamic radioSliderViewAppearance;

- (void)setupLineBoxType:(LineBoxType)type color:(UIColor *)color width:(CGFloat)width
{
    self.lineBoxType    = type;
    self.lineColor      = color;
    self.lineLength     = width;
}

@end

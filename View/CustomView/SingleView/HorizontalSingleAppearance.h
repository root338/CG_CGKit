//
//  HorizontalSingleAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+DrawBoxLine.h"

/**
 *  滑块宽度样式
 */
typedef NS_ENUM(NSInteger, HorizontalSingleSliderType){
    /**
     *  默认样式和按钮宽度相等
     */
    HorizontalSingleSliderTypeDefalut,
    /**
     *  与标题宽度相等
     */
    HorizontalSingleSliderTypeTitle,
    
    /** 与标题宽度存在左右边距 */
    HorizontalSingleSliderTypeTitleInsetsEdge,
    /**
     *  自定义宽度
     */
    HorizontalSingleSliderTypeCustom
};

/**
 样式选择

 - HorizontalSingleViewStyleDefault: 默认
 - HorizontalSingleViewStyleValue1: 按钮按照文字大小自动计算，按钮之间的间距等分,忽略其他所有属性
 */
typedef NS_ENUM(NSInteger, HorizontalSingleViewStyle) {
    HorizontalSingleViewStyleDefault,
    
    HorizontalSingleViewStyleValue1,
};

/**
 *  水平横向视图的外观设置
 */
@interface HorizontalSingleAppearance : NSObject



#pragma mark - 滑块设置
/**
 *  滑块的大小
 *  @warning width值只在 sliderType 为 HorizontalSingleSliderTypeCustom 有效
 */
@property (nonatomic, assign) CGSize    sliderSize;

/**
 *  快捷设置滑块高度的值
 */
@property (nonatomic) CGFloat   sliderHeight;

/**
 *  滑块的颜色
 */
@property (nonatomic, strong) UIColor * sliderColor;

/** 滑块圆角设置 */
@property (assign, nonatomic) CGFloat sliderCornerRadius;

/**
 *  滑块宽度设置类型
 */
@property (nonatomic, assign) HorizontalSingleSliderType sliderType;

/// 在HorizontalSingleSliderTypeTitleInsetsEdge类型下有效
/// 与标题的左边间距值
@property (nonatomic, assign) CGFloat sliderLeftSpaceInsets;
/// 与标题的右边间距值
@property (nonatomic, assign) CGFloat sliderRightSpaceInsets;

/// 设置滑块左右两边相同的值
@property (nonatomic, assign, readwrite) CGFloat sliderSpaceInsets;

#pragma mark - 主视图设置

@property (nonatomic, assign) HorizontalSingleViewStyle style;

/** 单选视图背景 */
@property (nonatomic, copy) UIColor * backgroundColor;

/** 单选视图背景图片 */
@property (nonatomic, strong) UIImage * backgroundImage;

/** 单选视图背景图片的加载样式 */
@property (assign, nonatomic) UIViewContentMode *backgroundImageMode;

/** 单选视图边线框的样式 */
@property (assign, nonatomic) DDrawLineType lineType;

/** 单选视图边线框的颜色 */
@property (strong, nonatomic) UIColor *lineColor;

/** 单选视图边线框的宽度 */
@property (assign, nonatomic) CGFloat lineWidth;

/** 单选视图边线框的边间距 */
@property (assign, nonatomic) UIEdgeInsets lineEdgeInsets;

/**
 *  内容视图与视图之间的边界值
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsetForContentView;

#pragma mark - 选择按钮状态

/**
 *  选择按钮之间的间距
 */
@property (nonatomic, assign) CGFloat spaceForButtons;

#pragma mark - 按钮外观设置
/** 按钮创建的状态 */
@property (assign, nonatomic) UIButtonType buttonType;

/**
 按钮不同状态下的颜色
 */
@property (nonatomic, strong) NSDictionary<NSNumber *, UIColor *> *titleColors;
/** 按钮字体 */
@property (nonatomic, strong) UIFont *titleFont;
@end

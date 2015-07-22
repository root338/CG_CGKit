//
//  HorizontalSingleAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

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
    /**
     *  自定义宽度
     */
    HorizontalSingleSliderTypeCustom
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

@property (nonatomic) CGFloat   sliderHeight;

@property (nonatomic, strong) UIColor * sliderColor;

@property (nonatomic, assign) HorizontalSingleSliderType sliderType;

#pragma mark - 主视图设置
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, strong) UIImage * backgroundImage;

/**
 *  内容视图与视图之间的边界值
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsetForContentView;

#pragma mark - 选择按钮状态


/**
 *  选择按钮之间的间距
 */
@property (nonatomic, assign) CGFloat spaceForButtons;
@end

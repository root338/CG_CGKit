//
//  HorizontalSingleAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  水平横向视图的外观设置
 */
@interface HorizontalSingleAppearance : NSObject

#pragma mark - 滑块设置
@property (nonatomic, assign) CGFloat   sliderHeight;
@property (nonatomic, strong) UIColor * sliderColor;

#pragma mark - 主视图设置
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, strong) UIImage * backgroundImage;

#pragma mark - 选择按钮状态

@end

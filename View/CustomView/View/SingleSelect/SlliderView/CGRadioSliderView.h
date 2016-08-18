//
//  CGRadioSliderView.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGRadioSliderViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 单选视图滑块 */
@interface CGRadioSliderView : CGBaseView

/** 滑块的位置类型 */
@property (nonatomic, assign) CGSliderViewPositionType positionType;

@end

NS_ASSUME_NONNULL_END
//
//  CGScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGScrollViewDefineHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGScrollViewDelegate <UIScrollViewDelegate>

@end

@interface CGScrollView : UIScrollView

//控制类型
@property (nonatomic, assign, readonly) CGScrollControlType scrollControlType;
//滑动方向
@property (nonatomic, assign, readonly) CGScrollDirectionType scrollDirectionType;
//垂直滑动平均速度
@property (nonatomic, assign, readonly) CGFloat verticalMeanVelocity;
//水平滑动平均速度
@property (nonatomic, assign, readonly) CGFloat horizontalMeanVelocity;

@property (nullable, nonatomic, weak) id<CGScrollViewDelegate> delegate_cg;

@end
NS_ASSUME_NONNULL_END

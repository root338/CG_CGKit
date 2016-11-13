//
//  CGScrollViewDelegateManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGScrollViewDefineHeader.h"

@interface CGScrollViewDelegateManager : NSObject<UIScrollViewDelegate>

//控制类型
@property (nonatomic, assign, readonly) CGScrollControlType scrollControlType;
//滑动方向
@property (nonatomic, assign, readonly) CGScrollDirectionType scrollDirectionType;
//垂直滑动平均速度
@property (nonatomic, assign, readonly) CGFloat verticalMeanVelocity;
//水平滑动平均速度
@property (nonatomic, assign, readonly) CGFloat horizontalMeanVelocity;

- (void)setupInitialPoint:(CGPoint)initialPoint;
@end

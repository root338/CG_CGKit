//
//  NSObject+Constant.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 常量数值
UIKIT_EXTERN const CGFloat            CGZeroFloatValue;

#pragma mark - 简单自动布局常量值
UIKIT_EXTERN const UIViewAutoresizing UIViewAutoresizingFlexibleAllMargin;

UIKIT_EXTERN const UIViewAutoresizing UIViewAutoresizingFlexibleSize;

@interface UIView (CGValueConstant)

@property (class, nonatomic, readonly) CGFloat onePixlesForCGKitUIScreenScale;

@end

//
//  UIView+CGSetupFrame.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 设置 view frame */
@interface UIView (CGSetupFrame)

#pragma mark - 坐标设置
@property (assign, nonatomic) CGFloat   xOrigin;
@property (assign, nonatomic) CGFloat   yOrigin;
@property (assign, nonatomic) CGPoint   origin;

@property (assign, nonatomic) CGFloat   xCenter;
@property (assign, nonatomic) CGFloat   yCenter;

#pragma mark - 大小设置
@property (assign, nonatomic) CGFloat   width;
@property (assign, nonatomic) CGFloat   height;
@property (assign, nonatomic) CGSize    size;

#pragma mark - 显示区域获取

@property (assign, nonatomic, readonly) CGFloat     midX;
@property (assign, nonatomic, readonly) CGFloat     midY;
@property (assign, nonatomic, readonly) CGFloat     minX;
@property (assign, nonatomic, readonly) CGFloat     minY;
@property (assign, nonatomic, readonly) CGFloat     maxX;
@property (assign, nonatomic, readonly) CGFloat     maxY;
@end

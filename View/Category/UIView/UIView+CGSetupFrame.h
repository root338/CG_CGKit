//
//  UIView+CGSetupFrame.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
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

#pragma mark
/** 
 *  设置view的中心坐标与为指定视图的中心
 *  @warning 坐标系统为指定视图的坐标系统
 */
- (void)cg_setupCenterWithView:(UIView *)paramView;

/**
 *  设置视图的显示区域
 *
 *  @param paramCenter 视图的中心坐标
 *  @param paramSize   视图的大小
 */
- (void)cg_setupFrameWithCenter:(CGPoint)paramCenter size:(CGSize)paramSize;

/** 获取视图在指定视图的中心点的坐标 */
- (CGPoint)cg_centerOriginWithTargetView:(UIView *)targetView;
/** 获取视图在父视图的中心点的坐标 */
- (CGPoint)cg_centerOrigin;

@end
NS_ASSUME_NONNULL_END
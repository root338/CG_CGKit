//
//  UIView+CGSetupAnimationArea.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMoveViewTypeHeader.h"

#import "CGAngleRadianHeader.h"

NS_ASSUME_NONNULL_BEGIN
/** 计算视图的移动坐标 */
@interface UIView (CGSetupAnimationArea)

- (void)cg_setupLineMovePointWithType:(CGLineMoveViewType)type overlayView:(UIView *)overlayView startPoint:(nullable CGPoint *)paramStartPoint endPoint:(nullable CGPoint *)paramEndPoint type:(CGLineMoveViewType)overlayViewType isShow:(CGAnimationDealWithTheWay)isShow;

- (void)cg_setupLineMovePointWithOverlayView:(UIView *)overlayView startPoint:(nullable CGPoint *)paramStartPoint endPoint:(nullable CGPoint *)paramEndPoint type:(CGLineMoveViewType)type isShow:(BOOL)isShow;

- (void)cg_setupScaleWithVertexPoint:(CGPoint *)paramVertexPoint type:(CGScaleViewType)type;

- (void)cg_setupScaleWithOverlayView:(nullable UIView *)overlayView vertexPoint:(CGPoint *)paramVertexPoint originPoint:(nullable CGPoint *)paramOriginPoint type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint;

@end
NS_ASSUME_NONNULL_END
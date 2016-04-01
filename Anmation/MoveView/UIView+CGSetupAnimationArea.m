//
//  UIView+CGSetupAnimationArea.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGSetupAnimationArea.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"

@implementation UIView (CGSetupAnimationArea)

- (void)cg_setupLineMovePointWithOverlayView:(UIView *)overlayView startPoint:(CGPoint *)paramStartPoint endPoint:(CGPoint *)paramEndPoint type:(CGLineMoveViewType)type isShow:(BOOL)isShow
{
    CGPoint startPoint  = CGPointZero;
    CGPoint endPoint    = CGPointZero;
    
    switch (type) {
        case CGLineMoveViewTypeTop:
        {
            startPoint  = CGPointMake(overlayView.xOrigin, overlayView.yOrigin - self.height);
            endPoint    = overlayView.origin;
        }
            break;
        case CGLineMoveViewTypeLeft:
        {
            startPoint  = CGPointMake(overlayView.xOrigin - self.width, overlayView.yOrigin);
            endPoint    = overlayView.origin;
        }
            break;
        case CGLineMoveViewTypeBottom:
        {
            startPoint  = CGPointMake(overlayView.xOrigin, overlayView.maxY);
            endPoint    = CGPointMake(overlayView.xOrigin, overlayView.maxY - self.height);
        }
            break;
        case CGLineMoveViewTypeRight:
        {
            startPoint  = CGPointMake(overlayView.maxX, overlayView.yOrigin);
            endPoint    = CGPointMake(overlayView.maxX - self.width, overlayView.yOrigin);
        }
            break;
        default:
            break;
    }
    
    if (isShow) {
        *paramStartPoint    = startPoint;
        *paramEndPoint      = endPoint;
    }else {
        *paramEndPoint      = startPoint;
    }
}

- (void)cg_setupScaleWithVertexPoint:(CGPoint *)paramVertexPoint type:(CGScaleViewType)type
{
    [self cg_setupScaleWithOverlayView:nil vertexPoint:paramVertexPoint originPoint:nil type:type offsetPoint:CGPointZero];
}

- (void)cg_setupScaleWithOverlayView:(nullable UIView *)overlayView vertexPoint:(CGPoint *)paramVertexPoint originPoint:(CGPoint *)paramOriginPoint type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint
{
    CGPoint vertexPoint = CGPointZero;
    CGPoint originPoint = CGPointZero;
    
    UIView *targetView  = overlayView ? overlayView : self;
    
    switch (type) {
        case CGScaleViewTypeCenterVertex:
        {
            vertexPoint = targetView.center;
            
            CGErrorConditionLog(CGPointEqualToPoint(CGPointZero, offsetPoint), @"中心坐标无法偏移");
        }
            break;
        case CGScaleViewTypeTopVertex:
        {
            vertexPoint = CGPointMake(targetView.midX + offsetPoint.x, targetView.yOrigin - offsetPoint.y);
        }
            break;
        case CGScaleViewTypeLeftVertex:
        {
            vertexPoint = CGPointMake(targetView.xOrigin - offsetPoint.x, targetView.midY + offsetPoint.y);
        }
            break;
        case CGScaleViewTypeBottomVertex:
        {
            vertexPoint = CGPointMake(targetView.midX + offsetPoint.x, targetView.maxY + offsetPoint.y);
        }
            break;
        case CGScaleViewTypeRightVertex:
        {
            vertexPoint = CGPointMake(targetView.maxX + offsetPoint.x, targetView.midY + offsetPoint.y);
        }
            break;
        case CGScaleViewTypeLeftTopVertex:
        {
            vertexPoint = CGPointMake(targetView.xOrigin - offsetPoint.x, targetView.yOrigin - offsetPoint.y);
        }
            break;
        case CGScaleViewTypeLeftBottomVertex:
        {
            vertexPoint = CGPointMake(targetView.xOrigin - offsetPoint.x, targetView.maxY + offsetPoint.y);
        }
            break;
        case CGScaleViewTypeRightBottomVertex:
        {
            vertexPoint = CGPointMake(targetView.maxX + offsetPoint.x, targetView.maxY + offsetPoint.y);
        }
            break;
        case CGScaleViewTypeRightTopVertex:
        {
            vertexPoint = CGPointMake(targetView.maxX + offsetPoint.x, targetView.yOrigin - offsetPoint.y);
        }
            break;
        default:
            break;
    }
    
    if (overlayView) {
        
        CGFloat midWidth    = self.width    / 2.0;
        CGFloat midHeight   = self.height   / 2.0;
        switch (type) {
//            case CGScaleViewTypeCenterVertex:
//            {
//                originPoint = targetView.origin;
//            }
//                break;
            case CGScaleViewTypeTopVertex:
            {
                originPoint = CGPointMake(vertexPoint.x - midWidth, vertexPoint.y - self.height);
            }
                break;
            case CGScaleViewTypeLeftVertex:
            {
                originPoint = CGPointMake(vertexPoint.x - self.width, vertexPoint.y - midHeight);
            }
                break;
            case CGScaleViewTypeBottomVertex:
            {
                originPoint = CGPointMake(vertexPoint.x - midWidth, vertexPoint.y);
            }
                break;
            case CGScaleViewTypeRightVertex:
            {
                originPoint = CGPointMake(vertexPoint.x, vertexPoint.y - midHeight);
            }
                break;
            case CGScaleViewTypeLeftTopVertex:
            {
                originPoint = CGPointMake(vertexPoint.x - self.width, vertexPoint.y - self.height);
            }
                break;
            case CGScaleViewTypeLeftBottomVertex:
            {
                originPoint = CGPointMake(vertexPoint.x - self.width, vertexPoint.y);
            }
                break;
            case CGScaleViewTypeRightBottomVertex:
            {
                originPoint = vertexPoint;
            }
                break;
            case CGScaleViewTypeRightTopVertex:
            {
                originPoint = CGPointMake(vertexPoint.x, vertexPoint.y - self.height);
            }
                break;
            default:
                break;
        }
    }
    
    if (paramVertexPoint != NULL) {
        *paramVertexPoint   = vertexPoint;
    }
    
    if (paramOriginPoint != NULL) {
        *paramOriginPoint   = originPoint;
    }
    
}
@end

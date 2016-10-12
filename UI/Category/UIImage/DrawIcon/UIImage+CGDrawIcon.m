//
//  UIImage+CGDrawIcon.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+CGDrawIcon.h"
#import "Value+Constant.h"
#import "CGAngleRadianHeader.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGArrowIconConfig.h"
#import "CGCloseIconConfig.h"

@import QuartzCore;

/** 绘制的图标类型 */
typedef NS_ENUM(NSInteger, CGImageICONDrawImageType) {
    
    CGImageICONDrawImageTypeArrow,
    CGImageICONDrawImageTypeClose,
};

@implementation UIImage (CGDrawIcon)

+ (UIImage *)drawArrowWithConfig:(CGArrowIconConfig *)arrowConfig
{
    UIImage *image  = [self drawType:CGImageICONDrawImageTypeArrow
                              config:arrowConfig];
    return image;
}

+ (UIImage *)drawCloseWithConfig:(CGCloseIconConfig *)closeConfig
{
    UIImage *closeImage = [self drawType:CGImageICONDrawImageTypeClose
                                  config:closeConfig];
    return closeImage;
}

+ (UIImage *)drawType:(CGImageICONDrawImageType)type config:(__kindof CGIconConfig *)config
{
    UIImage *image  = nil;
    
    __block CGSize canvasSize   = config.size;
    CGPathRef path              = NULL;
    
    void (^setupCanvasSizeBlock) (CGSize)   = ^(CGSize size) {
        
        canvasSize  = size;
    };
    
    switch (type) {
        case CGImageICONDrawImageTypeArrow:
        {
            path    = [self createArrowPathWith:config completion:setupCanvasSizeBlock];
        }
            break;
        case CGImageICONDrawImageTypeClose:
        {
            path    = [self createClosePathWith:config completion:setupCanvasSizeBlock];
        }
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContextWithOptions(canvasSize, config.opaque, config.scale);
    
    UIBezierPath *bezierPath    = [UIBezierPath bezierPathWithCGPath:path];
    bezierPath.lineJoinStyle    = config.lineJoinStyle;
    bezierPath.lineWidth        = config.lineWidth;
    if (config.miterLimit >= CGZeroFloatValue) {
        bezierPath.miterLimit   = config.miterLimit;
    }
    
//    if (config.backgroundColor != nil) {
//        [config.backgroundColor setFill];
//    }
    if (config.tintColor != nil) {
        [config.tintColor setStroke];
    }
    
    [bezierPath stroke];
    
    image   = UIGraphicsGetImageFromCurrentImageContext();
    
    CGPathRelease(path);
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGPathRef)createArrowPathWith:(CGArrowIconConfig *)config completion:(void (^) (CGSize size))completion
{
    CGPoint arrowVertex, leftVertex, rightVertex;
    CGPoint zeroPoint   = CGPointZero;
    CGFloat offset      = config.scale;
    
    CGPoint startPoint  = CGPointMake(config.marginEdgeInset.left, config.marginEdgeInset.top);
    CGSize  size        = CG_CGSizeWidthMaxSize(config.size, config.marginEdgeInset);
    
    CGFloat arrowVertexOffset   = 0;
    CGFloat angle   = config.angle / 2.0;
    
    //计算箭头尾部坐标时，垂直，水平距离值
    CGFloat horizontalValue = 0;
    CGFloat verticalValue   = size.height / 2.0;
    
    CGFloat verticalOffset  = 0;
    CGFloat horizontalOffset= 0;
    
    BOOL disableAdjustToSize    = NO;
    
    CGFloat radianValue         = _CG_RadianForAngle(angle);
    if (config.angle > CGZeroFloatValue) {
        
        horizontalValue = verticalValue / tan(radianValue);
        if (horizontalValue > size.width) {
            horizontalValue = size.width;
            verticalValue   = horizontalValue * tan(radianValue);
            verticalOffset  = (size.height - verticalValue * 2) / 2.0;
        }else {
            horizontalOffset    = (size.width - horizontalValue * 2) / 2.0;
        }
        
        if (arrowVertexOffset < CGZeroFloatValue) {
            //自动计算箭头顶点的偏移量，防止箭头出现平面截断
            arrowVertexOffset   = config.lineWidth * cos(radianValue);
        }
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.arrowVertex)) {
        
        CGPoint point   = CGPointZero;
        switch (config.orientationType) {
            case CGOrientationTypeLeft:
                point   = CGPointMake(0, size.height / 2.0);
                break;
            case CGOrientationTypeUp:
                point   = CGPointMake(size.width / 2.0, 0);
                break;
            case CGOrientationTypeRight:
                point   = CGPointMake(size.width, size.height / 2.0);
                break;
            case CGOrientationTypeDown:
                point   = CGPointMake(size.width / 2.0, size.height);
                break;
            default:
                break;
        }
        arrowVertex = point;
    }else {
        arrowVertex = config.arrowVertex;
        disableAdjustToSize = YES;
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.LeftVertex)) {
        
        CGFloat originY = verticalValue * 2 + verticalOffset;
        
        CGPoint point   = CGPointZero;
        switch (config.orientationType) {
            case CGOrientationTypeLeft:
                point   = CGPointMake(horizontalValue, originY);
                break;
            case CGOrientationTypeRight:
                point   = CGPointMake(horizontalValue + horizontalOffset * 2, originY);
                break;
            case CGOrientationTypeUp:
                point   = CGPointMake(horizontalOffset, verticalValue);
                break;
            case CGOrientationTypeDown:
                point   = CGPointMake(horizontalOffset, verticalValue + verticalOffset * 2);
                break;
            default:
                break;
        }
        leftVertex  = point;
        
    }else {
        leftVertex  = config.LeftVertex;
        disableAdjustToSize = YES;
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.rightVertex)) {
        
        CGFloat originY = verticalOffset;
        
        CGPoint point   = CGPointZero;
        
        switch (config.orientationType) {
            case CGOrientationTypeLeft:
                point   = CGPointMake(horizontalValue, originY);
                break;
            case CGOrientationTypeRight:
                point   = CGPointMake(horizontalValue + horizontalOffset * 2, originY);
                break;
            case CGOrientationTypeUp:
                point   = CGPointMake(horizontalValue * 2 + horizontalOffset, verticalValue);
                break;
            case CGOrientationTypeDown:
                point   = CGPointMake(horizontalValue * 2 + horizontalOffset, verticalValue + verticalOffset * 2);
                break;
            default:
                break;
        }
            
        rightVertex = point;
        
        
    }else {
        rightVertex = config.rightVertex;
        disableAdjustToSize = YES;
    }
    
    if (config.disableAdjustToSize) {
        disableAdjustToSize = YES;
    }
    
    CGFloat horizontalSpaceValue    = 0;
    CGFloat verticalSpaceValue      = 0;
    
    if (!disableAdjustToSize) {
        horizontalSpaceValue    = (arrowVertexOffset + offset);
        verticalSpaceValue      = offset;
    }
    
    CGFloat offsetX = startPoint.x + horizontalSpaceValue;
    CGFloat offsetY = startPoint.y + verticalSpaceValue;
    
    leftVertex  = CGPointMake(leftVertex.x + offsetX, leftVertex.y + offsetY);
    rightVertex = CGPointMake(rightVertex.x + offsetX, rightVertex.y + offsetY);
    arrowVertex = CGPointMake(arrowVertex.x + offsetX, arrowVertex.y + offsetY);
    
    if (completion) {
        completion(CGSizeMake(config.size.width + horizontalSpaceValue * 2, config.size.height + verticalSpaceValue * 2));
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftVertex.x, leftVertex.y);
    CGPathAddLineToPoint(path, NULL, arrowVertex.x, arrowVertex.y);
    CGPathAddLineToPoint(path, NULL, rightVertex.x, rightVertex.y);
    
    return path;
}

+ (CGPathRef)createClosePathWith:(CGCloseIconConfig *)config completion:(void (^) (CGSize size))completion
{
    CGPoint startPoint  = CGPointMake(config.marginEdgeInset.left, config.marginEdgeInset.top);
    CGSize drawSize     = CG_CGSizeWidthMaxSize(config.size, config.marginEdgeInset);
    
    CGPoint line1StartPoint = CGPointZero;
    CGPoint line1EndPoint   = CGPointZero;
    CGPoint line2StartPoint = CGPointZero;
    CGPoint line2EndPoint   = CGPointZero;
    
    if (config.angle < CGZeroFloatValue) {
        line1EndPoint   = CGPointMake(drawSize.width, drawSize.height);
        line2StartPoint = CGPointMake(drawSize.width, 0);
        line2EndPoint   = CGPointMake(0, drawSize.height);
    }else {
        
        CGFloat angle   = _CG_RadianForAngle(config.angle / 2.0);
        CGFloat horizontalValue = drawSize.width / 2.0;
        CGFloat verticalValue   = 0;
        
        CGFloat horizontalOffset    = 0;
        CGFloat verticalOffset      = 0;
        
        verticalValue   = horizontalValue / tan(angle);
        if (verticalValue > drawSize.height / 2.0) {
            verticalValue   = drawSize.height / 2.0;
            horizontalValue = verticalValue * tan(angle);
            horizontalOffset    = drawSize.width / 2.0 - horizontalValue;
        }else {
            verticalOffset  = drawSize.height / 2.0 - verticalValue;
        }
        
        line1StartPoint = CGPointMake(horizontalOffset, verticalOffset);
        line1EndPoint   = CGPointMake(horizontalOffset + horizontalValue * 2, verticalOffset + verticalValue * 2);
        line2StartPoint = CGPointMake(horizontalOffset + horizontalValue * 2, verticalOffset);
        line2EndPoint   = CGPointMake(horizontalOffset, verticalOffset + verticalValue * 2);
    }
    
    CGFloat offset  = 0;
    if (!config.disableAdjustToSize) {
        offset      = config.scale;
        startPoint  = CG_CGPointWithOffset(startPoint, offset, offset);
    }
    
    line1StartPoint = CG_CGPointWithOffsetPoint(line1StartPoint, startPoint);
    line1EndPoint   = CG_CGPointWithOffsetPoint(line1EndPoint, startPoint);
    line2StartPoint = CG_CGPointWithOffsetPoint(line2StartPoint, startPoint);
    line2EndPoint   = CG_CGPointWithOffsetPoint(line2EndPoint, startPoint);
    
    if (completion) {
        completion(CGSizeMake(config.size.width + offset * 2, config.size.height + offset * 2));
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, line1StartPoint.x, line1StartPoint.y);
    CGPathAddLineToPoint(path, NULL, line1EndPoint.x, line1EndPoint.y);
    CGPathMoveToPoint(path, NULL, line2StartPoint.x, line2StartPoint.y);
    CGPathAddLineToPoint(path, NULL, line2EndPoint.x, line2EndPoint.y);
    
    return path;
}

@end

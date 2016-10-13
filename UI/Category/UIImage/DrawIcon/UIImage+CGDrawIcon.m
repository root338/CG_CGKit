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
#import "CGRefreshIconConfig.h"

@import QuartzCore;

/** 绘制的图标类型 */
typedef NS_ENUM(NSInteger, CGImageICONDrawImageType) {
    
    CGImageICONDrawImageTypeArrow,
    CGImageICONDrawImageTypeClose,
    CGImageICONDrawImageTypeRefresh,
};

@implementation UIImage (CGDrawIcon)

+ (UIImage *)drawArrowWithConfig:(CGArrowIconConfig *)arrowIconConfig
{
    UIImage *image  = [self drawType:CGImageICONDrawImageTypeArrow
                              config:arrowIconConfig];
    return image;
}

+ (UIImage *)drawCloseWithConfig:(CGCloseIconConfig *)closeIconConfig
{
    UIImage *closeImage = [self drawType:CGImageICONDrawImageTypeClose
                                  config:closeIconConfig];
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
    
    if (path != NULL) {
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, config.opaque, config.scale);
        
        UIBezierPath *bezierPath    = [self createBezierPathWithCGPath:path config:config];
        [bezierPath stroke];
        
        image   = UIGraphicsGetImageFromCurrentImageContext();
        CGPathRelease(path);
        UIGraphicsEndImageContext();
    }
    
    return image;
}

+ (UIBezierPath *)createBezierPathWithCGPath:(nullable CGPathRef)path config:(CGIconConfig *)config
{
    
    UIBezierPath *bezierPath    = nil;
    if (path == NULL) {
        bezierPath  = [UIBezierPath bezierPath];
    }else {
        bezierPath  = [UIBezierPath bezierPathWithCGPath:path];;
    }
    
    bezierPath.lineJoinStyle    = config.lineJoinStyle;
    bezierPath.lineWidth        = config.lineWidth;
    if (config.miterLimit >= CGZeroFloatValue) {
        bezierPath.miterLimit   = config.miterLimit;
    }
    
    if (config.tintColor != nil) {
        [config.tintColor setStroke];
    }
    
    return bezierPath;
}

+ (CGPathRef)createArrowPathWith:(CGArrowIconConfig *)config completion:(void (^) (CGSize size))completion
{
    
    CGPoint arrowVertex, leftVertex, rightVertex;
    
    CGFloat angle       = config.angle / 2.0;
    CGFloat radianValue = _CG_RadianForAngle(angle);
    CGPoint zeroPoint   = CGPointZero;
    CGFloat offset      = config.lineWidth * cos(radianValue);
    
    CGPoint startPoint  = CGPointMake(config.marginEdgeInset.left, config.marginEdgeInset.top);
    CGSize  size        = config.canvasAvailableSize;
    
    //计算箭头尾部坐标时，垂直，水平距离值
    CGFloat horizontalValue = 0;
    CGFloat verticalValue   = size.height / 2.0;
    
    CGFloat verticalOffset  = 0;
    CGFloat horizontalOffset= 0;
    
    BOOL disableAdjustToSize    = NO;
    
    if (config.angle > CGZeroFloatValue) {
        
        horizontalValue = verticalValue / tan(radianValue);
        if (horizontalValue > size.width) {
            horizontalValue = size.width;
            verticalValue   = horizontalValue * tan(radianValue);
            verticalOffset  = (size.height - verticalValue * 2) / 2.0;
        }else {
            horizontalOffset    = (size.width - horizontalValue * 2) / 2.0;
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
        horizontalSpaceValue    = offset;
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
    CGSize drawSize     = config.canvasAvailableSize;
    
    CGPoint line1StartPoint = CGPointZero;
    CGPoint line1EndPoint   = CGPointZero;
    CGPoint line2StartPoint = CGPointZero;
    CGPoint line2EndPoint   = CGPointZero;
    
    CGFloat radian          = _CG_RadianForAngle(config.angle / 2.0);
    
    CGFloat horizontalValue = drawSize.width / 2.0;
    CGFloat verticalValue   = 0;
    
    CGFloat horizontalOffset    = 0;
    CGFloat verticalOffset      = 0;
    
    verticalValue   = horizontalValue / tan(radian);
    if (verticalValue > drawSize.height / 2.0) {
        verticalValue   = drawSize.height / 2.0;
        horizontalValue = verticalValue * tan(radian);
        horizontalOffset    = drawSize.width / 2.0 - horizontalValue;
    }else {
        verticalOffset  = drawSize.height / 2.0 - verticalValue;
    }
    
    line1StartPoint = CGPointMake(horizontalOffset, verticalOffset);
    line1EndPoint   = CGPointMake(horizontalOffset + horizontalValue * 2, verticalOffset + verticalValue * 2);
    line2StartPoint = CGPointMake(horizontalOffset + horizontalValue * 2, verticalOffset);
    line2EndPoint   = CGPointMake(horizontalOffset, verticalOffset + verticalValue * 2);
    
    CGFloat offset  = 0;
    if (!config.disableAdjustToSize) {
        offset      = config.lineWidth * cos(radian);
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

+ (UIImage *)drawRefreshImageWithConfig:(CGRefreshIconConfig *)config
{
    
    CGFloat sideValue       = config.arrowWidth / 2.0;
    CGFloat angle           = 360.0 - (config.endAngle - (floor(config.endAngle / 360) * 360));
    CGFloat radian          = _CG_RadianForAngle(angle);
    
    CGFloat refreshArrowHorizontalValue = fabs(sin(radian) * sideValue);
    CGFloat refreshArrowVerticalValue   = fabs(cos(radian) * sideValue);
    CGSize drawSize         = CGSizeMake(config.canvasAvailableSize.width - refreshArrowHorizontalValue, config.canvasAvailableSize.height - refreshArrowVerticalValue);
    
    CGPoint circleCenter    = CG_CGCenterWithSize(drawSize);
    CGFloat radius          = MIN(drawSize.width, drawSize.height) / 2.0;
    CGFloat circleCenterHorizontalOffset    = drawSize.width / 2.0 - radius;
    CGFloat circleCenterVerticalOffset      = drawSize.height / 2.0 - radius;
    
    CGFloat offset      = 0;
    CGPoint startPoint  = config.drawStartPoint;
    if (!config.disableAdjustToSize) {
        
        offset      = MAX( fabs(config.lineWidth * cos(radian)), config.lineWidth / 2.0);
        startPoint  = CG_CGPointWithOffset(startPoint, offset, offset);
    }
    
    circleCenter    = CG_CGPointWithOffsetPoint(circleCenter, startPoint);
    
    CGFloat horizontalValue = fabs(cos(radian) * radius);
    CGFloat verticalValue   = fabs(sin(radian) * radius);
    
    CGFloat arrowVertexLenght           = sqrt(pow(sideValue * 2, 2) - pow(sideValue, 2));
    CGFloat arrowVertexHorizonalValue   = fabs(sin(radian) * arrowVertexLenght);
    CGFloat arrowVertexVerticalValue    = fabs(cos(radian) * arrowVertexLenght);
    
    CGFloat vertexSinValue   = fabs(sin(radian) * sideValue);
    CGFloat vertexCosValue     = fabs(cos(radian) * sideValue);
    
    CGPoint vertex1Point    = CGPointZero;
    CGPoint vertex2Point    = CGPointZero;
    CGPoint vertex3Point    = CGPointZero;
    
    if (angle >= 0 && angle < 90) {
        
        CGFloat vertexOriginX   = circleCenterHorizontalOffset + radius + horizontalValue;
        CGFloat vertexOriginY   = circleCenterVerticalOffset + radius - verticalValue;
        
        vertex1Point    = CGPointMake(vertexOriginX + arrowVertexHorizonalValue, vertexOriginY + arrowVertexVerticalValue);
        vertex2Point    = CGPointMake(vertexOriginX - vertexCosValue, vertexOriginY + vertexSinValue);
        vertex3Point    = CGPointMake(vertexOriginX + vertexCosValue, vertexOriginY - vertexSinValue);
    }else if (angle >= 90 && angle < 180) {
        CGFloat vertexOriginX   = circleCenterHorizontalOffset + radius - horizontalValue;
        CGFloat vertexOriginY   = circleCenterVerticalOffset + radius - verticalValue;
        
        vertex1Point    = CGPointMake(vertexOriginX + arrowVertexHorizonalValue, vertexOriginY - arrowVertexVerticalValue);
        vertex2Point    = CGPointMake(vertexOriginX + vertexCosValue, vertexOriginY + vertexSinValue);
        vertex3Point    = CGPointMake(vertexOriginX - vertexCosValue, vertexOriginY - vertexSinValue);
    }else if (angle >= 180 && angle < 270) {
        CGFloat vertexOriginX   = circleCenterHorizontalOffset + radius - horizontalValue;
        CGFloat vertexOriginY   = circleCenterVerticalOffset + radius + verticalValue;
        
        vertex1Point    = CGPointMake(vertexOriginX - arrowVertexHorizonalValue, vertexOriginY - arrowVertexVerticalValue);
        vertex2Point    = CGPointMake(vertexOriginX + vertexCosValue, vertexOriginY - vertexSinValue);
        vertex3Point    = CGPointMake(vertexOriginX - vertexCosValue, vertexOriginY + vertexSinValue);
    }else if (angle >= 270 && angle <= 360) {
        
        CGFloat vertexOriginX   = circleCenterHorizontalOffset + radius + horizontalValue;
        CGFloat vertexOriginY   = circleCenterVerticalOffset + radius + verticalValue;
        
        vertex1Point    = CGPointMake(vertexOriginX - arrowVertexHorizonalValue, vertexOriginY + arrowVertexVerticalValue);
        vertex2Point    = CGPointMake(vertexOriginX - vertexCosValue, vertexOriginY - vertexSinValue);
        vertex3Point    = CGPointMake(vertexOriginX + vertexCosValue, vertexOriginY + vertexSinValue);
    }
    
    vertex1Point    = CG_CGPointWithOffsetPoint(vertex1Point, startPoint);
    vertex2Point    = CG_CGPointWithOffsetPoint(vertex2Point, startPoint);
    vertex3Point    = CG_CGPointWithOffsetPoint(vertex3Point, startPoint);
    
    CGSize canvasSize = CGSizeMake(config.size.width + offset * 2, config.size.height + offset * 2);
    UIGraphicsBeginImageContextWithOptions(canvasSize, config.opaque, config.scale);
    
    CGMutablePathRef path1      = CGPathCreateMutable();
    CGPathAddArc(path1, NULL, circleCenter.x, circleCenter.y, radius, _CG_RadianForAngle(config.startAngle), _CG_RadianForAngle(config.endAngle), NO);
    UIBezierPath *bezierPath    = [self createBezierPathWithCGPath:path1 config:config];
    [bezierPath stroke];
    CGPathRelease(path1);
    
    CGMutablePathRef path       = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, vertex1Point.x, vertex1Point.y);
    CGPathAddLineToPoint(path, NULL, vertex2Point.x, vertex2Point.y);
    CGPathAddLineToPoint(path, NULL, vertex3Point.x, vertex3Point.y);
    UIBezierPath *bezierPath2   = [self createBezierPathWithCGPath:path config:config];
    [config.tintColor setFill];
    [bezierPath2 fill];
    CGPathRelease(path);
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end

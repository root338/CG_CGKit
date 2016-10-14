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
    
    switch (type) {
        case CGImageICONDrawImageTypeArrow:
        {
            path    = [self createArrowPathWith:config];
        }
            break;
        case CGImageICONDrawImageTypeClose:
        {
            path    = [self createClosePathWith:config];
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

+ (CGPathRef)createArrowPathWith:(CGArrowIconConfig *)config
{
    
    CGPoint arrowVertex, leftVertex, rightVertex;
    
    CGFloat angle       = config.angle / 2.0;
    CGFloat radianValue = _CG_RadianForAngle(angle);
    CGPoint zeroPoint   = CGPointZero;
    CGPoint offsetPoint = CGPointZero;
    CGFloat lineWidth   = config.lineWidth;
    
    CGPoint startPoint  = config.drawStartPoint;
    
    CGFloat radianSinValue  = fabs(sin(radianValue));
    CGFloat radianCosValue  = fabs(cos(radianValue));
    CGFloat radianTanValue  = fabs(tan(radianValue));
    
    BOOL isHorizontalType   = (config.orientationType == CGOrientationTypeLeft || config.orientationType == CGOrientationTypeRight);
    
    if (isHorizontalType) {
        
        offsetPoint = CGPointMake(lineWidth / radianCosValue, lineWidth / radianSinValue);
        startPoint  = CG_CGPointWithOffset(startPoint, offsetPoint.x, offsetPoint.y / 2);
    }else {
        
        CGFloat length  = lineWidth / radianTanValue;
        offsetPoint = CGPointMake(length * radianSinValue, length * radianCosValue);
        startPoint  = CG_CGPointWithOffset(startPoint, offsetPoint.x / 2, offsetPoint.y);
    }
    
    CGSize  size        = CGSizeMake(config.canvasAvailableSize.width - startPoint.x * 2, config.canvasAvailableSize.height - startPoint.y);
    
    //计算箭头尾部坐标时，垂直，水平距离值
    CGFloat horizontalValue = 0;
    CGFloat verticalValue   = size.height / 2.0;
    
    CGFloat verticalOffset  = 0;
    CGFloat horizontalOffset= 0;
    
    if (config.angle > CGZeroFloatValue) {
        
        if (isHorizontalType) {
            horizontalValue = verticalValue / radianTanValue;
        }else {
            horizontalValue = verticalValue * radianTanValue;
        }
        
        if (horizontalValue > size.width) {
            horizontalValue = size.width;
            if (isHorizontalType) {
                verticalValue   = horizontalValue * radianTanValue;
            }else {
                verticalValue   = horizontalValue / radianTanValue;
            }
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
    }
    
    CGFloat offsetX = startPoint.x;
    CGFloat offsetY = startPoint.y;
    
    leftVertex  = CGPointMake(leftVertex.x + offsetX, leftVertex.y + offsetY);
    rightVertex = CGPointMake(rightVertex.x + offsetX, rightVertex.y + offsetY);
    arrowVertex = CGPointMake(arrowVertex.x + offsetX, arrowVertex.y + offsetY);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftVertex.x, leftVertex.y);
    CGPathAddLineToPoint(path, NULL, arrowVertex.x, arrowVertex.y);
    CGPathAddLineToPoint(path, NULL, rightVertex.x, rightVertex.y);
    
    return path;
}

+ (CGPathRef)createClosePathWith:(CGCloseIconConfig *)config
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
    
    CGFloat offset  = offset      = config.lineWidth * cos(radian);
    startPoint  = CG_CGPointWithOffset(startPoint, offset, offset);
    
    line1StartPoint = CG_CGPointWithOffsetPoint(line1StartPoint, startPoint);
    line1EndPoint   = CG_CGPointWithOffsetPoint(line1EndPoint, startPoint);
    line2StartPoint = CG_CGPointWithOffsetPoint(line2StartPoint, startPoint);
    line2EndPoint   = CG_CGPointWithOffsetPoint(line2EndPoint, startPoint);
    
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
    CGFloat offset          = MAX(fabs(config.lineWidth * cos(radian)), config.lineWidth / 2.0);
    CGPoint startPoint      = CG_CGPointWithOffset(config.drawStartPoint, offset, offset);
    
    CGFloat refreshArrowOffset  = (config.arrowWidth - config.lineWidth) / 2.0;
    CGSize drawSize         = CGSizeMake(config.canvasAvailableSize.width - refreshArrowOffset * 2 - offset * 2, config.canvasAvailableSize.height - refreshArrowOffset * 2 - offset * 2);
    
    CGPoint circleCenter    = CG_CGCenterWithSize(drawSize);
    CGFloat radius          = MIN(drawSize.width, drawSize.height) / 2.0;
    CGFloat circleCenterHorizontalOffset    = drawSize.width / 2.0 - radius;
    CGFloat circleCenterVerticalOffset      = drawSize.height / 2.0 - radius;
    
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
    
    startPoint      = CG_CGPointWithOffset(startPoint, refreshArrowOffset, refreshArrowOffset);
    
    vertex1Point    = CG_CGPointWithOffsetPoint(vertex1Point, startPoint);
    vertex2Point    = CG_CGPointWithOffsetPoint(vertex2Point, startPoint);
    vertex3Point    = CG_CGPointWithOffsetPoint(vertex3Point, startPoint);
    
    circleCenter    = CG_CGPointWithOffsetPoint(circleCenter, startPoint);
    
    CGSize canvasSize = CGSizeMake(config.size.width, config.size.height);
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

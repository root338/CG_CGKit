//
//  UIImage+CGDrawIcon.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+CGDrawIcon.h"
#import "UIView+Constant.h"
#import "CGAngleRadianHeader.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGArrowIconConfig.h"
#import "CGCloseIconConfig.h"
#import "CGRefreshIconConfig.h"

@import QuartzCore;

typedef void (^CGDrawImageResetSizeBlock) (CGSize size);

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
    
    CGDrawImageResetSizeBlock resetSizeBlock    = ^(CGSize size) {
        
        canvasSize  = size;
    };
    
    switch (type) {
        case CGImageICONDrawImageTypeArrow:
        {
            path    = [self createArrowPathWith:config completion:resetSizeBlock];
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

+ (CGPathRef)createArrowPathWith:(CGArrowIconConfig *)config completion:(CGDrawImageResetSizeBlock)completion
{
    
    CGPathRef (^createArrowPathBlock) (CGPoint, CGPoint, CGPoint)  = ^(CGPoint arrowVertex, CGPoint leftVertex, CGPoint rightVertex) {
        
        CGPathRef path              = NULL;
        
        CGMutablePathRef mutablePath    = CGPathCreateMutable();
        CGPathMoveToPoint(mutablePath, NULL, leftVertex.x, leftVertex.y);
        CGPathAddLineToPoint(mutablePath, NULL, arrowVertex.x, arrowVertex.y);
        CGPathAddLineToPoint(mutablePath, NULL, rightVertex.x, rightVertex.y);
        path    = mutablePath;
        return path;
    };
    
    if (config.configType == CGArrowIconConfigTypeFixedPoint) {
        
        return createArrowPathBlock(config.arrowVertex, config.LeftVertex, config.rightVertex);
    }
    
    CGSize canvasAvailableSize  = config.canvasAvailableSize;
    CGPoint startPoint          = config.drawStartPoint;
    
    CGFloat angle               = config.angle / 2.0;
    CGFloat radian              = _CG_RadianForAngle(angle);
    
    CGFloat radianTanValue      = tan(radian);
    
    BOOL isHorizontalDraw    = (config.arrowVertexOrientationType == CGOrientationTypeLeft |
                                   config.arrowVertexOrientationType == CGOrientationTypeRight);
    //是否以height进行计算
    BOOL isAvailableVertical    = YES;
    
    {
        //计算以哪一边进行计算
        if (isHorizontalDraw) {
            if ((canvasAvailableSize.height / 2.0) / radianTanValue > canvasAvailableSize.width) {
                isAvailableVertical = NO;
            }
        }else {
            if (canvasAvailableSize.height * radianTanValue > canvasAvailableSize.width / 2.0) {
                isAvailableVertical = NO;
            }
        }
    }
    
    CGFloat horizontalTotalValue    = 0;
    CGFloat verticalTotalValue      = 0;
    {
        CGFloat radianSinValue      = sin(radian);
        CGFloat radianCosValue      = cos(radian);
        
        //箭头需要的空间
        CGFloat lineWidth           = config.lineWidth;
        CGFloat arrowVertexLenght   = 0;
        //角度空余空间计算
        arrowVertexLenght   = lineWidth / radianSinValue / 2.0;
        
        CGFloat vOffset     = 0;
        CGFloat hOffset     = 0;
        CGPoint offset      = CGPointZero;
        
        if (isHorizontalDraw) {
            hOffset = lineWidth * radianSinValue / 2.0;
            vOffset = lineWidth * radianCosValue / 2.0;
            
            if (config.arrowVertexOrientationType == CGOrientationTypeLeft) {
                offset  = CGPointMake(arrowVertexLenght, vOffset);
            }else {
                offset  = CGPointMake(hOffset, vOffset);
            }
            horizontalTotalValue    = arrowVertexLenght + hOffset;
            verticalTotalValue      = vOffset * 2;
        }else {
            hOffset = lineWidth * radianCosValue / 2.0;
            vOffset = lineWidth * radianSinValue / 2.0;
            if (config.arrowVertexOrientationType == CGOrientationTypeUp) {
                offset  = CGPointMake(hOffset, arrowVertexLenght);
            }else {
                offset  = CGPointMake(hOffset, vOffset);
            }
            
            horizontalTotalValue    = hOffset * 2;
            verticalTotalValue      = arrowVertexLenght + vOffset;
        }
        
        startPoint  = CG_CGPointWithOffsetPoint(startPoint, offset);
        canvasAvailableSize = CGSizeMake(canvasAvailableSize.width - horizontalTotalValue, canvasAvailableSize.height - verticalTotalValue);
        
    }
    
    CGFloat horizontalValue     = 0;
    CGFloat verticalValue       = 0;
    CGFloat horizontalOffset    = 0;
    CGFloat verticalOffset      = 0;
    
    if (isHorizontalDraw) {
        if (isAvailableVertical) {
            verticalValue   = canvasAvailableSize.height / 2.0;
            horizontalValue = verticalValue / radianTanValue;
            
            if (config.configType == CGArrowIconConfigTypeDefaultCropOverSize) {
                canvasAvailableSize.width = horizontalValue;
            }else {
                horizontalOffset    = canvasAvailableSize.width - horizontalValue;
            }
        }else {
            horizontalValue = canvasAvailableSize.width;
            verticalValue   = horizontalValue * radianTanValue;
            
            if (config.configType == CGArrowIconConfigTypeDefaultCropOverSize) {
                
                canvasAvailableSize.height  = verticalValue * 2;
            }else {
                
                verticalOffset  = canvasAvailableSize.height / 2.0 - verticalValue;
            }
        }
    }else {
        if (isAvailableVertical) {
            verticalValue   = canvasAvailableSize.height;
            horizontalValue = verticalValue * radianTanValue;
            
            if (config.configType == CGArrowIconConfigTypeDefaultCropOverSize) {
                
                canvasAvailableSize.width   = horizontalValue * 2;
            }else {
                horizontalOffset    = canvasAvailableSize.width / 2.0 - horizontalValue;
            }
        }else {
            horizontalValue = canvasAvailableSize.width / 2.0;
            verticalValue   = horizontalValue / radianTanValue;
            
            if (config.configType == CGArrowIconConfigTypeDefaultCropOverSize) {
                
                canvasAvailableSize.height  = verticalValue;
            }else {
                verticalOffset  = canvasAvailableSize.height - verticalValue;
            }
        }
    }
    
    if (config.configType == CGArrowIconConfigTypeDefaultCropOverSize && completion) {
        completion(CGSizeMake(canvasAvailableSize.width + horizontalTotalValue + config.marginEdgeInset.left + config.marginEdgeInset.right, canvasAvailableSize.height + verticalTotalValue + config.marginEdgeInset.top + config.marginEdgeInset.bottom));
    }
    
    CGPoint arrowVertex, leftVertex, rightVertex;
    switch (config.arrowVertexOrientationType) {
        case CGOrientationTypeUp:
            arrowVertex = CGPointMake(canvasAvailableSize.width / 2.0, 0);
            leftVertex  = CGPointMake(horizontalOffset, verticalValue);
            rightVertex = CGPointMake(horizontalValue * 2 + horizontalOffset, verticalValue);
            break;
        case CGOrientationTypeDown:
            arrowVertex = CGPointMake(canvasAvailableSize.width / 2.0, canvasAvailableSize.height);
            leftVertex  = CGPointMake(horizontalOffset, verticalOffset);
            rightVertex = CGPointMake(horizontalValue * 2 + horizontalOffset, verticalOffset);
            break;
        case CGOrientationTypeLeft:
            arrowVertex = CGPointMake(0, canvasAvailableSize.height / 2.0);
            leftVertex  = CGPointMake(horizontalValue, verticalValue * 2.0 + verticalOffset);
            rightVertex = CGPointMake(horizontalValue, verticalOffset);
            break;
        case CGOrientationTypeRight:
            arrowVertex = CGPointMake(canvasAvailableSize.width, canvasAvailableSize.height / 2.0);
            leftVertex  = CGPointMake(horizontalOffset, verticalValue * 2.0 + verticalOffset);
            rightVertex = CGPointMake(horizontalOffset, verticalOffset);
            break;
        default:
            arrowVertex = CGPointZero;
            leftVertex  = CGPointZero;
            rightVertex = CGPointZero;
            break;
    }
    
    arrowVertex = CG_CGPointWithOffsetPoint(arrowVertex, startPoint);
    leftVertex  = CG_CGPointWithOffsetPoint(leftVertex, startPoint);
    rightVertex = CG_CGPointWithOffsetPoint(rightVertex, startPoint);
    
    return createArrowPathBlock(arrowVertex, leftVertex, rightVertex);
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

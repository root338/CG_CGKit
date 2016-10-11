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

#import "CGArrowIconConfig.h"
#import "CGCloseIconConfig.h"

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
    UIImage *closeImage = [self drawType:CGImageICONDrawImageTypeArrow
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
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint arrowVertex, leftVertex, rightVertex;
    CGPoint zeroPoint   = CGPointZero;
    CGFloat offset      = config.scale;
    CGSize  size        = CGSizeMake(config.size.width, config.size.height);
    CGFloat arrowVertexOffset   = config.arrowVertexOffset;
    CGFloat length  = size.height / 2.0;
    CGFloat angle   = 0;
    CGFloat originX = 0;
    BOOL disableAdjustToSize   = NO;
    
    if (config.angle > CGZeroFloatValue) {
        angle   = config.angle / 2.0;
        originX = length / tan(_CG_RadianForAngle(angle));
        
        if (arrowVertexOffset < CGZeroFloatValue) {
            //自动计算箭头顶点的偏移量，防止箭头出现平面截断
            arrowVertexOffset   = config.lineWidth * cos(_CG_RadianForAngle(angle));
        }
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.arrowVertex)) {
        arrowVertex = CGPointMake(0, size.height / 2.0);
    }else {
        arrowVertex = config.arrowVertex;
        disableAdjustToSize = YES;
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.LeftVertex)) {
        
        CGFloat originY = size.height;
        if (config.angle < CGZeroFloatValue) {
            leftVertex  = CGPointMake(size.width, originY);
        }else {
            
            leftVertex  = CGPointMake(originX, originY);
        }
        
    }else {
        leftVertex  = config.LeftVertex;
        disableAdjustToSize = YES;
    }
    
    if (CGPointEqualToPoint(zeroPoint, config.rightVertex)) {
        
        CGFloat originY = 0;
        if (config.angle < CGZeroFloatValue) {
            
            rightVertex = CGPointMake(size.width, originY);
        }else {
            
            rightVertex = CGPointMake(originX, originY);
        }
        
    }else {
        rightVertex = config.rightVertex;
        disableAdjustToSize = YES;
    }
    
    if (config.disableAdjustToSize) {
        disableAdjustToSize = YES;
    }
    
    if (!disableAdjustToSize) {
        CGFloat offsetX = arrowVertexOffset + offset;
        leftVertex  = CGPointMake(leftVertex.x + offsetX, leftVertex.y + offset);
        rightVertex = CGPointMake(rightVertex.x + offsetX, rightVertex.y + offset);
        arrowVertex = CGPointMake(arrowVertex.x + offsetX, arrowVertex.y + offset);
        
        if (completion && !config.disableAdjustToSize) {
            completion(CGSizeMake(config.size.width + offsetX + offset, config.size.height + offset * 2));
        }
    }
    
    CGPathMoveToPoint(path, NULL, leftVertex.x, leftVertex.y);
    CGPathAddLineToPoint(path, NULL, arrowVertex.x, arrowVertex.y);
    CGPathAddLineToPoint(path, NULL, rightVertex.x, rightVertex.y);
    
    return path;
}

+ (CGPathRef)createClosePathWith:(CGCloseIconConfig *)config completion:(void (^) (CGSize size))completion
{
    return NULL;
}

@end

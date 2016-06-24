//
//  UIImage+CGDrawAlertArrow.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/23.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGDrawAlertArrow.h"

@implementation UIImage (CGDrawAlertArrow)

+ (UIImage *)cg_drawAlertArrowSide:(CGDrawAlertArrowSide)arrowSide
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(25, 25), NO, 1.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithWhite:0 alpha:0.7].CGColor);
//    CGContextSetStrokeColorWithColor(contextRef, [UIColor colorWithWhite:0 alpha:0.7].CGColor);
    
    CGContextSetShouldAntialias(contextRef, YES);
    CGContextSetAllowsAntialiasing(contextRef, YES);
    
//    CGContextSetAlpha(contextRef, 0.7);
    
    CGMutablePathRef pathRef    = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 25 / 2.0, 0);
    CGPathAddLineToPoint(pathRef, NULL, 25, 0);
    CGPathAddLineToPoint(pathRef, NULL, 25, 25);
    CGPathAddLineToPoint(pathRef, NULL, 25 / 2.0, 0);
    
    CGContextAddPath(contextRef, pathRef);
    CGContextDrawPath(contextRef, kCGPathFill);
    
    CGPathRelease(pathRef);
    
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end

//
//  UIImage+CGImageRotate.m
//  TestCG_CGKit
//
//  Created by DY on 2016/10/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+CGImageRotate.h"

@implementation UIImage (CGImageRotate)

- (UIImage *)rotateImageWithType:(CGImageRotateType)rotateType
{
    UIImageOrientation toOrientation    = 0;
    switch (rotateType) {
        case CGImageRotateTypeClockwiseRotate_90_Degrees:
            toOrientation   = [self toOrientationIsClockwise_90_Degrees];
            break;
        case CGImageRotateTypeCounterclockwiseRotate_90_Degrees:
            toOrientation   = [self toOrientationIsCounterclockwise_90_Degrees];
            break;
        case CGImageRotateTypeRotate_180_Degrees:
            toOrientation   = [self toOrientation_180_Degrees];
            break;
        default:
            break;
    }
    
    return [self imageToOrientation:toOrientation];
}

- (UIImage *)imageToOrientation:(UIImageOrientation)orientation
{
    return [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:orientation];
}

- (UIImageOrientation)toOrientationIsClockwise_90_Degrees
{
    UIImageOrientation toOrientation    = 0;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            toOrientation   = UIImageOrientationRight;
            break;
        case UIImageOrientationRight:
            toOrientation   = UIImageOrientationDown;
            break;
        case UIImageOrientationDown:
            toOrientation   = UIImageOrientationLeft;
            break;
        case UIImageOrientationLeft:
            toOrientation   = UIImageOrientationUp;
            break;
        case UIImageOrientationUpMirrored:
            toOrientation   = UIImageOrientationRightMirrored;
            break;
        case UIImageOrientationRightMirrored:
            toOrientation   = UIImageOrientationDownMirrored;
            break;
        case UIImageOrientationDownMirrored:
            toOrientation   = UIImageOrientationLeftMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            toOrientation   = UIImageOrientationUpMirrored;
            break;
        default:
            break;
    }
    return toOrientation;
}

- (UIImageOrientation)toOrientationIsCounterclockwise_90_Degrees
{
    UIImageOrientation toOrientation    = 0;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            toOrientation   = UIImageOrientationLeft;
            break;
        case UIImageOrientationRight:
            toOrientation   = UIImageOrientationUp;
            break;
        case UIImageOrientationDown:
            toOrientation   = UIImageOrientationRight;
            break;
        case UIImageOrientationLeft:
            toOrientation   = UIImageOrientationDown;
            break;
        case UIImageOrientationUpMirrored:
            toOrientation   = UIImageOrientationLeftMirrored;
            break;
        case UIImageOrientationRightMirrored:
            toOrientation   = UIImageOrientationUpMirrored;
            break;
        case UIImageOrientationDownMirrored:
            toOrientation   = UIImageOrientationRightMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            toOrientation   = UIImageOrientationDownMirrored;
            break;
        default:
            break;
    }
    return toOrientation;
}

- (UIImageOrientation)toOrientation_180_Degrees
{
    UIImageOrientation toOrientation    = 0;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            toOrientation   = UIImageOrientationDown;
            break;
        case UIImageOrientationRight:
            toOrientation   = UIImageOrientationLeft;
            break;
        case UIImageOrientationDown:
            toOrientation   = UIImageOrientationUp;
            break;
        case UIImageOrientationLeft:
            toOrientation   = UIImageOrientationRight;
            break;
        case UIImageOrientationUpMirrored:
            toOrientation   = UIImageOrientationDownMirrored;
            break;
        case UIImageOrientationRightMirrored:
            toOrientation   = UIImageOrientationLeftMirrored;
            break;
        case UIImageOrientationDownMirrored:
            toOrientation   = UIImageOrientationDownMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            toOrientation   = UIImageOrientationRightMirrored;
            break;
        default:
            break;
    }
    return toOrientation;
}
@end

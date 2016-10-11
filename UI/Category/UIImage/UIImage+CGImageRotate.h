//
//  UIImage+CGImageRotate.h
//  TestCG_CGKit
//
//  Created by DY on 2016/10/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 旋转方式 */
typedef NS_ENUM(NSInteger, CGImageRotateType) {
    /** 顺时针旋转90度 */
    CGImageRotateTypeClockwiseRotate_90_Degrees,
    /** 逆时针旋转90度 */
    CGImageRotateTypeCounterclockwiseRotate_90_Degrees,
    
    /** 旋转180度 */
    CGImageRotateTypeRotate_180_Degrees,
};

/** 图像的选择 */
@interface UIImage (CGImageRotate)

/** 旋转图像 @warning 如需反转 */
- (UIImage *)rotateImageWithType:(CGImageRotateType)rotateType;

/** 将图像旋转到指定方向 */
- (UIImage *)imageToOrientation:(UIImageOrientation)orientation;

@end

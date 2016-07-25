//
//  CGAffineTransform+Category.h
//  TestCG_CGKit
//
//  Created by DY on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGAffineTransform_Category_h
#define CGAffineTransform_Category_h

@import QuartzCore;
@import CoreGraphics;

#import "CGAngleRadianHeader.h"

//方法说明地址http://blog.csdn.net/holdsky/article/details/40681155
/** 计算以任意点旋转的CGAffineTransform值 */
UIKIT_STATIC_INLINE CGAffineTransform CG_CGAffineTransformRotateAroundPoint(CGPoint center, CGPoint rotateVertex, float angle) {
    
    //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    CGFloat x = rotateVertex.x - center.x;
    
    //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    CGFloat y = rotateVertex.y - center.y;
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(x, y);
    trans   = CGAffineTransformRotate(trans, _CG_RadianForAngle(angle));
    trans   = CGAffineTransformTranslate(trans, -x, -y);
    
    return trans;
}

#endif /* CGAffineTransform_Category_h */

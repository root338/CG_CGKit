//
//  CGLineBoxView.h
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#define _LINE_WIDTH_SINGLE           (1.0 / [UIScreen mainScreen].scale)

typedef NS_OPTIONS(NSInteger, LineBoxType) {
    
    LineBoxTypeTop      = 1 << 0,
    LineBoxTypeLeft     = 1 << 1,
    LineBoxTypeBottom   = 1 << 2,
    LineBoxTypeRight    = 1 << 3,
    LineBoxTypeAll      = LineBoxTypeTop | LineBoxTypeLeft | LineBoxTypeBottom | LineBoxTypeRight,
};

/**
 *  线框视图
 *
 */
@interface CGLineBoxView : UIView

/**
 *  线框需要设置的周边
 */
@property (assign, nonatomic) LineBoxType rectCorner;

/**
 *  圆角
 */
@property (assign, nonatomic) CGSize cornerRadii;

/**
 *  绘制的线的颜色
 */
@property (strong, nonatomic) UIColor *lineColor;

/**
 *  线的宽度
 */
@property (assign, nonatomic) CGFloat lineWidth;

/**
 *  是否使用绘制、暂时没用
 */
@property (assign, nonatomic) BOOL isDrawLine;

/**
 *  使用图片显示线框
 */
@property (strong, nonatomic) UIImage *lineHorizontalImage;
@property (strong, nonatomic) UIImage *lineVerticalImage;
@end

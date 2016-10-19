//
//  CGLineBoxView.h
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLineBoxTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  线框视图
 *  @warning 在绘制线时，如果该视图存在子视图，需要设置子视图的显示区域，以留出线的显示区域
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
@property (nullable, strong, nonatomic) UIColor *lineColor;

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

- (void)setupLineType:(LineBoxType)lineType color:(nullable UIColor *)lineColor length:(CGFloat)length;
@end

@interface CGLineBoxView (CGCreateLineView)

+ (__kindof CGLineBoxView *)createLineViewWithLineType:(LineBoxType)type color:(nullable UIColor *)lineColor length:(CGFloat)length;

@end

NS_ASSUME_NONNULL_END

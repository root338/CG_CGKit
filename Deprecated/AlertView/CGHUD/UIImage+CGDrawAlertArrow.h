//
//  UIImage+CGDrawAlertArrow.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/23.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 需要绘制的边 */
typedef NS_ENUM(NSInteger, CGDrawAlertArrowSide) {
    /** 左边 */
    CGDrawAlertArrowLeftSide,
    /** 右边 */
    CGDrawAlertArrowRightSide,
};

/** 需要绘制的箭头类型 */
typedef NS_ENUM(NSInteger, CGAlertArrowStyle) {
    
    /** 默认的 */
    CGAlertArrowStyleDefault,
};

@interface UIImage (CGDrawAlertArrow)

+ (UIImage *)cg_drawAlertArrowSide:(CGDrawAlertArrowSide)arrowSide;

@end


NS_ASSUME_NONNULL_END
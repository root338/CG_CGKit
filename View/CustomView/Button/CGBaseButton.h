//
//  CGBaseButton.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"

@class CGBorderObject;
NS_ASSUME_NONNULL_BEGIN

//UIKIT_EXTERN const CGFloat __K_Button_AutoBorderWidth;
@interface CGBaseButton : UIButton<CGViewInitializationProtocol>
/// 开启半圆角
@property (nonatomic, assign) BOOL isEnableFillet;
/** 
 *  边框的颜色同步标题的颜色，默认为NO
 *  @warning 当设置为YES时会覆盖已设置的边框属性，边框宽度自动设置为borderWidth
 */
@property (nonatomic, assign) BOOL isBorderColorSyncTitle;

/**
 同步高亮状态为按钮最终的主要状态，默认为NO
 !!! 注意：当开启此属性已经设置的高亮状态会失效
 */
//@property (nonatomic, assign) BOOL enableHighlightedStatusSyncFinalStatus;

/** 
 *  全局设置边框宽度，使用时需要提前设置
 *  @warning 暂时取消掉使用__K_Button_AutoBorderWidth值 (当使用单独设置宽度方法时设置为__K_Button_AutoBorderWidth会自动替换为该值)
 */
@property (nonatomic, assign) CGFloat borderWidth;

/** 获取指定状态边框对象 */
- (CGBorderObject *)cg_borderObjectForState:(UIControlState)state;

/** 设置 */

- (void)cg_setupBorderWithColor:(UIColor *)borderColor state:(UIControlState)state;

- (void)cg_setupBorderWithColor:(UIColor *)borderColor width:(CGFloat)width state:(UIControlState)state;
- (void)cg_setupBorderWithObject:(CGBorderObject *)borderObject state:(UIControlState)state;


@end

NS_ASSUME_NONNULL_END

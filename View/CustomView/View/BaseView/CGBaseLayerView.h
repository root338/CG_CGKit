//
//  CGBaseLayerView.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGBorderStateHeader.h"
#import "CGBorderObject.h"

/**
 *  设置视图不同状态（CGViewBorderState）下的边框值
 */
@interface CGBaseLayerView : CGBaseView

/** 视图的状态 */
@property (nonatomic, assign) CGViewBorderState borderState;

/** CGViewBorderStateDisabled状态下关闭用户交互 */
@property (nonatomic, assign) BOOL isDisableStateOfDisableUserInteraction;

/** 获取指定状态的视图边框值 */
- (CGBorderObject *)borderLayerForState:(CGViewBorderState)state;
/** 设置指定状态下的边框的颜色、状态(UIColor,CGFloat 值) */
- (void)setViewWithBorderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state;
/** 设置指定状态下的边框颜色、状态（CGBorderObject对象） */
- (void)setViewWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state;

@end

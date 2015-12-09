//
//  CGBaseButton.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"
#import "CGViewInteractionStatusDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGBaseButton : UIButton<CGViewInitializationProtocol>

#pragma mark - 交互状态
@property (weak, nonatomic) id<CGViewInteractionStatusDelegate> delegate;
/** 
 *  当前状态
 *  @param 当状态改变时会调用cg_setupButton:withInteractionStatus:
 */
@property (assign, nonatomic) CGViewInteractionStatus currentStatus;

#pragma mark - 边框

/** 打开自动替换边框色值 */
@property (assign, nonatomic) BOOL isEnableBorderColorAutoChange;

/** 
 *  边框色值是否同步标题的色值 默认为NO
 *  @param 在isEnableBorderColorAutoChange为YES的情况下有效
 *  @param 设置此值后在当前状态没有相应边框色值时会自动获取标题的色值，当标题的色值也为nil时，自动获取边框normal值
 */
@property (assign, nonatomic) BOOL borderSyncTitleColor;

/** 当前边界的颜色值 */
@property (nullable, strong, nonatomic, readonly) UIColor *currentBorderColor;
/** 指定 state 下的边框色值 */
- (nullable UIColor *)borderColorForState:(UIControlState)state;
/** 设置 state 下的边框色值 */
- (void)setBorderColor:(nullable UIColor *)color forState:(UIControlState)state;

@property (assign, nonatomic) BOOL isApplyCurrentBorderWidth;
@property (assign, nonatomic) CGFloat currentBorderWidth;
- (CGFloat)borderWidthForState:(UIControlState)state;
- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state;
@end

NS_ASSUME_NONNULL_END
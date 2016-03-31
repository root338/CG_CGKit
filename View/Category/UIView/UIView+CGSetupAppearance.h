//
//  UIView+CGSetupBorder.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/26.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 设置视图的外观 */
NS_ASSUME_NONNULL_BEGIN
#pragma mark - 单视图设置
/** 设置视图边框、圆角 */
@interface UIView (CGSetupBorder)

/** 设置视图圆角 */
- (void)cg_setupBorderWithCornerRadius:(CGFloat)cornerRadius;

/** 设置视图边框 */
- (void)cg_setupBorderWithWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;

/** 设置视图圆角、边框 */
- (void)cg_setupBorderWithWidth:(CGFloat)borderWidth color:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;


@end
NS_ASSUME_NONNULL_END
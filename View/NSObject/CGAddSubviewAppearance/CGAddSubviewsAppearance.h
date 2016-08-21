//
//  CGAddSubviewsAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseObject.h"

#import "CGAddSubviewsErrorTypeHeader.h"


NS_ASSUME_NONNULL_BEGIN
/**
 *  一个视图添加多个相同视图时的全局设置
 */
__deprecated_msg("该类已废弃")
@interface CGAddSubviewsAppearance : CGBaseObject

#pragma mark - 父视图区域设置
/** 子视图边界距离父视图的边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInset;
/** 自动设置视图的宽度 */
@property (nonatomic, assign) BOOL isAutoSetupViewWidth;
/** 自动设置视图的高度 */
@property (nonatomic, assign) BOOL isAutoSetupViewHeight;


#pragma mark - 内部子视图的设置
/** 需要加载的子视图个数 */
@property (nonatomic, assign) NSUInteger subviewsTotal;
/** 子视图横向加载的个数 */
@property (nonatomic, assign) NSUInteger count;
/** 子视图水平间距 */
@property (nonatomic, assign) CGFloat horizontalSpace;
/** 子视图垂直间距 */
@property (nonatomic, assign) CGFloat verticalSpace;
/** 子视图宽 : 高的比例值 */
@property (nonatomic, assign) CGFloat scale;
/** 子视图的宽度 */
@property (nonatomic, assign) CGFloat itemWidth;
/** 子视图的高度 */
@property (nonatomic, assign) CGFloat itemHeight;

#pragma mark - 只读判断属性
/** 必要设置的属性值有没有设置, YES 设置好*/
@property (nonatomic, assign, readonly) BOOL shouldPrivatePropertyValue;

/** 验证是否可以合理的创建内部子视图 */
- (BOOL)cg_judgeShouldCreateSubviewsWithSuperview:(__kindof UIView *)paramSuperview;

/** 获取待计算的宽度 */
- (void)cg_getWidthWithSuperview:(__kindof UIView *)paramSuperview completion:(void (^) (CGAddSubviewsErrorType errorType, CGFloat width, CGFloat superWidth))completion;

/** 获取待计算的高度 */
- (void)cg_getHeightWithSuperview:(__kindof UIView *)paramSuperview completion:(void (^) (CGAddSubviewsErrorType errorTye, CGFloat height, CGFloat superHeight))completion;
@end
NS_ASSUME_NONNULL_END
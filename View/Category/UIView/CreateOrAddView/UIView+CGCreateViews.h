//
//  UIView+CGCreateViews.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAddSubviewsErrorTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

//创建子视图的block
typedef UIView * _Nonnull (^CGCreateSubviewsBlock) (NSInteger index);
//添加子视图的错误
typedef void (^CGAddSubviewsErrorTypeBlock) (CGAddSubviewsErrorType errorType, NSError  * _Nullable error);
//设置子视图的大小
typedef CGSize (^CGSetupSubviewsSizeBlock) (__kindof UIView *view, NSInteger index);

@class CGAddSubviewsAppearance, CGSubviewsSizeAppearance;
@interface UIView (CGCreateViews)

/**
 *  批量添加固定大小子视图
 *
 *  @param viewsRule    子视图创建的规则
 *  @param setupSubview 返回创建的子视图
 *  @param completion   判断给定的规则是否满足
 */
- (CGSize)cg_createViewsWithRule:(__kindof CGAddSubviewsAppearance *)viewsRule stopAddSubviews:(BOOL (^ __nullable) (CGAddSubviewsErrorType errorType))stopAddSubviews subview:(__kindof UIView * (^) (NSInteger index))setupSubview;

/**
 *  创建流类型的子视图
 *
 *  @param viewsRule    创建的规则
 *  @param setupSubview 创建的视图
 *
 *  @return 返回创建子视图所需要的大小
 */
- (CGSize)cg_createFlowViewsWithRule:(__kindof CGSubviewsSizeAppearance *)viewsRule createSubviewBlock:(__kindof UIView * _Nonnull (^)(NSInteger))createSubviewBlock setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock;

@end

@interface UIView (CGCreateView)

+ (instancetype)cg_createViewWithBackgroundColor:(UIColor *)backgroundColor;

@end
NS_ASSUME_NONNULL_END
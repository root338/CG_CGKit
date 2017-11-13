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

@class CGAddSubviewsAppearance;


@interface UIView (CGCreateViews)

/**
 *  批量添加固定大小子视图
 *
 *  @param viewsRule    子视图创建的规则
 *  @param stopAddSubviews 返回创建的子视图
 *  @param setupSubview   判断给定的规则是否满足
 */
- (CGSize)cg_createViewsWithRule:(__kindof CGAddSubviewsAppearance *)viewsRule stopAddSubviews:(BOOL (^ __nullable) (CGAddSubviewsErrorType errorType))stopAddSubviews subview:(__kindof UIView * (^) (NSInteger index))setupSubview __deprecated_msg("该方法已废弃，请使用cg_createFlowViewsWithRule:createSubviewBlock:setupSubviewSizeBlock:failureBlock:方法替换");

@end

NS_ASSUME_NONNULL_END

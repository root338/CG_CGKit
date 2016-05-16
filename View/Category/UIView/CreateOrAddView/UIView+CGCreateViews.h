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
 *  @param setupSubview 返回创建的子视图
 *  @param completion   判断给定的规则是否满足
 */
- (void)cg_createViewsWithRule:(__kindof CGAddSubviewsAppearance *)viewsRule stopAddSubviews:(BOOL (^ __nullable) (CGAddSubviewsErrorType errorType))stopAddSubviews subview:(__kindof UIView * (^) (NSInteger index))setupSubview didSetupCallback:(void (^ __nullable) (CGSize compressedSize))didSetupCallback;


@end

@interface UIView (CGCreateView)

+ (instancetype)cg_createViewWithBackgroundColor:(UIColor *)backgroundColor;

@end
NS_ASSUME_NONNULL_END
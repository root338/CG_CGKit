//
//  CGLayoutMarginBaseView.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGLayoutMarginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/** 设置与外边界有边距的视图 */
@interface CGLayoutMarginBaseView : CGBaseView<CGLayoutMarginDelegate>


@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;

/** 目标视图 */
@property (nullable, nonatomic, weak) UIView *targetView;

- (UIView *)cg_layoutMarginTargetView;
@end

NS_ASSUME_NONNULL_END
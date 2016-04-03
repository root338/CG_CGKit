//
//  CGTitleButtonsLayoutView.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN
/** 两个按钮视图 */
@interface CGTitleButtonsLayoutView : CGBaseView

@property (nonatomic, strong, readonly) UIButton *firstButton;

@property (nonatomic, strong, readonly) UIButton *lastButton;

/** 两个按钮之间最小的间距 */
@property (nonatomic, assign) CGFloat minimumSpacing;
/** 第一个按钮与父视图之间的边界值，忽略边靠近第二个按钮的边 */
@property (nonatomic, assign) UIEdgeInsets firstMarginEdgeInsets;
/** 第二个按钮与父视图之间的边界值，忽略边靠近第一个按钮的边 */
@property (nonatomic, assign) UIEdgeInsets lastMarginEdgeInsets;
@end
NS_ASSUME_NONNULL_END
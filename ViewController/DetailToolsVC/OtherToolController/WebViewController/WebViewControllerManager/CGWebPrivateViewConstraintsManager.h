//
//  CGWebPrivateViewConstraintsManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGWebPrivateViewTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebPrivateView;

/** CGWebPrivateView 视图控制器的约束管理类 */
@interface CGWebPrivateViewConstraintsManager : CGBaseObject

@property (nonatomic, weak, readonly) CGWebPrivateView *view;

- (instancetype)initWithView:(CGWebPrivateView *)view;

/** 设置约束 */
- (void)setupConstraints;
/** 更新约束 */
- (void)updateConstraints;
/** 设置底部视图的显隐 */
- (void)bottomViewIsHidden:(BOOL)isHidden animated:(BOOL)animated;
/** 设置底部视图的高度 */
- (void)setupViewHeight:(CGFloat)height type:(CGWebPrivateViewType)type animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
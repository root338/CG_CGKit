//
//  CGBaseSelectorView.h
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGBaseSelectorView : CGBaseView

#pragma mark - 视图设置
/** 选择的内容视图 */
@property (nonatomic, strong, readonly) UIView *contentView;

/** 选择视图大小是否等于父视图的bounds属性, 默认为 YES */
@property (nonatomic, assign) BOOL frameEqualSuperviewBounds;

/** 隐藏contentView后移除父视图, 默认YES */
@property (nonatomic, assign) BOOL didHideContentViewRemoveSuperview;
/** 选择视图的父视图 */
@property (nullable, nonatomic, weak) UIView *targetSuperview;
/** 设置选择视图的父视图block */
@property (nullable, nonatomic, copy) UIView * (^setupSuperviewBlock) (void);

/**
 关闭背景图按钮功能 默认NO
 @param 触发- (void)hideContentView方法
 */
@property (nonatomic, assign) BOOL disableBackgroundButtonTools;

- (void)show;
- (void)hide;
@end



NS_ASSUME_NONNULL_END

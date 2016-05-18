//
//  CGNavigationBarView.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

@protocol CGNavigationBarViewDelegate <NSObject>

@required
/** 设置自定义导航栏的显示区域 */
- (CGRect)cg_navigationBarFrame;

@optional
/** 设置contentView的显示区域 */
- (CGRect)cg_contentViewFrame;

@optional

@end

NS_ASSUME_NONNULL_BEGIN
@interface CGNavigationBarView : CGBaseView

/** 当没有颜色时默认设置为白色 */
@property (nullable, nonatomic, strong, readonly) UINavigationBar *navigationBar;
@property (nonatomic, strong, readonly) UIView *contentView;

@property (nullable, nonatomic, weak) id<CGNavigationBarViewDelegate> delegate;

/** contentView 是否全屏显示，默认NO */
@property (nonatomic, assign) BOOL isContentViewFullScreen;

/** 是否隐藏导航栏 */
@property (nonatomic, assign) BOOL isNavigationBarHidden;
/** 是否隐藏导航栏，并且是否执行动画 */
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

/**
 *  创建导航栏
 *  @warning 子类可以重写创建的导航栏
 */
- (void)createNavigationBar;

/** 添加导航栏和内容视图到view中 */
//- (void)addNavigationBarAndContentViewSubviews;

/** 设置导航栏和内容视图的布局 */
- (void)setupSubviewsLayout;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CGNavigationBarViewDelegate>)pDelegate;

#pragma mark - 设置内容视图样式
- (void)cg_setupNavigationBarAppearance;
- (void)cg_setupContentViewAppearance;
@end
NS_ASSUME_NONNULL_END
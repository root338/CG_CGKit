//
//  UIView+CGSearchView.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 搜索视图 */
@interface UIView (CGSearchView)

/** 搜索指定类型的父视图 */
- (nullable __kindof UIView *)searchSuperViewWithClass:(Class)className;

/** 搜索两个视图共同的父视图 */
- (nullable __kindof UIView *)cg_searchCommonSuperviewWithView:(__kindof UIView *)otherView;

/** 搜索最近的视图控制器，不包含自己 */
@property (nullable, nonatomic, readonly) __kindof UIViewController * viewControllerForLate;
@property (nullable, nonatomic, readonly) __kindof UINavigationController * navigationControllerForLate;
/** 搜索指定的视图控制器，不包含自己 */
- (nullable __kindof UIViewController *)cg_searchViewControllerWithClass:(Class)className;

/** 全局搜索第一响应者 */
+ (nullable __kindof UIView *)cg_searchFirstResponder;

/** 当前视图内搜索第一响应者 */
- (nullable __kindof UIView *)cg_searchFirstResponder;

@end

@interface UIView (CGSearchNextInputView)

/** 
 *  是否缓存当前视图的输入控件 
 *  @warning 当视图内部视图发生变化时需要手动清理缓存视图
 */
@property (assign, nonatomic) BOOL isCacheInputViews;

/** 缓存的输入视图 */
@property (nullable, strong, nonatomic) NSArray<UIView *> *cacheInputViews;

#pragma mark - 只能在当前视图内寻找
/** 搜索当前视图内，下一个可输入视图 */
- (nullable UIView *)searchNextWithCurrentInputView:(UIView *)currentInputView;

/** 搜索当前视图内，上一个可输入视图 */
- (nullable UIView *)searchPreviousWithCurrentInputView:(UIView *)currentInputView;

/** 
 *  搜索当前视图的输入控件 
 *  只返回当前搜索到得第一个输入控件
 */
- (nullable UIView *)searchInputTextControl;

/** 搜索当前窗口内，下一个可输入视图 */
+ (nullable UIView *)searchNextWithCurrentInputView:(UIView *)currentInputView;
/** 搜索当前窗口内，上一个可输入视图 */
+ (nullable UIView *)searchPreviousWithCurrentInputView:(UIView *)currentInputView;

/**
 *  搜索指定类的视图
 *  @warning 当搜索的视图满足指定类视图后，将不继续搜索其子视图
 *
 *  @param excludeView          可以排除的视图
 *  @param isOnlyOne            是否只有一个
 *  @param targetViewClassArray 满足的视图类
 *
 *  @return 返回搜索后的结果
 */
- (nullable NSArray *)searchSubviewsInputViewsWithExcludeView:(nullable UIView *)excludeView isOnlyOne:(BOOL)isOnlyOne targetViewClassArray:(NSArray<Class> *)targetViewClassArray;
@end



NS_ASSUME_NONNULL_END

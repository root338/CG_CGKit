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
- (id)searchSuperViewWithClass:(Class)className;

@end

@interface UIView (CGSearchNextInputView)

/** 
 *  是否缓存当前视图的输入控件 
 *  @warning 当视图内部视图发生变化时需要手动清理缓存视图
 */
@property (assign, nonatomic) BOOL isCacheInputViews;

/** 缓存的输入视图 */
@property (strong, nonatomic) NSArray<UIView *> *cacheInputViews;

#pragma mark - 只能在当前视图内寻找
/** 搜索当前视图内，下一个可输入视图 */
- (UIView *)searchNextWithCurrentInputView:(UIView *)currentInputView;

/** 搜索当前视图内，上一个可输入视图 */
- (UIView *)searchPreviousWithCurrentInputView:(UIView *)currentInputView;

@end

NS_ASSUME_NONNULL_END
//
//  HorizontalSingleView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalSingleAppearance.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  水平横向视图
 */
@interface HorizontalSingleView : UIView

#pragma mark - 内容设置
/**
 *  需要添加的标题
 */
@property (nullable, nonatomic, strong) NSArray *titles;

#pragma mark - 选择内容
/**
 *  选择的索引，从0开始
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  选择控件
 */
@property (nullable, nonatomic, readonly) UIButton *selectedButton;

/**
 *  当选择控件的选择状态发生改变时进行回调
 *  @param 已选择控件的索引
 */
@property (nullable, nonatomic, copy) void(^didSelectedChangeCallback)(NSInteger selectedIndex);

#pragma mark - 外观设置
/**
 *  设置视图的外观
 */
@property (nullable, nonatomic, strong) HorizontalSingleAppearance *appearance;


#pragma mark - 设置加载的选择按钮
/**
 *  创建选择控件
 *  @warning 与 selecteViewClass 类，相互独立不同时生效
 *  @param index 创建的控件索引
 *  @param titles 添加的标题
 */
@property (nullable, nonatomic, copy) UIButton *(^setupSelecteView)(NSInteger index, id titles);

/**
 *  添加的内容视图类，由这个类快速创建选择控件
 *  @warning 与block 方法setupSelecteView 相互独立不同时生效，且setupSelecteView方法优先级更高
 */
@property (nonatomic, assign) Class selecteViewClass;

/**
 *  设置按钮的外观
 *  
 */
@property (nullable, copy, nonatomic) void (^setupButtonAppearance) (UIButton *button);

/**
 *  获取指定索引的按钮
 *
 *  @param index 索引号
 *
 *  @return 指定索引的按钮
 */
- (nullable UIButton *)buttonAtIndex:(NSInteger)index;

#pragma mark - 位置变化
/**
 *  更新滑块的坐标
 */
- (void)updateSliderViewContentOffset:(CGFloat)offset;
@end

NS_ASSUME_NONNULL_END

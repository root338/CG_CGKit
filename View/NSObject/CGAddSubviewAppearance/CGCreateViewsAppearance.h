//
//  CGCreateViewsAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
/** 
 *  一个视图添加多个相同视图时的全局设置
 *  @warning 数据之间不能冲突，当maxWidth,maxHeight为0时，自动使用视图的bounds属性值。
 */
__deprecated_msg("暂时没有任何其他类使用")
@interface CGCreateViewsAppearance : NSObject

#pragma mark - 父视图区域设置
//
///** 父视图宽度 */
//@property (nonatomic, assign) CGFloat maxWidth;
///** 父视图高度 */
//@property (nonatomic, assign) CGFloat maxHeight;

/** 子视图边界距离父视图的边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInset;
/** 自动删除子视图，@param 自动删除子视图，默认为已加载的子视图为需要加载视图可以重用 */
//@property (nonatomic, assign) BOOL isAutoRemoveSubviews;
/** 自动设置视图大小 设为YES时必须设置 itemSize */
@property (nonatomic, assign) BOOL isAutoSetupViewSize;

#pragma mark - 内部子视图的设置
/** 需要加载的子视图个数 */
@property (nonatomic, assign) NSUInteger subviewsTotal;
/** 子视图横向加载的个数 */
@property (nonatomic, assign) NSUInteger count;
/** 子视图之间的水平间距 */
@property (nonatomic, assign) CGFloat horizontalSpace;
/** 子视图之间的垂直间距 */
@property (nonatomic, assign) CGFloat verticalSpace;
/** 子视图的大小 */
@property (nonatomic, assign) CGSize itemSize;

#pragma mark - 只读判断属性
/** 必要设置的属性值有没有设置, YES 设置好*/
@property (nonatomic, assign, readonly) BOOL shouldPrivatePropertyValue;

/** 自动设置视图大小是否满足条件, YES 可以自动设置视图大小 */
@property (nonatomic, assign, readonly) BOOL shouldAutoSetupViewSize;

#pragma mark - 只读属性的计算
/** 视图的大小 */
@property (nonatomic, assign, readonly) CGSize viewSize;
@end
NS_ASSUME_NONNULL_END

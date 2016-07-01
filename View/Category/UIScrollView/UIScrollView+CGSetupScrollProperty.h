//
//  UIScrollView+CGSetupValue.h
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 滑动的类型 */
typedef NS_OPTIONS(NSInteger, CGSlideDirectionType) {
    
    CGSlideDirectionTypeTop         =   1 << 0,
    CGSlideDirectionTypeLeft        =   1 << 1,
    CGSlideDirectionTypeBottom      =   1 << 2,
    CGSlideDirectionTypeRight       =   1 << 3,
    CGSlideDirectionTypeTopLeft     = CGSlideDirectionTypeTop   | CGSlideDirectionTypeLeft,
    CGSlideDirectionTypeTopRight    = CGSlideDirectionTypeTop   | CGSlideDirectionTypeRight,
    CGSlideDirectionTypeBottomLeft  = CGSlideDirectionTypeBottom    | CGSlideDirectionTypeLeft,
    CGSlideDirectionTypeBottomRight = CGSlideDirectionTypeBottom    | CGSlideDirectionTypeLeft,
};


/** 改变UIScrollView一些属性值 */
@interface UIScrollView (CGSetupScrollProperty)

/** 隐藏动画滑动 */
@property (nonatomic, assign) BOOL hideAnimatedScrolling;

#pragma mark - 偏移量
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat offsetY;

- (void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated;
- (void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated;

/** 将滑动视图滑动到指定位置顶部 */
- (void)scrollingWithType:(CGSlideDirectionType)slideType;
/** 将滑动视图滑动到指定位置顶部，是否动画执行 */
- (void)scrollingWithType:(CGSlideDirectionType)slideType animated:(BOOL)animated;

/** 滑动到指定视图 */
- (void)scrollingWithTargetView:(UIView *)targetView;
/** 滑动到指定视图 */
- (void)scrollingWithTargetView:(UIView *)targetView animated:(BOOL)animated;
/** 
 *  滑动到指定视图
 *  @param targetView   scrollView上的子视图
 *  @param failure      滑动失败后的回调
 *  @warning 当目标视图 size 超出scrollView 的 size 时会滑动到底部
 */
- (void)scrollingWithTargetView:(UIView *)targetView animated:(BOOL)animated failure:(void (^ _Nullable) (NSError *error))failure;
@end
NS_ASSUME_NONNULL_END
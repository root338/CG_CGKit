//
//  UIScrollView+CGSetupValue.h
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import <UIKit/UIKit.h>

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

NS_ASSUME_NONNULL_BEGIN
/** 改变UIScrollView一些属性值 */
@interface UIScrollView (CGSetupScrollProperty)

#pragma mark - 偏移量
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat offsetY;

- (void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated;
- (void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated;

/** 将滑动视图滑动到指定位置顶部 */
- (void)scrollingWithType:(CGSlideDirectionType)slideType;
/** 将滑动视图滑动到指定位置顶部，是否动画执行 */
- (void)scrollingWithType:(CGSlideDirectionType)slideType animated:(BOOL)animated;
@end
NS_ASSUME_NONNULL_END
//
//  UIView+LayoutSetup.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/31.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  视图布局的状态
 */
typedef NS_OPTIONS(NSInteger, CGViewLayoutType){
    /**
     *  不进行任何设置
     */
    CGViewLayoutTypeNone                = 0,
    /**
     *  等宽
     */
    CGViewLayoutTypeEqualWidth          = 1 << 0,
    /**
     *  等高
     */
    CGViewLayoutTypeEqualHeight         = 1 << 1,
    
    /**
     *  顶部相等
     */
    CGViewLayoutTypeEqualTop            = 1 << 2,
    
    /**
     *  左边相等
     */
    CGViewLayoutTypeEqualLeading        = 1 << 3,
    
    /**
     *  底部相等
     */
    CGViewLayoutTypeEqualBottom         = 1 << 4,
    
    /**
     *  右边相等
     */
    CGViewLayoutTypeEqualTrailing       = 1 << 5,
    
    /**
     *  水平等高
     */
    CGViewLayoutTypeLevelEqualHeight    = CGViewLayoutTypeEqualTop | CGViewLayoutTypeEqualBottom,
    

    
    /**
     *  大小相等
     */
    CGViewLayoutTypeEqualSize           = CGViewLayoutTypeEqualWidth | CGViewLayoutTypeEqualHeight,
};

/**
 *  子视图布局类型，包含与父视图之间的布局
 */
typedef NS_ENUM(NSInteger, CGLayoutType){
    /**
     *  空
     */
    CGLayoutTypeNone,
    /**
     *  垂直下
     */
    CGLayoutTypeVertical,
    /**
     *  水平下
     */
    CGLayoutTypeHorizontal,
};

/**
 *  对视图内部所有子视图进行相同设置
 *  @warning 必须加入 Masonry 库 gitHub.com 地址 https://github.com/desandro/masonry
 */
@interface UIView (LayoutSetup)

/**
 *  设置视图内部视图的布局类型
 *
 *  @param type 布局类型值
 */
- (void)setupConstraintsWithType:(CGViewLayoutType)type;

/**
 *  设置视图内部视图的布局类型
 *
 *  @param type  布局类型值
 *  @param space 间距值
 */
- (void)setupConstraintsWithType:(CGViewLayoutType)type space:(CGFloat)space;

///**
// *  子视图的水平间距
// *
// *  @param space 间距值
// */
//- (void)setupSubviewConstraintsWithHorizontalSpace:(CGFloat)space;
//
///**
// *  子视图的垂直间距
// *
// *  @param space 间距值
// */
//- (void)setupSubviewConstraintsWithVerticalSpace:(CGFloat)space;

/**
 *  设置子视图的间距
 *
 *  @param marginSpace  视图距离外边框的距离
 *  @param type         类型值
 *  @param subviewSpace 间距值
 */
- (void)setupMarginSpace:(UIEdgeInsets)marginSpace type:(CGLayoutType)type subviewSpace:(CGFloat)subviewSpace;
@end

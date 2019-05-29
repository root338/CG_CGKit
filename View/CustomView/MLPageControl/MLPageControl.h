//
//  MLPageControl.h
//  TestCG_CGKit
//
//  Created by PCG on 2018/5/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAlignmentHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class MLPageControl, MLPageControlCell;
@protocol MLPageControlDelegate <NSObject>

@optional

- (NSInteger)numberOfPagesInPageControl:(MLPageControl *)pageControl;

- (MLPageControlCell *)pageControl:(MLPageControl *)pageControl cellAtIndex:(NSInteger)index;

- (CGSize)pageControl:(MLPageControl *)pageControl sizeAtIndex:(NSInteger)index;

@end

/**
 分页标识的样式

 - MLPageControlStyleLinear: 直线加载
 - MLPageControlStyleFlow: 自动流的加载
 */
typedef NS_ENUM(NSInteger, MLPageControlStyle) {
    MLPageControlStyleLinear,
    MLPageControlStyleFlow,
};

@interface MLPageControl : UIView

@property (nonatomic, assign) MLPageControlStyle style;

@property (nonatomic, weak) id<MLPageControlDelegate> delegate;

/** 分页标识的总空间距离视图的外边距, 默认 {18, 8, 18, 8} */
@property (nonatomic, assign) UIEdgeInsets insets;
/** 分页标识垂直对齐方式, 默认 CGViewVerticalAlignmentCenter */
@property (nonatomic, assign) CGViewVerticalAlignment pageVerticalAlignment;
/** 分页标识水平对齐方式, 默认 CGViewAlignmentHorizontalCenter */
@property (nonatomic, assign) CGViewHorizontalAlignment pageHorizontalAlignment;
/** 单个分页标识的大小, 默认{7, 7} */
@property (nonatomic, assign) CGSize pageSize;
/** 分页标识之间的间距，默认 9 */
@property (nonatomic, assign) CGFloat pageSpace;
/** 总共有多少个分页标识 */
@property(nonatomic) NSInteger numberOfPages;
/** 当前分页的索引 */
@property(nonatomic) NSInteger currentPage;
/** 当只有一个分页标识的时候隐藏，默认 NO */
@property(nonatomic) BOOL hidesForSinglePage;
/** 关闭容错, 默认 NO, 开启容错时当currentPage超出范围时自动选择最大的值，当currentPage小于返回时自动选择最小的值 */
@property (nonatomic) BOOL disableFaultTolerant;
///** 当为YES时改变currentPage时，不会更新视图, 必须手动调用 updateCurrentPageDisplay, 默认为 NO */
//@property(nonatomic) BOOL defersCurrentPageDisplay;
///** 更新视图 */
//- (void)updateCurrentPageDisplay;

//- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@property (nullable, nonatomic, copy) void(^setPageViewAppearanceBlock) (UIView *pageView);

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END

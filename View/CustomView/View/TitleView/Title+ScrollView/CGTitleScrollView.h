//
//  CGTitleScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 16/8/11.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTitleScrollView, CGRadioTitleCellAppearance;

@protocol CGTitleScrollViewDataSource <NSObject>


@required

- (UIView *)titleScrollView:(CGTitleScrollView *)titleScrollView viewForAtIndex:(NSInteger)index;

@end

@interface CGTitleScrollView : CGBaseView

/** 标题视图的高度 */
@property (nonatomic, assign) CGFloat titleViewHeight;

- (instancetype)initWithTitleHeight:(CGFloat)titleHeight titles:(NSArray<NSString *> *)titles;

/** 标题集 */
@property (nullable, nonatomic, strong) NSArray<NSString *> *titles;

@property (nullable, nonatomic, weak) id<CGTitleScrollViewDataSource> dataSource;

@property (nonatomic, assign) NSInteger currentPage;

@property (nullable, nonatomic, strong) CGRadioTitleCellAppearance *titleAppearance;

- (void)reloadAllView;
@end

NS_ASSUME_NONNULL_END
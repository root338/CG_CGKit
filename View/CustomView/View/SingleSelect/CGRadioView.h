//
//  CGRadioView.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGLineBoxView.h"
#import "CGRadioViewAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@class CGRadioView, CGRadioSliderView;

@protocol CGRadioViewDataSource <NSObject>

@required
/** 设置标题视图有多少 */
- (NSInteger)numberOfTitleInRadioView:(CGRadioView *)radioView;

/** 设置标题视图 */
- (UICollectionViewCell *)radioView:(CGRadioView *)radioView cellForIndexPath:(NSIndexPath *)indexPath;

@optional
/** 设置标题视图的大小 */
- (CGSize)radioView:(CGRadioView *)radioView sizeForIndexPath:(NSIndexPath *)indexPath;

/** 标题视图索引下的滑块视图 */
//- (UIView *)radioView:(CGRadioView *)radioView sliderViewForIndex:(NSInteger)index;

@end

@protocol CGRadioViewDelegate <NSObject>

@optional
- (void)radioView:(CGRadioView *)radioView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置滑块的显示区域
 *
 *  @param radioView           单选视图
 *  @param beforeSelectedCell  之前选择的标题视图
 *  @param currentSelectedCell 当前选择的标题视图
 *
 *  @return 返回滑块的显示区域
 */
- (CGRect)radioView:(CGRadioView *)radioView sliderViewFrameBeforeSelectedCell:(__kindof  UICollectionViewCell * _Nullable )beforeSelectedCell currentSelectedCell:(__kindof UICollectionViewCell *)currentSelectedCell;

/** 移动滑块视图是否动画显示 */
- (BOOL)radioView:(CGRadioView *)radioView moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:(NSInteger)beforeSelectedIndex currentSelectedIndex:(NSInteger)currentSelectedIndex;

@end

/** 单选视图 */
@interface CGRadioView : CGLineBoxView

@property (nullable, nonatomic, weak) id<CGRadioViewDataSource> dataSource;
@property (nullable, nonatomic, weak) id<CGRadioViewDelegate> delegate;

/** 当前选择索引 */
@property (nonatomic, assign) NSInteger currentSelectedIndex;

/** 移动滑块是否动画执行 */
@property (nonatomic, assign) BOOL moveSliderViewIsAnimation;

/** 默认的滑块视图 */
@property (nullable, nonatomic, strong) CGRadioSliderView *sliderView;

- (instancetype)initWithFrame:(CGRect)frame appearance:(CGRadioViewAppearance *)appearance;

- (void)registerClassForCellWithReuseIdentifierClass:(Class)cellClass;
- (void)registerNibForCellWithReuseIdentifierClass:(Class)cellClass;
- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(nonnull NSIndexPath *)indexPath;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifierClass:(Class)identifierClass forIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
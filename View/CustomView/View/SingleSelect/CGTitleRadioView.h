//
//  CGTitleRadioView.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGRadioViewAppearance;

typedef NSString  * _Nonnull  (^CGTitleRadioGetTitleBlock) (NSInteger index, id obj);
typedef void (^CGTitleRadioSelectedBlock) (NSInteger index, id obj);

@interface CGTitleRadioView : CGBaseView

@property (nonatomic, strong) NSArray<NSString *>     *titles;
@property (nonatomic, assign) NSInteger currentSelectedTitleIndex;

/** 是否缓存大小 默认YES */
@property (nonatomic, assign) BOOL isCacheCellsSize;

@property (nullable, nonatomic, strong, readonly) CGRadioViewAppearance *appearance;

/** 已选择block */
@property (nullable, nonatomic, copy) CGTitleRadioSelectedBlock didSelectedCallback;

- (instancetype)initWithTitles:(nullable NSArray<NSString *> *)titles appearance:(CGRadioViewAppearance *)appearance;

/** 设置标题 */
- (void)setupTitlesWithDataSouce:(NSArray *)dataSource getTitleBlock:(CGTitleRadioGetTitleBlock)titleBlock;

/** 选择指定的标题索引 */
- (void)setupSelectedTitleIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
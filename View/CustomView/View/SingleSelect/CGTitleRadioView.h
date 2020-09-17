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

@property (nullable, nonatomic, strong) NSArray<NSString *>     *titles;
@property (nonatomic, assign) NSInteger currentSelectedTitleIndex;
//@property (nullable, nonatomic, strong, readonly) NSString *currentSelectedTitle;

/** 当前正在使用的数据 */
@property (nullable, nonatomic, readonly) NSArray *currentDataSouce;

/** 
 *  是否缓存cell大小 默认NO
 *  @see    当使用setupTitlesWithDataSouce:getTitleBlock:方法设置标题时，有可能标题会出现变化，此时应该取消缓存cell的大小
 */
@property (nonatomic, assign) BOOL isCacheCellsSize;

/** 是否关闭将选中的索引滑动到中间 */
@property (nonatomic, assign) BOOL disableCurrentSelectedIndexToCenterHorizontalPosition;

@property (nonatomic, strong, readonly) CGRadioViewAppearance *appearance;

/** 已选择block */
@property (nullable, nonatomic, copy) CGTitleRadioSelectedBlock didSelectedCallback;

- (instancetype)initWithTitles:(nullable NSArray<NSString *> *)titles appearance:(CGRadioViewAppearance *)appearance;

- (instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray<NSString *> *)titles appearance:(CGRadioViewAppearance *)appearance NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)scrollTopView;

/** 设置标题 */
- (void)setupTitlesWithDataSouce:(NSArray *)dataSource getTitleBlock:(CGTitleRadioGetTitleBlock)titleBlock;

/** 选择指定的标题索引 */
- (void)setupSelectedTitleIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END

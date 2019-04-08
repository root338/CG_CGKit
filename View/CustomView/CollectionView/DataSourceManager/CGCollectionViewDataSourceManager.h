//
//  CGCollectionViewDataSourceManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

@class CGCollectionViewCell;
NS_ASSUME_NONNULL_BEGIN

/** 手动设置 collectionView 多少组 */
typedef NSUInteger (^CGNumberOfSectionsInCollectionView) (UICollectionView *collectionView);

/** 设置 collectionView 每组的row值 */
typedef NSInteger (^CGCollectionViewNumberOfRowsInSection) (UICollectionView *collectionView, NSInteger section);

/** 获取 collectionView indexPath 下的 cell Identifier */
typedef _Nonnull Class (^CGCollectionViewReusableCellClassIdentifier) (UICollectionView *collectionView, NSIndexPath *indexPath);

/** 获取 collectionView indexPath 下的 cell Identifier */
typedef  NSString * _Nonnull  (^CGCollectionViewReusableCellStringIdentifier) (UICollectionView *collectionView, NSIndexPath *indexPath);

/** 获取 collectionView 中 indexPath 下的数据 */
typedef _Nonnull id (^CGCollectionViewDataSourceAtIndexPath) (UICollectionView *collectionView, NSIndexPath *indexPath);

/** 设置cell的block  */
typedef void (^CGSetupCollectionViewCell) (UICollectionView *collectionView, __kindof CGCollectionViewCell *cell, NSIndexPath *indexPath, id data);
/** 重写collectionView:cellForItemAtIndexPath:方法 */
typedef UICollectionViewCell * (^CGCollectionViewCellItemBlock) (UICollectionView *collectionView, NSIndexPath *indexPath);

@interface CGCollectionViewDataSourceManager : CGBaseObject<UICollectionViewDataSource>

/** 设置 collectionView 的 section 默认为1 */
@property (assign, nonatomic) NSInteger sectionNumber;

/** cell的唯一标识 */
@property (nullable, strong, nonatomic) NSString *cellIdentifier;

/**
 *  设置 collectionView 的 row 数，且每组 row 都为设置值
 *  在不需要数据添加cell时使用
 *  @warning 只有当dataSource为空时，否则 numberRowForAllSections 自动为dataSource count值
 */
@property (assign, nonatomic) NSInteger rowNumberForAllSections;

/** 需要加载的数据 */
@property (nullable, strong, nonatomic) NSArray *dataSource;

/**
 *  设置 collectionView 每组的 row 值
 *  在 section > 1 时使用
 *  @warning 优先级最高，当设置该block时，会忽略numberRowForAllSections,dataSource.count的值
 *  设置此block时应该同时设置dataSourceAtIndexPath值
 */
@property (nullable, copy, nonatomic) CGCollectionViewNumberOfRowsInSection numberOfRowsAtCollectionViewSection;

/**
 *  获取 indexPath 下的cell 类名作为标识符
 *  应该在多cell下使用
 */
//@property (nullable, copy, nonatomic) CGCollectionViewReusableCellClassIdentifier reusableCellClassIdentifier;

/**
 *  获取 indexPath 下的 cell Identifier
 *  应该在多 cell 下使用
 */
//@property (nullable, nonatomic, copy) CGCollectionViewReusableCellStringIdentifier reusableCellStringIdentifier;

@property (nonatomic, copy) CGCollectionViewCellItemBlock cellItemBlock;

/**
 *  获取 collectionView 中 indexPath 下的数据
 */
@property (copy, nonatomic) CGCollectionViewDataSourceAtIndexPath dataSourceAtIndexPath;

/**
 *  使用自动布局计算cell 默认NO
 *  当为YES时，在设置 方法中最后自动调用setNeedsUpdateConstraints, updateConstraintsIfNeeded方法重新布局
 */
@property (assign, nonatomic) BOOL isAutoLayoutCalculateCell;

/** 设置tableView中得cell */
@property (copy, nonatomic) CGSetupCollectionViewCell setupCollectionViewCell;

/**
 *  设置管理类（数据、cell标识（NSString）、设置cell block）
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell 在 collectionView 中的唯一标识
 *  @param setupCellBlock 设置cell的方法
 *
 */
- (void)setupDataSource:(nullable NSArray *)dataSource cellIdentifierForString:(nullable NSString *)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock;

/** 设置管理类（数据、cell标识（Class）、设置cell block） */
- (void)setupDataSource:(nullable NSArray *)dataSource cellIdentifierForClass:(nullable Class)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock;

/**
 *  初始化管理类，并设置（数据、cell标识（NSString）、设置cell block）
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell 在TableView中的唯一标识
 *  @param setupCellBlock 设置cell的方法
 *
 */
- (instancetype)initWithDataSource:(nullable NSArray *)dataSource cellIdentifierForString:(nullable NSString *)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock;

/** 初始化管理类，并设置（数据、cell标识（Class）、设置cell block） */
- (instancetype)initWithDataSource:(nullable NSArray *)dataSource cellIdentifierForClass:(nullable Class)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock;

@end
NS_ASSUME_NONNULL_END

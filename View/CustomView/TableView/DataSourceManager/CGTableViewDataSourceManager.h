//
//  CGTableViewDataSourceManager.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import <UIKit/UIKit.h>

@class CGTableViewCell;

NS_ASSUME_NONNULL_BEGIN
/** 手动设置tableView 多少组 */
typedef NSUInteger (^CGNumberOfSectionsInTableView) (UITableView *tableView);

/** 设置tableView每组的row值 */
typedef NSInteger (^CGTableViewNumberOfRowsInSection) (UITableView *tableView, NSInteger section);

/** 获取tableView indexPath 下的 cell Identifier */
typedef _Nonnull Class (^CGTableViewReusableCellClassIdentifier) (UITableView *tableView, NSIndexPath *indexPath);

/** 获取tableView indexPath 下的 cell Identifier */
typedef  NSString * _Nonnull  (^CGTableViewReusableCellStringIdentifier) (UITableView *tableView, NSIndexPath *indexPath);

/** 获取 tableView 中 indexPath 下的数据 */
typedef _Nonnull id (^CGTableViewDataSourceAtIndexPath) (UITableView *tableView, NSIndexPath *indexPath);

/** 设置cell的block  */
typedef void (^CGSetupTableViewCell) (UITableView *tableView, __kindof CGTableViewCell *cell, NSIndexPath *indexPath, id data);

/**
 *  tableView的数据管理类
 *  @warning 
        1. 非注册没有注册cell的功能
 *      2. 在添加以下文件时可创建一个子类来添加相应的文件，避免多余的资源浪费
 *              编辑 CGBaseTableViewDataSourceManager+CGEditTableViewCell.h文件
 *              设置组数，CGBaseTableViewDataSourceManager+CGSetupSectionNumber.h文件
 *      3. 使用 2. 之时的发现：扩展在本类没有导入该头文件下，以实现的方法也会被自动调用
 *      解决 2. 问题，不实现扩展，改为创建其子类
                CGBaseTableViewEditDataSourceManager.h 文件 实现便捷功能
 *
 */
@interface CGTableViewDataSourceManager : CGBaseObject<UITableViewDataSource>

/** 设置tableView 的 section 默认为1 */
@property (assign, nonatomic) NSInteger sectionNumber;

/** cell的唯一标识 */
@property (nullable, strong, nonatomic) NSString *cellIdentifier;

/** 
 *  设置tableView 的 row 数，且每组 row 都为设置值
 *  在不需要数据添加cell时使用
 *  @warning 只有当dataSource为空时，否责numberRowForAllSections 自动为dataSource count值
 */
@property (assign, nonatomic) NSInteger rowNumberForAllSections;

/** 需要加载的数据 */
@property (nullable, strong, nonatomic) NSArray *dataSource;

/** 
 *  设置 tableView 每组的 row 值
 *  在 section > 1 时使用
 *  @warning 优先级最高，当设置该block时，会忽略numberRowForAllSections,dataSource.count的值
 *  设置此block时应该同时设置dataSourceAtIndexPath值
 */
@property (nullable, copy, nonatomic) CGTableViewNumberOfRowsInSection numberOfRowsAtTableViewSection;

/**
 *  获取 indexPath 下的cell 类名作为标识符
 *  应该在多cell下使用
 */
@property (nullable, copy, nonatomic) CGTableViewReusableCellClassIdentifier reusableCellClassIdentifier;

/**
 *  获取 indexPath 下的 cell Identifier
 *  应该在多 cell 下使用
 */
@property (nullable, nonatomic, copy) CGTableViewReusableCellStringIdentifier reusableCellStringIdentifier;

/**
 *  获取 tableView 中 indexPath 下的数据
 */
@property (copy, nonatomic) CGTableViewDataSourceAtIndexPath dataSourceAtIndexPath;

/** 
 *  使用自动布局计算cell 默认NO
 *  当为YES时，在设置 方法中最后自动调用setNeedsUpdateConstraints, updateConstraintsIfNeeded方法重新布局
 */
@property (assign, nonatomic) BOOL isAutoLayoutCalculateCell;

/** 设置tableView中得cell */
@property (copy, nonatomic) CGSetupTableViewCell setupTableViewCell;

/**
 *  设置管理类（数据、cell标识（NSString）、设置cell block）
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell 在TableView中的唯一标识
 *  @param setupCellBlock 设置cell的方法
 *
 */
- (void)setupDataSource:(nullable NSArray *)dataSource cellIdentifierForString:(nullable NSString *)cellIdentifier setupCellBlock:(nullable CGSetupTableViewCell)setupCellBlock;

/** 设置管理类（数据、cell标识（Class）、设置cell block） */
- (void)setupDataSource:(nullable NSArray *)dataSource cellIdentifierForClass:(nullable Class)cellIdentifier setupCellBlock:(nullable CGSetupTableViewCell)setupCellBlock;

/**
 *  初始化管理类，并设置（数据、cell标识（NSString）、设置cell block）
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell 在TableView中的唯一标识
 *  @param setupCellBlock 设置cell的方法
 *
 */
- (instancetype)initWithDataSource:(nullable NSArray *)dataSource cellIdentifierForString:(nullable NSString *)cellIdentifier setupCellBlock:(nullable CGSetupTableViewCell)setupCellBlock;

/** 初始化管理类，并设置（数据、cell标识（Class）、设置cell block） */
- (instancetype)initWithDataSource:(nullable NSArray *)dataSource cellIdentifierForClass:(nullable Class)cellIdentifier setupCellBlock:(nullable CGSetupTableViewCell)setupCellBlock;
@end
NS_ASSUME_NONNULL_END

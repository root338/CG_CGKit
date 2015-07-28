//
//  CGSingleSectionTableViewDataSource.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleSectionBaseTableViewCell;

/**
 *  声明设置cell的block
 *
 *  @param cell 以CGSingleSectionBaseTableViewCell类型的cell为所有cell的基类
 *  @param data cell中的内容数据
 */
typedef void(^SetupSingleSectionTableViewCell) (CGSingleSectionBaseTableViewCell *cell, id data);

/**
 *  设置实现tableView
 *  @warning 此代理只实现单组TableView，且TableView中的cell样式只支持一种
 */
@interface CGSingleSectionTableViewDataSource : NSObject<UITableViewDataSource>

/**
 *  cell的唯一标识
 */
@property (strong, nonatomic) NSString *cellIdentifier;

/**
 *  需要加载的数据
 */
@property (strong, nonatomic) NSArray *dataSource;

/**
 *  设置cell的回调
 *  @warning 需要使用者自己实现
 */
@property (copy, nonatomic) SetupSingleSectionTableViewCell setupSingleSectionTableViewCellBlock;

/**
 *  初始化一个CGSingleSectionTableViewDataSource类实例
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell 在TableView中的唯一标识
 *  @param setupCellBlock 设置cell的方法
 *
 *  @return 返回创建好的实例
 */
- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock;

/**
 *  创建一个CGSingleSectionTableViewDataSource类实例
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell在TableView中的唯一标识——为字符串类型
 *  @param setupCellBlock 设置cell的方法
 *
 *  @return 返回创建好的实例
 */
+ (instancetype)createSingleSectionTableViewDelegateWithData:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock;

/**
 *  创建一个CGSingleSectionTableViewDataSource类实例
 *
 *  @param dataSource     需要加载的元数据
 *  @param cellIdentifier 加载cell在TableView中的唯一标识——为类类型
 *  @param setupCellBlock 设置cell的方法
 *
 *  @return 返回创建好的实例
 */
+ (instancetype)createSingleSectionTableViewDelegateWithData:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock;
@end

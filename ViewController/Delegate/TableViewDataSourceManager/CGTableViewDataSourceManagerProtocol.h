//
//  CGTableViewDataSourceManagerProtocol.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CGTableViewDataSourceManagerProtocol <NSObject>

@optional
#pragma mark - 数据加载管理类
/** 数据源 */
@property (nonatomic, strong, readonly) NSArray *dataSource;

/** 替换源数据数组 */
- (void)cg_reloadWithNewDataSouce:(NSArray *)dataSource;

/** 向列表中添加新数据 */
- (void)cg_dataSourceWithObjects:(NSArray *)objects;

/** 数据加载完毕 */
- (void)cg_dataSourceIsEnd;

#pragma mark - 数据添加表格的方法

- (UITableViewRowAnimation)cg_updateTableViewAnimation:(UITableViewCellEditingStyle)style;

/**
 *  插入连续索引（在指定section最后插入）
 *
 *  @param section   需要插入的组
 *  @param count     需要插入的个数
 *
 *  @return 返回需要插入的索引数组
 */
- (NSArray<NSIndexPath *> *)cg_insertWithSection:(NSInteger)section count:(NSUInteger)count;
@end


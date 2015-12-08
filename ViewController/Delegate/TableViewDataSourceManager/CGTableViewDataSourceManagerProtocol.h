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

/** 获取需要新插入的索引 */
- (NSArray<NSIndexPath *> *)cg_reloadRowsAtLastIndexPath:(NSIndexPath *)indexPath count:(NSUInteger)count;
@end


//
//  UITableView+CGIndexPath.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CGVerifityIndexPath)

/** 是否是第一个或最后一个cell */
- (BOOL)cg_judgeIsFirstLastCellWith:(NSIndexPath *)indexPath;

/** 是否是第一个cell */
- (BOOL)cg_judgeIsFirstCellWith:(NSIndexPath *)indexPath;

/** 是否是最后一个cell */
- (BOOL)cg_judgeIsLastCellWith:(NSIndexPath *)indexPath;

/** 判读指定组是否存在 */
- (BOOL)cg_judgeTableViewIsExistSection:(NSUInteger)section;

/** 判断指定索引是否存在 */
- (BOOL)cg_judgeTableViewWithSection:(NSUInteger)section isExistRow:(NSUInteger)row;

/** 判断指定索引是否存在 */
- (BOOL)cg_judgeTableViewWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface UITableView (CGIndexPath)

/** 获取指定 indexPath 的上一个索引 */
- (NSIndexPath *)cg_previousIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath;

/** 获取指定 indexPath 的下一个索引 */
- (NSIndexPath *)cg_nextIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath;

/** 获取指定值的索引 */
- (NSIndexPath *)cg_IndexPathForSection:(NSUInteger)section row:(NSUInteger)row;

/** 
 *  获取当前视图 的上一个索引
 *  @param currentCell 表示当前cell或其子视图
 */
- (NSIndexPath *)cg_previousIndexPathWithCurrentView:(UIView *)currentView;

/** 获取当前视图的下一个索引 */
- (NSIndexPath *)cg_nextIndexPathWithCurrentView:(UIView *)currentView;

/** 获取当前视图的索引 */
- (NSIndexPath *)cg_currentIndexPathWithCurrentView:(UIView *)currentView;
@end

@interface UITableView (CGVertexIndexPath)

/** 获取表格最后一个组 */
- (NSUInteger)cg_lastTableViewSection;

/** 获取表格第一个组 */
- (NSUInteger)cg_firstTableViewSection;

/** 获取指定组 */
- (NSUInteger)cg_TableViewSection:(NSUInteger)section;

/** 获取指定组最后一个索引 */
- (NSIndexPath *)cg_lastIndexPathForSection:(NSUInteger)section;

/** 获取指定组第一个索引 */
- (NSIndexPath *)cg_firstIndexPathForSection:(NSUInteger)section;

/** 获取表格最后一个索引 */
- (NSIndexPath *)cg_lastIndexPathForTableView;

/** 获取表格第一个索引 */
- (NSIndexPath *)cg_firstIndexPathForTableView;
@end


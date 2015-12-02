//
//  UITableView+FirstOrLastCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FirstLastCell)

/** 是否是第一个或最后一个cell */
- (BOOL)isFirstLastCellWith:(NSIndexPath *)indexPath;

/** 是否是第一个cell */
- (BOOL)isFirstCellWith:(NSIndexPath *)indexPath;

/** 是否是最后一个cell */
- (BOOL)isLastCellWith:(NSIndexPath *)indexPath;

@end

@interface UITableView (CGSetupIndexPath)

/** 判读指定组是否存在 */
- (BOOL)cg_tableViewIsExistSection:(NSUInteger)section;

/** 判断指定索引是否存在 */
- (BOOL)cg_tableViewWithSection:(NSUInteger)section isExistRow:(NSUInteger)row;

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

/** 获取指定值的索引 */
- (NSIndexPath *)cg_IndexPathForSection:(NSUInteger)section row:(NSUInteger)row;

/** 获取表格最后一个索引 */
- (NSIndexPath *)cg_lastIndexPathForTableView;

/** 获取表格第一个索引 */
- (NSIndexPath *)cg_firstIndexPathForTableView;
@end

@interface UITableView (CGSetupScroll)

/** 将表格滑动到底部 */
- (void)cg_tableViewScrollingToBottom;

/** 将表格滑动到底部，是否动画 */
- (void)cg_tableViewScrollingToBottomIsAnimated:(BOOL)isAnimated;
@end

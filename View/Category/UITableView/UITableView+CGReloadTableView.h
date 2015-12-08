//
//  UITableView+CGReloadTableView.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/8.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 刷新表格相关 */
@interface UITableView (CGReloadTableView)

#pragma mark - 刷新第一组索引
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row;
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row animation:(UITableViewRowAnimation)animation;

- (void)cg_reloadFirstSectionWithRows:(NSArray<NSNumber *> *)rows;
- (void)cg_reloadFirstSectionWithRows:(NSArray<NSNumber *> *)rows animation:(UITableViewRowAnimation)animation;

#pragma mark - 刷新指定索引
- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath;
- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;


- (void)cg_reloadRowsWithIndexPaths:(nullable NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
@end

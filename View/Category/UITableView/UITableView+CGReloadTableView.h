//
//  UITableView+CGReloadTableView.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/8.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 刷新表格相关 */
@interface UITableView (CGReloadTableView)

/**
 *  创建同组，但不同row 的NSIndexPath
 *
 *  @param rows                     row 数组
 *  @param section                  添加的组数
 *  @param isVerityExistAtTableView 是否验证是否存在于tableView，当为YES时，不存在tableView的IndexPath会被舍弃
 *
 *  @return 返回被创建的索引数组
 */
- (NSArray<NSIndexPath *> *)cg_createIndexPathsAtRows:(NSSet<NSNumber *> *)rows section:(NSInteger)section isVerityExistAtTableView:(BOOL)isVerityExistAtTableView;

/**
 *  创建同组，且连续的IndexPath
 *
 *  @param row                      开始row
 *  @param section                  添加的数组
 *  @param count                    添加的索引个数
 *  @param isVerityExistAtTableView 是否验证是否存在于tableView，当为YES时，不存在tableView的IndexPath会被舍弃
 *
 *  @return 返回被创建的索引数组
 */
- (NSArray<NSIndexPath *> *)cg_createIndexPathsAtStartRow:(NSInteger)row section:(NSInteger)section count:(NSInteger)count isVerityExistAtTableView:(BOOL)isVerityExistAtTableView;

#pragma mark - 刷新组
/** 刷新组 */
- (void)cg_reloadFirstSectionWithAnimation:(UITableViewRowAnimation)animation;
/** 刷新组 */
- (void)cg_reloadWithSection:(NSInteger)section animation:(UITableViewRowAnimation)animation;

#pragma mark - 刷新第一组索引
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row;
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row animation:(UITableViewRowAnimation)animation;

- (void)cg_reloadFirstSectionWithRows:(NSSet<NSNumber *> *)rows;
- (void)cg_reloadFirstSectionWithRows:(NSSet<NSNumber *> *)rows animation:(UITableViewRowAnimation)animation;

#pragma mark - 刷新指定索引
- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath;
- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;
- (void)cg_reloadRowsWithIndexPaths:(nullable NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 插入cell
/**
 *  向指定组最后插入count个cell
 *
 *  @param section   插入的组索引
 *  @param count     出入的cell个数
 *  @param animation 执行的动画
 */
- (void)cg_insertTableViewsSection:(NSInteger)section count:(NSInteger)count animation:(UITableViewRowAnimation)animation;

#pragma mark
- (void)cg_updateTableViewsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths type:(UITableViewCellEditingStyle)style animation:(UITableViewRowAnimation)animation;


@end
NS_ASSUME_NONNULL_END
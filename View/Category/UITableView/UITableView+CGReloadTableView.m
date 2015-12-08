//
//  UITableView+CGReloadTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/8.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+CGReloadTableView.h"
#import "UITableView+FirstLastCell.h"

@implementation UITableView (CGReloadTableView)

#pragma mark - 刷新第一组索引
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row
{
    [self cg_reloadFirstSectionWithRow:row animation:UITableViewRowAnimationNone];
}

- (void)cg_reloadFirstSectionWithRow:(NSInteger)row animation:(UITableViewRowAnimation)animation
{
    
    [self cg_reloadWithIndexPath:[self cg_IndexPathForSection:0 row:row] animation:animation];
}

- (void)cg_reloadFirstSectionWithRows:(NSArray<NSNumber *> *)rows
{
    [self cg_reloadFirstSectionWithRows:rows animation:UITableViewRowAnimationNone];
}

- (void)cg_reloadFirstSectionWithRows:(NSArray<NSNumber *> *)rows animation:(UITableViewRowAnimation)animation
{
    if (!rows.count) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    [rows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [self cg_IndexPathForSection:0 row:obj.integerValue];
        !indexPath ?: [array addObject:indexPath];
    }];
    if (array.count) {
        //由于在创建的时候就判断索引是否存在，索引直接调用系统刷洗方法
        [self reloadRowsAtIndexPaths:array withRowAnimation:animation];
    }
}

#pragma mark - 刷新指定索引
- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath
{
    
    [self cg_reloadWithIndexPath:indexPath animation:UITableViewRowAnimationNone];
}

- (void)cg_reloadWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation
{
    if (!indexPath) {
        return;
    }
    [self cg_reloadRowsWithIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)cg_reloadRowsWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    if (!indexPaths.count) {
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self cg_judgeTableViewWithIndexPath:obj]) {
            [array addObject:obj];
        }
    }];
    if (array.count) {
        [self reloadRowsAtIndexPaths:array withRowAnimation:animation];
    }
}

@end

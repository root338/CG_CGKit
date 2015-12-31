//
//  UITableView+CGReloadTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/8.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+CGReloadTableView.h"
#import "UITableView+CGIndexPath.h"

#import "NSArray+CGArray.h"

@implementation UITableView (CGReloadTableView)

- (NSIndexPath *)cg_createIndexPathWithSection:(NSInteger)section row:(NSInteger)row isVerityExistAtTableView:(BOOL)isVerityExistAtTableView
{
    NSIndexPath *indexPath = nil;
    if (isVerityExistAtTableView) {
        indexPath = [self cg_IndexPathForSection:section row:row];
    }else {
        indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    return indexPath;
}

- (NSArray<NSIndexPath *> *)cg_createIndexPathsAtRows:(NSSet<NSNumber *> *)rows section:(NSInteger)section isVerityExistAtTableView:(BOOL)isVerityExistAtTableView
{
    if (!rows.count) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [rows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [self cg_createIndexPathWithSection:section
                                                                 row:obj.integerValue
                                            isVerityExistAtTableView:isVerityExistAtTableView];
        !indexPath ?: [array addObject:indexPath];
    }];
    return array;
}

- (NSArray<NSIndexPath *> *)cg_createIndexPathsAtStartRow:(NSInteger)row section:(NSInteger)section count:(NSInteger)count isVerityExistAtTableView:(BOOL)isVerityExistAtTableView
{
    if (!count) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = 0; index < count; index++) {
        
        NSIndexPath *indexPath = [self cg_createIndexPathWithSection:section
                                                                 row:row
                                            isVerityExistAtTableView:isVerityExistAtTableView];
        !indexPath ?: [array addObject:indexPath];
        row++;
    }
    return array;
}

#pragma mark - 刷新组
- (void)cg_reloadFirstSectionWithAnimation:(UITableViewRowAnimation)animation
{
    [self cg_reloadWithSection:0 animation:animation];
}

- (void)cg_reloadWithSection:(NSInteger)section animation:(UITableViewRowAnimation)animation
{
    if ([self cg_judgeTableViewIsExistSection:section]) {
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:animation];
    }else {
        CGErrorLog(@"刷新的组不存在");
    }
}

#pragma mark - 刷新第一组索引
- (void)cg_reloadFirstSectionWithRow:(NSInteger)row
{
    [self cg_reloadFirstSectionWithRow:row animation:UITableViewRowAnimationNone];
}

- (void)cg_reloadFirstSectionWithRow:(NSInteger)row animation:(UITableViewRowAnimation)animation
{
    
    [self cg_reloadWithIndexPath:[self cg_IndexPathForSection:0 row:row] animation:animation];
}

- (void)cg_reloadFirstSectionWithRows:(NSSet<NSNumber *> *)rows
{
    [self cg_reloadFirstSectionWithRows:rows animation:UITableViewRowAnimationNone];
}

- (void)cg_reloadFirstSectionWithRows:(NSSet<NSNumber *> *)rows animation:(UITableViewRowAnimation)animation
{
    if (!rows.count) {
        return;
    }
    NSArray *array = [self cg_createIndexPathsAtRows:rows
                                             section:0
                            isVerityExistAtTableView:YES];
    if (array.count) {
        //由于在创建的时候就判断索引是否存在，索引直接调用系统刷洗方法
        [self cg_updateTableViewsAtIndexPath:array
                                        type:UITableViewCellEditingStyleNone
                                   animation:animation];
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
        [self cg_updateTableViewsAtIndexPath:array
                                        type:UITableViewCellEditingStyleNone
                                   animation:animation];
    }
}

- (void)cg_insertTableViewsSection:(NSInteger)section count:(NSInteger)count animation:(UITableViewRowAnimation)animation
{
    if ([self cg_judgeTableViewIsExistSection:section]) {
        
        NSArray<NSIndexPath *> *indexPaths = [self cg_createIndexPathsAtStartRow:[self numberOfRowsInSection:section] section:section count:count isVerityExistAtTableView:NO];
        [self cg_updateTableViewsAtIndexPath:indexPaths type:UITableViewCellEditingStyleInsert animation:animation];
    }else {
        CGErrorLog(@"不存在该组");
    }
    
}

#pragma mark - 删除、插入
- (void)cg_updateTableViewsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths type:(UITableViewCellEditingStyle)style animation:(UITableViewRowAnimation)animation
{
    [self beginUpdates];
    
    switch (style) {
        case UITableViewCellEditingStyleDelete:
            [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
            break;
        case UITableViewCellEditingStyleInsert:
            [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
            break;
        default:
            [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
            break;
    }
    
    [self endUpdates];
}

@end

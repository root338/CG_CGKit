//
//  UITableView+CGIndexPath.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UITableView+CGIndexPath.h"
#import "UIView+CGSetupFrame.h"

#import "UIView+CGSearchView.h"
#import "CGPrintLogHeader.h"

typedef NS_ENUM(NSInteger, CGTableViewOfIndexPathType) {

    CGTableViewOfIndexPathTypePrevious = -1,
    CGTableViewOfIndexPathTypeNext = 1,
};

@implementation UITableView (CGVerifityIndexPath)

- (BOOL)cg_judgeIsFirstLastCellWith:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        return NO;
    }
    return [self cg_judgeIsFirstCellWith:indexPath] || [self cg_judgeIsLastCellWith:indexPath];
}

- (BOOL)cg_judgeIsFirstCellWith:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        return NO;
    }
    return indexPath.row == 0;
}

- (BOOL)cg_judgeIsLastCellWith:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        return NO;
    }
    return ([self numberOfRowsInSection:indexPath.section] - 1) == indexPath.row;
}

- (BOOL)cg_judgeTableViewIsExistSection:(NSUInteger)section
{
    return self.numberOfSections > section;
}

- (BOOL)cg_judgeTableViewWithSection:(NSUInteger)section isExistRow:(NSUInteger)row
{
    return [self cg_judgeTableViewIsExistSection:section] && [self numberOfRowsInSection:section] > row;
}

- (BOOL)cg_judgeTableViewWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        return NO;
    }
    return [self cg_judgeTableViewWithSection:indexPath.section isExistRow:indexPath.row];
}

@end

@implementation UITableView (CGIndexPath)

- (NSIndexPath *)cg_previousIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    return [self cg_indexPathWithType:CGTableViewOfIndexPathTypePrevious currentIndexPath:currentIndexPath];
}

- (NSIndexPath *)cg_nextIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    return [self cg_indexPathWithType:CGTableViewOfIndexPathTypeNext currentIndexPath:currentIndexPath];
}

- (NSIndexPath *)cg_indexPathWithType:(CGTableViewOfIndexPathType)type currentIndexPath:(NSIndexPath *)currentIndexPath
{
    NSInteger section           = currentIndexPath.section;
    NSInteger row               = currentIndexPath.row;
    NSIndexPath *newIndexPath   = nil;
    
    if ([self cg_judgeTableViewWithSection:section isExistRow:row + type]) {
        
        newIndexPath =  [self cg_IndexPathForSection:section row:row + type];
    }else if ([self cg_judgeTableViewIsExistSection:section + type]) {
        
        NSInteger newSection = section + type;
        if (type == CGTableViewOfIndexPathTypePrevious) {
            newIndexPath = [self cg_lastIndexPathForSection:newSection];
        }else {
            newIndexPath = [self cg_firstIndexPathForSection:newSection];
        }
    }
    
    return newIndexPath;
}

- (NSIndexPath *)cg_IndexPathForSection:(NSUInteger)section row:(NSUInteger)row
{
    if ([self cg_judgeTableViewWithSection:section isExistRow:row]) {
        return [NSIndexPath indexPathForRow:row inSection:section];
    }else {
        CGErrorLog(@"指定的索引不存在");
    }
    return nil;
}

- (NSIndexPath *)cg_previousIndexPathWithCurrentView:(UIView *)currentView
{
    NSIndexPath *indexPath = [self cg_currentIndexPathWithCurrentView:currentView];
    return [self cg_previousIndexPathWithCurrentIndexPath:indexPath];
}

- (NSIndexPath *)cg_nextIndexPathWithCurrentView:(UIView *)currentView
{
    NSIndexPath *indexPath = [self cg_currentIndexPathWithCurrentView:currentView];
    return [self cg_nextIndexPathWithCurrentIndexPath:indexPath];
}

- (NSIndexPath *)cg_currentIndexPathWithCurrentView:(UIView *)currentView
{
    UITableViewCell *cell = nil;
    if ([currentView isKindOfClass:[UITableViewCell class]]) {
        cell = (id)currentView;
    }else {
        cell = [currentView searchSuperViewWithClass:[UITableViewCell class]];
    }
    NSIndexPath *currentIndexPath = nil;
    if (cell) {
        currentIndexPath = [self indexPathForCell:cell];
    }
    return currentIndexPath;
}

@end

@implementation UITableView (CGVertexIndexPath)

- (NSUInteger)cg_lastTableViewSection
{
    return [self cg_TableViewSection:self.numberOfSections - 1];
}

- (NSUInteger)cg_firstTableViewSection
{
    return [self cg_TableViewSection:0];
}

- (NSUInteger)cg_TableViewSection:(NSUInteger)section
{
    return [self cg_judgeTableViewIsExistSection:section] ? section : 0;
}

- (NSIndexPath *)cg_firstIndexPathForSection:(NSUInteger)section
{
    return [self cg_IndexPathForSection:section row:0];
}

- (NSIndexPath *)cg_lastIndexPathForSection:(NSUInteger)section
{
    if ([self cg_judgeTableViewIsExistSection:section]) {
        
        NSUInteger row = [self numberOfRowsInSection:section] - 1;
        return [self cg_IndexPathForSection:section row:row];
    }
    
    return nil;
}

- (NSIndexPath *)cg_lastIndexPathForTableView
{
    return [self cg_lastIndexPathForSection:[self cg_lastTableViewSection]];
}

- (NSIndexPath *)cg_firstIndexPathForTableView
{
    return [self cg_firstIndexPathForSection:[self cg_firstTableViewSection]];
}

@end

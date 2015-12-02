//
//  UITableView+FirstOrLastCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+FirstLastCell.h"
#import "UIView+CGSetupFrame.h"

@implementation UITableView (FirstLastCell)

- (BOOL)isFirstLastCellWith:(NSIndexPath *)indexPath
{
    return [self isFirstCellWith:indexPath] || [self isLastCellWith:indexPath];
}

- (BOOL)isFirstCellWith:(NSIndexPath *)indexPath
{
    return indexPath.row == 0;
}

- (BOOL)isLastCellWith:(NSIndexPath *)indexPath
{
    return ([self numberOfRowsInSection:indexPath.section] - 1) == indexPath.row;
}

@end

@implementation UITableView (CGSetupIndexPath)

- (BOOL)cg_tableViewIsExistSection:(NSUInteger)section
{
    return self.numberOfSections > section;
}

- (BOOL)cg_tableViewWithSection:(NSUInteger)section isExistRow:(NSUInteger)row
{
    return [self cg_tableViewIsExistSection:section] && [self numberOfRowsInSection:section] > row;
}

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
    return [self cg_tableViewIsExistSection:section] ? section : 0;
}

- (NSIndexPath *)cg_firstIndexPathForSection:(NSUInteger)section
{
    return [self cg_IndexPathForSection:section row:0];
}

- (NSIndexPath *)cg_lastIndexPathForSection:(NSUInteger)section
{
    if ([self cg_tableViewIsExistSection:section]) {
        
        NSUInteger row = [self numberOfRowsInSection:section] - 1;
        return [self cg_IndexPathForSection:section row:row];
    }
    
    return nil;
}

- (NSIndexPath *)cg_IndexPathForSection:(NSUInteger)section row:(NSUInteger)row
{
    if ([self cg_tableViewWithSection:section isExistRow:row]) {
        return [NSIndexPath indexPathForRow:row inSection:section];
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

@implementation UITableView (CGSetupScroll)

- (void)cg_tableViewScrollingToBottom
{
    [self cg_tableViewScrollingToBottomIsAnimated:NO];
}

- (void)cg_tableViewScrollingToBottomIsAnimated:(BOOL)isAnimated
{
    CGFloat offsetY = self.contentSize.height - self.height;
    if (offsetY > 0) {
        CGPoint contentOffset = CGPointMake(self.contentOffset.x, offsetY);
        [self setContentOffset:contentOffset animated:isAnimated];
    }
}

@end
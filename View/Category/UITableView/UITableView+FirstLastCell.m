//
//  UITableView+FirstOrLastCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+FirstLastCell.h"

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

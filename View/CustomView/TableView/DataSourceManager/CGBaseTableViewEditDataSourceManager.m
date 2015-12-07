//
//  CGBaseTableViewEditDataSourceManager.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/7.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseTableViewEditDataSourceManager.h"

@implementation CGBaseTableViewEditDataSourceManager

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.commitEditingTableView) {
        self.commitEditingTableView(tableView, editingStyle, indexPath);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isCanEdit = self.isCanEditTableView;
    
    if (self.canEditTableView) {
        isCanEdit = self.canEditTableView(tableView, indexPath);
    }
    
    return isCanEdit;
}

@end

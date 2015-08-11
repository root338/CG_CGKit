//
//  UIView+DeleteTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+DeleteTableView.h"
#import <objc/runtime.h>

@implementation UIView (DeleteTableView)

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 设置属性
- (void)setDataSource_loadData:(NSMutableArray *)paramDataSource_loadData
{
    objc_setAssociatedObject(self, @selector(dataSource_loadData), paramDataSource_loadData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dataSource_loadData
{
    return objc_getAssociatedObject(self, @selector(dataSource_loadData));
}

@end

//
//  CGBaseTableView+CGEditTableViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableViewDataSourceManager+CGEditTableViewCell.h"

#import <objc/runtime.h>

@implementation CGBaseTableViewDataSourceManager (CGEditTableViewCell)

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

#pragma mark - 设置属性
- (void)setIsCanEditTableView:(BOOL)isCanEdit
{
    objc_setAssociatedObject(self, @selector(isCanEditTableView), @(isCanEdit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isCanEditTableView
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCanEditTableView:(CGCanEditTableView)canEditBlock
{
    objc_setAssociatedObject(self, @selector(canEditTableView), canEditBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGCanEditTableView)canEditTableView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCommitEditingTableView:(CGCommitEditingTableView)commitEditingBlock
{
    objc_setAssociatedObject(self, @selector(commitEditingTableView), commitEditingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGCommitEditingTableView)commitEditingTableView
{
    return objc_getAssociatedObject(self, _cmd);
}
@end

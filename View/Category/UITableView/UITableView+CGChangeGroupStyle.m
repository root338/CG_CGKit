//
//  UITableView+CGChangeGroupStyle.m
//  TestProject
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 -. All rights reserved.
//

#import "UITableView+CGChangeGroupStyle.h"

#import "CGPrintLogHeader.h"

const CGFloat   _CG_TableView_ZeroHeight    = 0.0001;

const CGRect    _CG_TableView_ZeroRect      = { { 0, 0 }, { 0, _CG_TableView_ZeroHeight } };

@implementation UITableView (CGChangeGroupStyle)

- (UIView *)cg_createZeroView
{
    return [[UIView alloc] initWithFrame:_CG_TableView_ZeroRect];
}

- (void)cg_tableViewChangeHeaderViewZeroHeight
{
    UIView *view = [self cg_createZeroView];
    
    CGInfoConditionLog(self.tableHeaderView, @"UITableView:%@ 源表格tableHeaderView被替换", self);
    [self beginUpdates];
    self.tableHeaderView = view;
    [self endUpdates];
}

- (void)cg_tableViewChangeFooterViewZeroHeight
{
    UIView *view = [self cg_createZeroView];
    
    CGInfoConditionLog(self.tableFooterView, @"UITableView:%@ 源表格tableFooterView被替换", self);
    [self beginUpdates];
    self.tableFooterView = view;
    [self endUpdates];
}

- (void)cg_tableViewChangeHeaderFooterZeroHeight
{
    [self cg_tableViewChangeHeaderViewZeroHeight];
    [self cg_tableViewChangeFooterViewZeroHeight];
}

- (void)cg_tableViewChangeSectionHeaderViewZeroHeight
{
    self.sectionHeaderHeight = _CG_TableView_ZeroHeight;
}

- (void)cg_tableViewChangeSectionFooterViewZeroHeight
{
    self.sectionFooterHeight = _CG_TableView_ZeroHeight;
}

@end

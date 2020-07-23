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

- (UIView *)cg_createViewWithHeight:(CGFloat)height
{
    CGRect frame     = CGRectMake(0, 0, 0, height);
    return [[UIView alloc] initWithFrame:frame];
}

- (void)cg_tableViewChangeHeaderViewZeroHeight
{
    [self cg_tableViewChangeHeaderViewWithHeight:_CG_TableView_ZeroHeight];
}

- (void)cg_tableViewChangeHeaderViewWithHeight:(CGFloat)height
{
    UIView *view = [self cg_createViewWithHeight:MAX(_CG_TableView_ZeroHeight, height)];
    
    CGInfoConditionLog(self.tableHeaderView, @"UITableView:%@ 源表格tableHeaderView被替换", self);
    self.tableHeaderView = view;
}

- (void)cg_tableViewChangeFooterViewZeroHeight
{
    [self cg_tableViewChangeFooterViewWithHeight:_CG_TableView_ZeroHeight];
}

- (void)cg_tableViewChangeFooterViewWithHeight:(CGFloat)height
{
    UIView *view = [self cg_createViewWithHeight:MAX(_CG_TableView_ZeroHeight, height)];
    
    CGInfoConditionLog(self.tableFooterView, @"UITableView:%@ 源表格tableFooterView被替换", self);
    self.tableFooterView = view;
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

- (void)cg_tableViewChangeSectionHeaderFooterZeroHeight
{
    [self cg_tableViewChangeSectionHeaderViewZeroHeight];
    [self cg_tableViewChangeSectionFooterViewZeroHeight];
}

- (void)cg_tableViewChangeAllHeaderFooterZeroHeight
{
    [self cg_tableViewChangeHeaderViewZeroHeight];
    [self cg_tableViewChangeFooterViewZeroHeight];
    [self cg_tableViewChangeSectionHeaderViewZeroHeight];
    [self cg_tableViewChangeSectionFooterViewZeroHeight];
}

- (void)cg_headerViewHeight:(CGFloat)headerViewHeight footerViewHeight:(CGFloat)footerViewHeight {
    [self cg_tableViewChangeHeaderViewWithHeight:headerViewHeight];
    [self cg_tableViewChangeFooterViewWithHeight:footerViewHeight];
}

@end

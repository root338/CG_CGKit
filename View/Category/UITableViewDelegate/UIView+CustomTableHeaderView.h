//
//  UIView+CustomTableHeaderView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/11.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置表格页眉或页脚视图
 *
 *  @param flag      当为yes 表示返回视图高度， no 表示返回视图
 *  @param tableView 当前表格
 *  @param section   加载的组
 *
 *  @return 返回目标信息
 */
typedef id (^SetupSectionViewProperty) (BOOL flag, UITableView *tableView, NSInteger section);

/** 快捷创建tableView 头视图 */
@interface UIView (CustomTableHeaderView)<UITableViewDelegate>

/** 设置页眉 */
@property (copy, nonatomic) SetupSectionViewProperty setupTableViewHeader;

#pragma mark - 表格设置页眉的代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
@end

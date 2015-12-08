//
//  CGBaseTableViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/10.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGBaseTableView.h"

/**
 *  基础UITableView视图控制器
 *  @param 用于需要在和tableView同级情况下添加其他视图到视图控制器中
 #  @param tableView会在get方法中自动创建，但不会自动添加到视图上
 */
@interface CGBaseTableViewController : CGBaseViewController

#pragma mark - UI
@property (nonatomic, strong, readonly) CGBaseTableView *tableView;

#pragma mark - UI 外观设置
/** tableView 的样式 */
@property (assign, nonatomic) UITableViewStyle tableViewStyle;

@end

//
//  CGBaseTableViewEditDataSourceManager.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/7.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseTableViewDataSourceManager.h"

/** 是否可以编辑taleView */
typedef BOOL (^CGCanEditTableView) (UITableView *tableView, NSIndexPath *indexPath);

/** 编辑tableView具体执行的内容 */
typedef void (^CGCommitEditingTableView) (UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);

/**
 *  对CGBaseTableViewDataSourceManager类功能的扩展, 可以对TableView中的cell进行增加删除
 */
@interface CGBaseTableViewEditDataSourceManager : CGBaseTableViewDataSourceManager

/** 全局设定是否可以编辑tableView */
@property (assign, nonatomic) BOOL isCanEditTableView;

/** 是否可以编辑TableView */
@property (copy, nonatomic) CGCanEditTableView canEditTableView;

/** 编辑执行的内容 */
@property (copy, nonatomic) CGCommitEditingTableView commitEditingTableView;

@end

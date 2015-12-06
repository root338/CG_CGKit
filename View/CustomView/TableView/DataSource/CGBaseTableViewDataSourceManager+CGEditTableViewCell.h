//
//  CGBaseTableView+CGEditTableViewCell.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableView.h"

/** 是否可以编辑taleView */
typedef BOOL (^CGCanEditTableView) (UITableView *tableView, NSIndexPath *indexPath);

/** 编辑tableView具体执行的内容 */
typedef void (^CGCommitEditingTableView) (UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);

/**
 *  编辑TableView。对TableView增加删除
 */
@interface CGBaseTableViewDataSourceManager (CGEditTableViewCell)

/** 全局设定是否可以编辑tableView */
@property (assign, nonatomic) BOOL isCanEditTableView;

/** 是否可以编辑TableView */
@property (copy, nonatomic) CGCanEditTableView canEditTableView;

/** 编辑执行的内容 */
@property (copy, nonatomic) CGCommitEditingTableView commitEditingTableView;
@end

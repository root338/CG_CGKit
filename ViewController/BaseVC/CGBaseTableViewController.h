//
//  CGBaseTableViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/10.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseViewController.h"

@interface CGBaseTableViewController : CGBaseViewController<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI
@property (strong, nonatomic) UITableView *tableView;

#pragma mark - UI 外观设置
/** tableView 的样式 */
@property (assign, nonatomic) UITableViewStyle tableViewStyle;

#pragma mark - data
/** 表格加载的数据 */
@property (strong, nonatomic) NSMutableArray *dataSource;

/** 表格显示的组数 默认为1 */
//@property (assign, nonatomic) NSInteger sectionForTableView;

@end

//
//  CGSingleSectionBaseTableView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSingleSectionTableViewDataSource.h"

/**
 *  单组，单类型cell，tableView
 */
@interface CGSingleSectionBaseTableView : UITableView

+ (instancetype)createSingleSectionBaseTableViewWithDataSource:(NSArray *)dataSource cellClass:(Class)cellClass setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock;

@end

//
//  CGSingleSectionBaseTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGSingleSectionBaseTableView.h"
#import "UITableView+CGCreateTableView.h"

@implementation CGSingleSectionBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createSingleSectionBaseTableViewWithDataSource:(NSArray *)dataSource cellClass:(Class)cellClass setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    
    CGSingleSectionBaseTableView *tableView = [CGSingleSectionBaseTableView createTableViewStyle:UITableViewStylePlain];
    CGSingleSectionTableViewDataSource *_dataSource = [CGSingleSectionTableViewDataSource createSingleSectionTableViewDelegateWithData:dataSource cellIdentifierForClass:cellClass setupCellBlock:setupCellBlock];
    tableView.dataSourceAtSingleSection = _dataSource;
    return tableView;
}

@end

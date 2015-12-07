//
//  CGSingleSectionBaseTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGSingleSectionBaseTableView.h"
#import "UITableView+CGCreateTableView.h"

@interface CGSingleSectionBaseTableView ()

@property (strong, nonatomic, readwrite) CGSingleSectionTableViewDataSource *dataSourceAtSingleSection;

@end

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
    [tableView.dataSourceAtSingleSection setupDataSource:dataSource cellIdentifierForClass:cellClass setupCellBlock:setupCellBlock];
    
    return tableView;
}

#pragma mark - 设置属性
- (CGSingleSectionTableViewDataSource *)dataSourceAtSingleSection
{
    if (_dataSourceAtSingleSection) {
        return _dataSourceAtSingleSection;
    }
    _dataSourceAtSingleSection = [[CGSingleSectionTableViewDataSource alloc] init];
    return _dataSourceAtSingleSection;
}

@end

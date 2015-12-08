//
//  CGSingleTableViewController.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGSingleTableViewController.h"

//视图扩展
#import "UITableView+CGReloadTableView.h"
#import "UITableView+CGIndexPath.h"

//其他功能类
#import "NSArray+CGArray.h"


@interface CGSingleTableViewController ()
{
    NSMutableArray *_dataSource;
}

@end

@implementation CGSingleTableViewController

#pragma mark - CGTableViewDataSourceManagerProtocol
- (void)cg_dataSourceWithObjects:(NSArray *)objects
{
    
    //更新数据
    [[self cg_dataSource] addObjectsFromArray:objects];
    
    //
    NSIndexPath *lastIndexPath = [self.tableView cg_lastIndexPathForTableView];
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleInsert;
    NSArray *indexPaths = [self cg_reloadRowsAtLastIndexPath:lastIndexPath count:objects.count];
    UITableViewRowAnimation animation = [self cg_updateTableViewAnimation:style];
    [self.tableView cg_updateTableViewsAtIndexPath:indexPaths type:UITableViewCellEditingStyleNone animation:animation];
}

- (void)cg_reloadWithNewDataSouce:(NSArray *)dataSource
{
    _dataSource = [NSMutableArray arrayWithArray:dataSource];
    [self.tableView reloadData];
}

- (void)cg_dataSourceIsEnd
{
    
}

- (NSArray<NSIndexPath *> *)cg_reloadRowsAtLastIndexPath:(NSIndexPath *)indexPath count:(NSUInteger)count
{
    NSArray *indexPaths = [self.tableView cg_createIndexPathsAtStartRow:indexPath.row + 1
                                                                section:indexPath.section
                                                                  count:count
                                               isVerityExistAtTableView:NO];
    return indexPaths;
}

- (UITableViewRowAnimation)cg_updateTableViewAnimation:(UITableViewCellEditingStyle)style
{
    UITableViewRowAnimation animation = UITableViewRowAnimationNone;
    switch (style) {
        case UITableViewCellEditingStyleInsert:
            animation = UITableViewRowAnimationAutomatic;
            break;
        case UITableViewCellEditingStyleDelete:
            animation   = UITableViewRowAnimationAutomatic;
            break;
        case UITableViewCellEditingStyleNone:
            
            break;
        default:
            break;
    }
    
    return animation;
}

#pragma mark - 私有数据设置
- (NSMutableArray *)cg_dataSource
{
    if (_dataSource) {
        return _dataSource;
    }
    
    _dataSource = [NSMutableArray array];
    return _dataSource;
}

#pragma mark - 设置属性
- (NSArray *)dataSource
{
    return _dataSource;
}
@end

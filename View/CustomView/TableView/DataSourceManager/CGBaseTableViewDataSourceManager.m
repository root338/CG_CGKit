//
//  CGBaseTableViewDataSourceManager.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableViewDataSourceManager.h"

#import "NSArray+CGArray.h"

#import "CGPrintLogHeader.h"

@implementation CGBaseTableViewDataSourceManager

- (void)initialization
{
    _sectionNumber              = 1;
    _rowNumberForAllSections    = 0;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    CGErrorConditionLog(!self.sectionNumber, @"%@的组数为0", tableView);
    return self.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.numberOfRowsAtTableViewSection) {
        self.rowNumberForAllSections = self.numberOfRowsAtTableViewSection(tableView, section);
    }else if (self.dataSource) {
        self.rowNumberForAllSections = self.dataSource.count;
    }
    return self.rowNumberForAllSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    if (self.reusableCellIdentifier) {
        id value = self.reusableCellIdentifier(tableView, indexPath);
        
        if (value) {
            if ([value isKindOfClass:[NSString class]]) {
                
                cellIdentifier = value;
            }else {
                
                cellIdentifier = NSStringFromClass(value);
            }
        }
    }else if (self.cellIdentifier) {
        
        cellIdentifier = self.cellIdentifier;
    }
    
    CGDebugAssert(cellIdentifier, @"cell 的标识不能为空");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    CGDebugAssert(cell, @"没有注册 cell");
    
    id data = nil;
    if (self.dataSourceAtIndexPath) {
        data = self.dataSourceAtIndexPath(tableView, indexPath);
    }else if (self.dataSource) {
        data = [self.dataSource cg_objectAtIndex:indexPath.row];
    }
    
    if (self.setupTableViewCell) {
        self.setupTableViewCell(tableView, (id)cell, indexPath, data);
    }
    
    return cell;
}

#pragma mark - 初始化设置
- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock
{
    self = [super init];
    if (self) {
        [self setupDataSource:dataSource cellIdentifierForString:cellIdentifier setupCellBlock:setupCellBlock];
    }
    return self;
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock
{
    [self setupDataSource:dataSource cellIdentifierForString:NSStringFromClass(cellIdentifier) setupCellBlock:setupCellBlock];
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock
{
    self.dataSource         = dataSource;
    self.cellIdentifier     = cellIdentifier;
    self.setupTableViewCell = setupCellBlock;
}

#pragma mark - 设置属性

@end

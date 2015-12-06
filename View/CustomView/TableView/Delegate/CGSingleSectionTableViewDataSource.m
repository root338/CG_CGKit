//
//  CGSingleSectionTableViewDataSource.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGSingleSectionTableViewDataSource.h"
#import "CGSingleSectionBaseTableViewCell.h"

@implementation CGSingleSectionTableViewDataSource

+ (instancetype)createSingleSectionTableViewDelegateWithData:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    return [self createSingleSectionTableViewDelegateWithData:dataSource cellIdentifierForString:NSStringFromClass(cellIdentifier) setupCellBlock:setupCellBlock];
}

+ (instancetype)createSingleSectionTableViewDelegateWithData:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    CGSingleSectionTableViewDataSource *delegate = [[CGSingleSectionTableViewDataSource alloc] initWithDataSource:dataSource cellIdentifier:cellIdentifier setupCellBlock:setupCellBlock];
    return delegate;
}

- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    self = [super init];
    if (self) {
        
        [self setupDataSource:dataSource cellIdentifier:cellIdentifier setupCellBlock:setupCellBlock];
    }
    return self;
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    [self setupDataSource:dataSource cellIdentifier:NSStringFromClass(cellIdentifier) setupCellBlock:setupCellBlock];
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)cellIdentifier setupCellBlock:(SetupSingleSectionTableViewCell)setupCellBlock
{
    self.dataSource = dataSource;
    self.cellIdentifier = cellIdentifier;
    self.setupSingleSectionTableViewCellBlock = setupCellBlock;
}

#pragma mark - UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionNumber = 1;
    
    
    
    return sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNumber = self.dataSource.count;
    
    if (rowNumber) {
        
    }
    
    return rowNumber;
}

- (CGSingleSectionBaseTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSingleSectionBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (self.setupSingleSectionTableViewCellBlock) {
        self.setupSingleSectionTableViewCellBlock(cell, self.dataSource[indexPath.row]);
    }
    
    
    if (self.isAutoLayoutCalculateCell) {
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isEditForDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editTableViewCallback) {
        self.editTableViewCallback(tableView, editingStyle, indexPath);
    }
}
@end

//
//  CGSingleSectionTableViewDataSource.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGSingleSectionTableViewDataSource.h"

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
        
        self.dataSource = dataSource;
        self.cellIdentifier = cellIdentifier;
        self.setupSingleSectionTableViewCellBlock = setupCellBlock;
    }
    return self;
}

#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGSingleSectionBaseTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSingleSectionBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (self.setupSingleSectionTableViewCellBlock) {
        self.setupSingleSectionTableViewCellBlock(cell, self.dataSource[indexPath.row]);
    }
    
    return cell;
}
@end

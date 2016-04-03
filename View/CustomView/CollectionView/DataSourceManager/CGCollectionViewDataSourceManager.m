//
//  CGCollectionViewDataSourceManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCollectionViewDataSourceManager.h"

#import "NSArray+CGArray.h"

@implementation CGCollectionViewDataSourceManager

- (void)initialization
{
    _sectionNumber              = 1;
    _rowNumberForAllSections    = 0;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    CGErrorConditionLog(!self.sectionNumber, @"%@的组数为0", collectionView);
    return self.sectionNumber;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfRowsAtCollectionViewSection) {
        self.rowNumberForAllSections = self.numberOfRowsAtCollectionViewSection(collectionView, section);
    }else if (self.dataSource) {
        self.rowNumberForAllSections = self.dataSource.count;
    }
    return self.rowNumberForAllSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    if (self.reusableCellClassIdentifier) {
        
        Class value     = self.reusableCellClassIdentifier(collectionView, indexPath);
        cellIdentifier  = NSStringFromClass(value);
    }else if (self.reusableCellStringIdentifier) {
        
        cellIdentifier  = self.reusableCellStringIdentifier(collectionView, indexPath);
    }else if (self.cellIdentifier) {
        
        cellIdentifier = self.cellIdentifier;
    }
    
    CGDebugAssert(cellIdentifier, @"cell 的标识不能为空");
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    CGDebugAssert(cell, @"没有注册 cell");
    
    id data = nil;
    if (self.dataSourceAtIndexPath) {
        data = self.dataSourceAtIndexPath(collectionView, indexPath);
    }else if (self.dataSource) {
        data = [self.dataSource cg_objectAtIndex:indexPath.row];
    }
    
    if (self.setupCollectionViewCell) {
        self.setupCollectionViewCell(collectionView, (id)cell, indexPath, data);
    }
    
    return cell;
}

#pragma mark - 初始化设置
- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock
{
    self = [super init];
    if (self) {
        [self setupDataSource:dataSource cellIdentifierForString:cellIdentifier setupCellBlock:setupCellBlock];
    }
    return self;
}

- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(CGSetupCollectionViewCell)setupCellBlock
{
    return [self initWithDataSource:dataSource cellIdentifierForString:NSStringFromClass(cellIdentifier) setupCellBlock:setupCellBlock];
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifierForClass:(nullable Class)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock
{
    [self setupDataSource:dataSource cellIdentifierForString:NSStringFromClass(cellIdentifier) setupCellBlock:setupCellBlock];
}

- (void)setupDataSource:(NSArray *)dataSource cellIdentifierForString:(NSString *)cellIdentifier setupCellBlock:(nullable CGSetupCollectionViewCell)setupCellBlock
{
    self.dataSource                 = dataSource;
    self.cellIdentifier             = cellIdentifier;
    self.setupCollectionViewCell    = setupCellBlock;
}

#pragma mark - 设置属性

@end

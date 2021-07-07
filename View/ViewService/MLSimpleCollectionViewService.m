//
//  MLSimpleCollectionViewService.m
//  QuickAskCommunity
//
//  Created by apple on 2021/6/30.
//  Copyright © 2021 ym. All rights reserved.
//

#import "MLSimpleCollectionViewService.h"

@interface MLSimpleCollectionViewService ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MLSimpleCollectionViewService

- (void)registerCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
}
- (void)registerCell:(Class)cellClass {
    _cellIdentifier = NSStringFromClass(cellClass);
    [_collectionView registerClass:cellClass forCellWithReuseIdentifier:_cellIdentifier];
}

- (void)resetData:(NSArray *)data {
    [_dataList removeAllObjects];
}
- (void)addData:(NSArray *)data {
    data.count == 0 ?: [self.dataList addObjectsFromArray:data];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    id data = _dataList.count > indexPath.row ? _dataList[indexPath.row] : nil;
    !_configureCell?: _configureCell(cell, data, indexPath);
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id data = _dataList.count > indexPath.row ? _dataList[indexPath.row] : nil;
    !_didClickCallback?: _didClickCallback(data, indexPath);
}

#pragma mark - Getter & Setter

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end

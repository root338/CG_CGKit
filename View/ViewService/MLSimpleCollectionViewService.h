//
//  MLSimpleCollectionViewService.h
//  QuickAskCommunity
//
//  Created by apple on 2021/6/30.
//  Copyright © 2021 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLSimpleCollectionViewService<DataType, CellType: UICollectionViewCell *> : NSObject

@property (nullable, nonatomic, weak) UICollectionView *collectionView;

@property (nullable, nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) NSMutableArray<DataType> *dataList;

@property (nullable, nonatomic, copy) void (^configureCell) (CellType cell, DataType data, NSIndexPath *indexPath);
@property (nullable, nonatomic, copy) void (^didClickCallback) (DataType data, NSIndexPath *indexPath);

- (void)registerCollectionView:(UICollectionView *)collectionView;
- (void)registerCell:(Class)cellClass;

- (void)resetData:(nullable NSArray *)data;
- (void)addData:(nullable NSArray *)data;
@end

NS_ASSUME_NONNULL_END

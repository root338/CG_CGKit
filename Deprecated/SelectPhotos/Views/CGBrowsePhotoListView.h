//
//  CGBrowsePhotoListView.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

@class CGCollectionViewDataSourceManager;
NS_ASSUME_NONNULL_BEGIN
@interface CGBrowsePhotoListView : CGBaseView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) CGCollectionViewDataSourceManager *dataSourceManager;

//@property (nonatomic, strong) NSMutableArray *photoDataSource;

/** 初始化视图 默认注册CGPhotoCollectionViewCell */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout photoList:(nullable NSArray *)photoList;

/** 初始化器，设置需要注册的cell 类 */
- (instancetype)initWithFrame:(CGRect)frame registerCellClass:(Class)registerCellClass collectionViewLayout:(UICollectionViewLayout *)layout photoList:(NSArray *)photoList;

- (void)cg_setupPhotoList:(NSArray *)photoList;
@end
NS_ASSUME_NONNULL_END
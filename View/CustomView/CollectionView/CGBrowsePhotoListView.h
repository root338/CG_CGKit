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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout photoList:(nullable NSArray *)photoList;

- (void)cg_setupPhotoList:(NSArray *)photoList;
@end
NS_ASSUME_NONNULL_END
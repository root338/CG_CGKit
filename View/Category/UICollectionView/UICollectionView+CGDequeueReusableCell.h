//
//  UICollectionView+CGDequeueReusableCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (CGDequeueReusableCell)

- (nullable __kindof UICollectionViewCell *)cg_dequeueReusableCellWithReuseClass:(nullable Class)identifier forIndexPath:(nullable NSIndexPath *)indexPath;

- (nullable __kindof UICollectionReusableView *)cg_dequeueReusableSupplementaryViewOfKind:(nullable NSString *)elementKind withReuseClass:(nullable Class)identifierClass forIndexPath:(nullable NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
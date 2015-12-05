//
//  UICollectionView+CGDequeueReusableCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UICollectionView+CGDequeueReusableCell.h"

@implementation UICollectionView (CGDequeueReusableCell)

- (UICollectionViewCell *)cg_dequeueReusableCellWithReuseClass:(Class)identifier forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(identifier) forIndexPath:indexPath];
}

- (UICollectionReusableView *)cg_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)identifierClass forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(identifierClass) forIndexPath:indexPath];
}

@end

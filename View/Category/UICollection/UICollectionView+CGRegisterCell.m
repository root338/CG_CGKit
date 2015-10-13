//
//  UICollectionView+CGRegisterCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UICollectionView+CGRegisterCell.h"

@implementation UICollectionView (CGRegisterCell)

- (void)cg_registerReuseClass:(id)cellClass
{
    [self cg_registerClass:cellClass forCellWithReuseClass:cellClass];
}

- (void)cg_registerClass:(Class)cellClass forCellWithReuseClass:(Class)identifierClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(identifierClass)];
}

- (void)cg_registerReuseClass:(Class)cellClass forSupplementaryViewOfKind:(NSString *)elementKind
{
    [self cg_registerClass:cellClass forSupplementaryViewOfKind:elementKind withReuseClass:cellClass];
}

- (void)cg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(nullable Class)identifierClass
{
    [self registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(identifierClass)];
}
@end

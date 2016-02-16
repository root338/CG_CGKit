//
//  UICollectionView+CGRegisterCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UICollectionView+CGRegisterCell.h"

@implementation UICollectionView (CGRegisterCell)

- (void)cg_registerReuseClass:(Class)cellClass
{
    [self cg_registerClass:cellClass forCellWithReuseClass:cellClass];
}

- (void)cg_registerReuseClasses:(NSArray <Class> *)cellClasses
{
    [cellClasses enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cg_registerReuseClass:obj];
    }];
}

- (void)cg_registerClass:(Class)cellClass forCellWithReuseClass:(Class)identifierClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(identifierClass)];
}

#pragma mark - 注册页眉页脚
- (void)cg_registerReuseSectionHeaderClass:(Class)headerClass
{
    [self cg_registerReuseClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader];
}

- (void)cg_registerReuseSectionHeaderClasses:(NSArray<Class> *)headerClasses
{
    [self cg_registerReuseClasses:headerClasses forSupplementaryViewOfKind:UICollectionElementKindSectionHeader];
}

- (void)cg_registerReuseSectionFooterClass:(Class)footerClass
{
    [self cg_registerReuseClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter];
}

- (void)cg_registerReuseSectionFooterClasses:(NSArray<Class> *)footerClasses
{
    [self cg_registerReuseClasses:footerClasses forSupplementaryViewOfKind:UICollectionElementKindSectionFooter];
}

- (void)cg_registerReuseClass:(Class)cellClass forSupplementaryViewOfKind:(NSString *)elementKind
{
    [self cg_registerClass:cellClass forSupplementaryViewOfKind:elementKind withReuseClass:cellClass];
}

- (void)cg_registerReuseClasses:(NSArray<Class> *)paramClasses forSupplementaryViewOfKind:(NSString *)elementKind
{
    [paramClasses enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cg_registerReuseClass:obj forSupplementaryViewOfKind:elementKind];
    }];
}

- (void)cg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)identifierClass
{
    
    [self registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(identifierClass)];
}
@end

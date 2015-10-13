//
//  UICollectionView+CGRegisterCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (CGRegisterCell)

- (void)cg_registerReuseClass:(nullable)cellClass;

- (void)cg_registerClass:(nullable Class)cellClass forCellWithReuseClass:(nullable Class)identifierClass;

- (void)cg_registerReuseClass:(nullable Class)cellClass forSupplementaryViewOfKind:(nullable NSString *)elementKind;

- (void)cg_registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(nullable NSString *)elementKind withReuseClass:(nullable Class)identifierClass;
@end

//
//  UICollectionView+CGRegisterCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (CGRegisterCell)

#pragma mark - cell注册
/** 注册cell，唯一标识=类名 */
- (void)cg_registerReuseClass:(Class)cellClass;

/** 批量注册cell，唯一标识=类名 */
- (void)cg_registerReuseClasses:(NSArray <Class> *)cellClasses;

- (void)cg_registerClass:(Class)cellClass forCellWithReuseClass:(Class)identifierClass;

#pragma mark - 页眉页脚注册
/** 注册页眉 */
- (void)cg_registerReuseSectionHeaderClass:(Class)headerClass;
/** 注册页脚 */
- (void)cg_registerReuseSectionFooterClass:(Class)footerClass;
/** 注册页眉 */
- (void)cg_registerReuseSectionHeaderClasses:(NSArray<Class> *)headerClasses;
/** 注册页脚 */
- (void)cg_registerReuseSectionFooterClasses:(NSArray<Class> *)footerClasses;

/** 注册页眉或页脚，唯一标识=类名 */
- (void)cg_registerReuseClass:(Class)cellClass forSupplementaryViewOfKind:(NSString *)elementKind;
/** 批量注册页眉或页脚，唯一标识==类名 */
- (void)cg_registerReuseClasses:(NSArray<Class> *)paramClasses forSupplementaryViewOfKind:(NSString *)elementKind;

- (void)cg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)identifierClass;
@end
NS_ASSUME_NONNULL_END
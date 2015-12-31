//
//  UITableView+CGRegisterCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+CGRegisterCell.h"

@implementation UITableView (CGRegisterCell)

- (void)cg_registerClassWithClassIdentifier:(Class)cellClassIdentifier
{
    [self cg_registerClass:cellClassIdentifier forCellReuseClass:cellClassIdentifier];
}

- (void)cg_registerClassWithClassIdentifiers:(NSArray<Class> *)cellClassIdentifiers
{
    [cellClassIdentifiers enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cg_registerClassWithClassIdentifier:obj];
    }];
}

- (void)cg_registerNibWithClassIdentifier:(Class)cellClassIdentifier
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClassIdentifier) bundle:[NSBundle bundleForClass:cellClassIdentifier]];
    if (nib) {
        [self cg_registerNib:nib forCellReuseClass:cellClassIdentifier];
    }
}

- (void)cg_registerNibWithClassIdentifiers:(NSArray<Class> *)cellClassIdentifiers
{
    [cellClassIdentifiers enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cg_registerNibWithClassIdentifier:obj];
    }];
}

- (void)cg_registerHeaderFooterViewClassWithClassIdentifier:(Class)headerFooterClassIdentifier
{
    [self cg_registerClass:headerFooterClassIdentifier forHeaderFooterViewReuseClass:headerFooterClassIdentifier];
}

- (void)cg_registerHeaderFooterViewClassWithClassIdentifiers:(NSArray<Class> *)headerFooterClassIdentifiers
{
    [headerFooterClassIdentifiers enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cg_registerHeaderFooterViewClassWithClassIdentifier:obj];
    }];
}

- (void)cg_registerNib:(nullable UINib *)nib forCellReuseClass:(nullable Class)identifier
{
    [self registerNib:nib forCellReuseIdentifier:NSStringFromClass(identifier)];
}

- (void)cg_registerClass:(nullable Class)cellClass forCellReuseClass:(nullable Class)identifier
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(identifier)];
}

- (void)cg_registerNib:(nullable UINib *)nib forHeaderFooterViewReuseClass:(nullable Class)identifier
{
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass(identifier)];
}

- (void)cg_registerClass:(nullable Class)aClass forHeaderFooterViewReuseClass:(nullable Class)identifier
{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(identifier)];
}

@end

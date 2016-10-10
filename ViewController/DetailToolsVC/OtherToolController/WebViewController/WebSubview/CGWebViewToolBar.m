//
//  CGWebBottomView.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebViewToolBar.h"

#import "UIBarButtonItem+CGCreate.h"
#import "UIView+CGAddSubview.h"

@interface CGWebViewToolBar ()
{
    NSMutableArray<NSNumber *> *itemsKey;
    NSMutableDictionary<NSNumber *, UIBarButtonItem *> *_itemsDict;
}

@end

@implementation CGWebViewToolBar

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame itemsType:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame itemsType:(nullable NSArray<NSNumber *> *)itemsType
{
    self = [super initWithFrame:frame];
    if (self) {
        if (itemsType) {
            itemsKey    = [NSMutableArray arrayWithArray:itemsType];
        }else {
            itemsKey    = [NSMutableArray array];
        }
        
        [self setupContentView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupContentView];
}

- (void)setupContentView
{
    NSArray<NSNumber *> *allKeys    = [self allKeys];
    NSMutableSet<NSNumber *> *allItemsSet  = [NSMutableSet setWithArray:allKeys];
    NSSet<NSNumber *> *itemsSet     = [NSSet setWithArray:itemsKey];
    
    [allItemsSet minusSet:itemsSet];
    
//    [allItemsSet enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
//        [self removeItemWithType:obj.integerValue key:obj];
//    }];
//    [itemsSet enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
//        [self addItemWithType:obj.integerValue key:obj];
//    }];
    
    [_itemsDict removeObjectsForKeys:[allItemsSet allObjects]];
    
    [itemsKey enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addItemWithType:obj.integerValue key:obj];
    }];
}

- (void)addItemWithType:(CGWebViewItemType)itemType key:(NSNumber *)key
{
    if (![_itemsDict.allKeys containsObject:key]) {
        
//        UIBarButtonItem *item   = [UIBarButtonItem cg_createItemWithImage:<#(nonnull UIImage *)#> target:<#(nonnull id)#> action:<#(nonnull SEL)#>]
    }
}

- (NSArray<NSNumber *> *)allKeys
{
    return @[
             @(CGWebViewItemTypeBack),
             @(CGWebViewItemTypeForward),
             @(CGWebViewItemTypeReload),
             @(CGWebViewItemTypeStopLoading),
             ];
}

@end

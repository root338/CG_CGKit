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

#import "CGWebViewToolBarItemManager.h"

@interface CGWebViewToolBar ()
{
    NSMutableArray<NSNumber *> *itemsKey;
    NSMutableDictionary<NSNumber *, UIBarButtonItem *> *_itemsDict;
    
    CGWebViewToolBarItemManager *itemImageManager;
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

- (instancetype)initWithItemsType:(NSArray<NSNumber *> *)itemsType
{
    return [self initWithFrame:CGRectZero itemsType:itemsType];
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
    
    NSMutableArray<UIBarButtonItem *> *items   = [NSMutableArray arrayWithCapacity:_itemsType.count];
    [itemsKey enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *item   = [self addItemWithType:obj.integerValue key:obj];
        item == nil ?: [items addObject:item];
    }];
    
    [self setItems:items animated:YES];
}

- (UIBarButtonItem *)addItemWithType:(CGWebViewItemType)itemType key:(NSNumber *)key
{
    UIBarButtonItem *item   = [_itemsDict objectForKey:key];
    if (item != nil) {
        return item;
    }
    
    SEL action              = @selector(handleItemClickEvent:);

    if (itemType == CGWebViewItemTypeReload) {
        item    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:action];
    }else {
        
        if (itemImageManager == nil) {
            itemImageManager    = [CGWebViewToolBarItemManager new];
        }
        
        UIImage *itemImage  = [itemImageManager getImageWithItemType:itemType];
        if (itemImage) {
            item    = [UIBarButtonItem cg_createItemWithImage:itemImage target:self action:action];
        }
    }
    if (item) {
        [_itemsDict setObject:item forKey:key];
    }
    
    return item;
}

- (void)handleItemClickEvent:(UIBarButtonItem *)item
{
    
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

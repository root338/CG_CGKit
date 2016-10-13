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
    __weak UIBarButtonItem *backItem;
    __weak UIBarButtonItem *forwardItem;
    __weak UIBarButtonItem *reloadItem;
    __weak UIBarButtonItem *stopLoadingItem;
    CGWebViewToolBarItemManager *itemImageManager;
}

@property (nullable, nonatomic, strong, readwrite) NSArray<NSNumber *> *itemsType;

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
        
        _itemsType      = itemsType;
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
    
    NSMutableArray<UIBarButtonItem *> *items   = [NSMutableArray arrayWithCapacity:_itemsType.count];
    [_itemsType enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *item   = [self addItemWithType:obj.integerValue];
        item == nil ?: [items addObject:item];
    }];
    
    [self setItems:items animated:YES];
}

- (UIBarButtonItem *)addItemWithType:(CGWebViewItemType)itemType
{
    UIBarButtonItem *item   = nil;
    SEL action              = @selector(handleItemClickEvent:);

    if (itemType == CGWebViewItemTypeFlexibleSpace) {
        item    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:action];
    }
    else {
        
        if (itemImageManager == nil) {
            itemImageManager    = [CGWebViewToolBarItemManager new];
        }
        
        UIImage *itemImage  = [itemImageManager getImageWithItemType:itemType];
        if (itemImage) {
            item    = [UIBarButtonItem cg_createItemWithImage:itemImage target:self action:action];
        }
    }
    
    switch (itemType) {
        case CGWebViewItemTypeStopLoading:
            stopLoadingItem = item;
            break;
        case CGWebViewItemTypeBack:
            backItem    = item;
            break;
        case CGWebViewItemTypeReload:
            reloadItem  = item;
            break;
        case CGWebViewItemTypeForward:
            forwardItem = item;
            break;
        default:
            break;
    }
    
    return item;
}

- (void)handleItemClickEvent:(UIBarButtonItem *)item
{
    
    if ([self.toolBarProxyDelegate respondsToSelector:@selector(webViewToolBar:itemType:)]) {
        
        CGWebViewItemType itemType = 0;
        if (item == stopLoadingItem) {
            
            itemType    = CGWebViewItemTypeStopLoading;
        }else if (item == backItem) {
            
            itemType    = CGWebViewItemTypeBack;
        }else if (item == reloadItem) {
            
            itemType    = CGWebViewItemTypeReload;
        }else if (item == forwardItem) {
            
            itemType    = CGWebViewItemTypeForward;
        }
        [self.toolBarProxyDelegate webViewToolBar:self itemType:itemType];
    }
}

- (void)setupStopLoadingToTargetTypeWithType:(CGWebViewItemType)type
{
    
}

- (void)setupTargetTypeToStopLoadingWithType:(CGWebViewItemType)type
{
    
}

@end

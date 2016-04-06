//
//  CGTitleBarViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleBarViewController.h"

@interface CGTitleBarViewController ()<UINavigationBarDelegate>
{
    BOOL _titleDidAddToNavigationBar;
}

@end

@implementation CGTitleBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.delegate = self;
    [self setupNavigationItemContent];
}

- (void)setupNavigationItemContent
{
    if (!_titleDidAddToNavigationBar) {
        
        NSArray<UIBarButtonItem *> *leftItems   = [self setupLeftItemButtons];
        NSArray<UIBarButtonItem *> *rightItems  = [self setupRightItemButtons];
        
        if (leftItems || rightItems || self.title) {
            
            UINavigationItem *navigationItem    = [[UINavigationItem alloc] initWithTitle:self.title];
            
            UINavigationItem *backNavigationItem    = [[UINavigationItem alloc] initWithTitle:@"Back"];
            
            !leftItems  ?:  [navigationItem setLeftBarButtonItems:leftItems];
            !rightItems ?:  [navigationItem setRightBarButtonItems:rightItems];
            
//            [self.navigationBar pushNavigationItem:navigationItem animated:YES];
            [self.navigationBar pushNavigationItem:backNavigationItem animated:NO];
            [self.navigationBar pushNavigationItem:navigationItem animated:NO];
            
        }
        
        _titleDidAddToNavigationBar = YES;
    }
}

#pragma mark - 标题按钮设置
- (NSArray<UIBarButtonItem *> *)setupLeftItemButtons
{
    UIBarButtonItem *leftItem   = nil;
    
    id target                   = self;
    SEL action                  = @selector(handleLeftItemAction:);
    UIBarButtonItemStyle style  = UIBarButtonItemStylePlain;
    if (self.leftItemTitle) {
        leftItem    = [[UIBarButtonItem alloc] initWithTitle:self.leftItemTitle
                                                       style:style
                                                      target:target
                                                      action:action];
        [self.leftItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
            [leftItem setTitleTextAttributes:obj forState:[key integerValue]];
        }];
    }else if (self.leftItemImage) {
        leftItem    = [[UIBarButtonItem alloc] initWithImage:self.leftItemImage
                                         landscapeImagePhone:nil
                                                       style:style
                                                      target:target
                                                      action:action];
    }
    return leftItem ? @[leftItem] : nil;
}

- (NSArray<UIBarButtonItem *> *)setupRightItemButtons
{
    UIBarButtonItem *rightItem  = nil;
    
    id target                   = self;
    SEL action                  = @selector(handleRightItemAction:);
    UIBarButtonItemStyle style  = UIBarButtonItemStylePlain;
    if (self.rightItemTitle) {
        rightItem   = [[UIBarButtonItem alloc] initWithTitle:self.rightItemTitle
                                                       style:style
                                                      target:target
                                                      action:action];
        [self.rightItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
            [rightItem setTitleTextAttributes:obj forState:[key integerValue]];
        }];
    }else if (self.rightItemImage) {
        rightItem   = [[UIBarButtonItem alloc] initWithImage:self.rightItemImage
                                         landscapeImagePhone:nil
                                                       style:style
                                                      target:target
                                                      action:action];
    }
    return rightItem ? @[rightItem] : nil;
}

- (void)cg_setTitleTextAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state type:(CGTitleBarItemType)type
{
    if (!attributes) {
        return;
    }
    
    if (CGTitleBarItemTypeLeft == type) {
        if (self.leftItemTitleAttributesDict == nil) {
            self.leftItemTitleAttributesDict    = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [self.leftItemTitleAttributesDict setObject:attributes forKey:@(state)];
    }else if (CGTitleBarItemTypeRight == type) {
        if (self.rightItemTitleAttributesDict == nil) {
            self.rightItemTitleAttributesDict   = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [self.rightItemTitleAttributesDict setObject:attributes forKey:@(state)];
    }
}

#pragma mark - 设置属性

@end
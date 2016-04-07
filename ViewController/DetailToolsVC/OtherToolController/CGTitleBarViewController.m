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
    UINavigationItem *_titleItem;
}

@end

@implementation CGTitleBarViewController

#pragma mark - 事件
- (void)handleBackItemAction:(id)sender
{
    [self handleLeftItemAction:sender];
}

#pragma mark - UINavigationBarDelegate
//!REF:https://github.com/onegray/UIViewController-BackButtonHandler
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    [self handleBackItemAction:nil];
    return YES;
}

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
        UIBarButtonItem            *backItem    = [self setupBackItemButton];
        
        UINavigationItem *navigationItem    = [[UINavigationItem alloc] initWithTitle:self.title];
        
        !leftItems  ?:  [navigationItem setLeftBarButtonItems:leftItems];
        !rightItems ?:  [navigationItem setRightBarButtonItems:rightItems];
        
        if (self.backItemTitle) {
            
            UINavigationItem *backNavigationItem    = [[UINavigationItem alloc] init];
            backNavigationItem.backBarButtonItem    = backItem;
            [self.navigationBar pushNavigationItem:backNavigationItem animated:NO];
        }
        
        [self.navigationBar pushNavigationItem:navigationItem animated:NO];
        _titleItem  = navigationItem;
        
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

- (UIBarButtonItem *)setupBackItemButton
{
    UIBarButtonItem *backItem   = nil;
    id target                   = self;
    SEL action                  = @selector(handleBackItemAction:);
    //设置触发的方法不管用，现在在navigationBar:shouldPopItem:代理方法中POP当前视图
    if (self.backItemTitle) {
        backItem    = [[UIBarButtonItem alloc] initWithTitle:self.backItemTitle style:UIBarButtonItemStylePlain target:target action:action];
        [self.backItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary<NSString *,id> * _Nonnull obj, BOOL * _Nonnull stop) {
            [backItem setTitleTextAttributes:obj forState:key.integerValue];
        }];
    }
    return backItem;
}

- (BOOL)cg_setTitleTextAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state type:(CGTitleBarItemType)type
{
    BOOL isResult   = [super cg_setTitleTextAttributes:attributes forState:state type:type];
    if (!isResult) {
        return NO;
    }
    if (CGTitleBarItemTypeBack == type) {
        if (self.backItemTitleAttributesDict == nil) {
            self.backItemTitleAttributesDict    = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [self.backItemTitleAttributesDict setObject:attributes forKey:@(state)];
    }
    return YES;
}

#pragma mark - 设置属性
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _titleItem.title    = title;
}

@end

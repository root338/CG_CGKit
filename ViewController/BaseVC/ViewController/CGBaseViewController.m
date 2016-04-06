//
//  CGBaseViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseViewController.h"

#import "CGBaseViewController+CGSetupItem.h"

#import "CGPrintLogHeader.h"

@interface CGBaseViewController ()

@end

@implementation CGBaseViewController

#pragma mark - 事件触发
- (void)handleLeftItemAction:(id)sender
{
    
    if (self.navigationController) {
        
        UINavigationController *navigationController = self.navigationController;
        
        if (navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        if (navigationController.presentingViewController) {
            [navigationController dismissViewControllerAnimated:YES completion:self.dismissViewControllerCompletion];
            return;
        }
        
    }else if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:YES completion:self.dismissViewControllerCompletion];
    }
}

- (void)handleRightItemAction:(id)sender
{
    [self handleLeftItemAction:sender];
}

#pragma mark - 标题按钮的设置

- (BOOL)cg_shouldAddRightBarButtonItem
{
    return !self.navigationItem.rightBarButtonItem;
}

- (BOOL)cg_shouldAddLeftBarButtonItem
{
    return !self.navigationItem.leftBarButtonItem || !self.navigationItem.backBarButtonItem || self.navigationItem.hidesBackButton;
}

- (UIBarButtonItem *)cg_addLeftBarButtonItem
{
    if (![self cg_shouldAddLeftBarButtonItem]) {
        return nil;
    }
    
    UIBarButtonItem *leftItem   = [self cg_createBarButtonItemWithTitle:self.leftItemTitle image:self.leftItemImage landscapeImage:self.leftLandscapeImage];
    [self.leftItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        [leftItem setTitleTextAttributes:obj forState:key.integerValue];
    }];
    
    return leftItem;
}

- (UIBarButtonItem *)cg_addRightBarButtonItem
{
    if (![self cg_shouldAddRightBarButtonItem]) {
        return nil;
    }
    
    UIBarButtonItem *rightItem   = [self cg_createBarButtonItemWithTitle:self.rightItemTitle image:self.rightItemImage landscapeImage:self.rightLandscapeImage];
    [self.rightItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        [rightItem setTitleTextAttributes:obj forState:key.integerValue];
    }];
    return rightItem;
}

- (UIBarButtonItem *)cg_createBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image landscapeImage:(UIImage *)landscapeImage
{
    UIBarButtonItem *item   = nil;
    if (image) {
        item    = [self cg_createItemWithImage:image landscapeImage:landscapeImage];
    }else if (title.length) {
        item    = [self cg_createItemWithTitle:title];
    }
    
    return item;
}

/** 设置item标题的属性 */
- (BOOL)cg_setTitleTextAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state type:(CGTitleBarItemType)type
{
    if (!attributes) {
        return NO;
    }
    
    NSNumber *key   = @(state);
    if (CGTitleBarItemTypeLeft == type) {
        if (self.leftItemTitleAttributesDict == nil) {
            self.leftItemTitleAttributesDict    = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [self.leftItemTitleAttributesDict setObject:attributes forKey:key];
    }else if (CGTitleBarItemTypeRight == type) {
        if (self.rightItemTitleAttributesDict == nil) {
            self.rightItemTitleAttributesDict   = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [self.rightItemTitleAttributesDict setObject:attributes forKey:key];
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGPrintClassNameLog()
    
    if (!self.navigationController.navigationBarHidden) {
        
        UINavigationItem *navigationItem    = self.navigationItem;
        navigationItem.rightBarButtonItem   = [self cg_addRightBarButtonItem];
        navigationItem.leftBarButtonItem    = [self cg_addLeftBarButtonItem];
    }
    
    if (!self.view.backgroundColor) {
        self.view.backgroundColor   = [UIColor whiteColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    CGPrintClassNameLog()
}

@end

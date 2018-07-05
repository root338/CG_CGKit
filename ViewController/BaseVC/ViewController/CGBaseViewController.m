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
        }else if (navigationController.presentingViewController) {
            
            [navigationController dismissViewControllerAnimated:YES completion:self.dismissViewControllerCompletion];
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
    
    UIBarButtonItem *leftItem   = [self cg_createBarButtonItemWithTitle:self.leftItemTitle image:self.leftItemImage landscapeImage:self.leftLandscapeImage];
    [self.leftItemTitleAttributesDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        [leftItem setTitleTextAttributes:obj forState:key.integerValue];
    }];
    
    return leftItem;
}

- (UIBarButtonItem *)cg_addRightBarButtonItem
{
    
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
        if (![self cg_shouldAddLeftBarButtonItem]) {
            navigationItem.rightBarButtonItem   = [self cg_addRightBarButtonItem];
        }
        if (![self cg_shouldAddRightBarButtonItem]) {
            navigationItem.leftBarButtonItem    = [self cg_addLeftBarButtonItem];
        }
    }
    
    BOOL disableResetBackTitleIsNull = [self shouldDisableResetBackTitleIsNull];
    if (disableResetBackTitleIsNull == NO) {
        
        self.navigationItem.backBarButtonItem    = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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

- (void)updateLeftBarButtonItem {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (!self.isViewLoaded) {
        return;
    }
    
    self.navigationItem.leftBarButtonItem = [self cg_addLeftBarButtonItem];
}

- (void)updateRightBarButtonItem {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (!self.isViewLoaded) {
        return;
    }
    
    self.navigationItem.rightBarButtonItem  = [self cg_addRightBarButtonItem];
}

#pragma mark - CGBaseViewControllerDelegate
- (BOOL)shouldDisableResetBackTitleIsNull
{
    return NO;
}

#if DEBUG
- (void)dealloc
{
    CGPrintClassNameLog()
}
#endif

#pragma mark - 设置属性
- (void)setLeftItemTitle:(NSString *)leftItemTitle
{
    if (![_leftItemTitle isEqualToString:leftItemTitle]) {
        
        _leftItemTitle  = leftItemTitle;
        [self performSelector:@selector(updateLeftBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setLeftItemImage:(UIImage *)leftItemImage
{
    if (![_leftItemImage isEqual: leftItemImage]) {
        _leftItemImage  = leftItemImage;
        [self performSelector:@selector(updateLeftBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setLeftLandscapeImage:(UIImage *)leftLandscapeImage
{
    if (![_leftLandscapeImage isEqual: leftLandscapeImage]) {
        _leftLandscapeImage = leftLandscapeImage;
        [self performSelector:@selector(updateLeftBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setLeftItemTitleAttributesDict:(NSMutableDictionary<NSNumber *,NSDictionary<NSString *,id> *> *)leftItemTitleAttributesDict
{
    if (![_leftItemTitleAttributesDict isEqualToDictionary:leftItemTitleAttributesDict]) {
        _leftItemTitleAttributesDict    = leftItemTitleAttributesDict;
        [self performSelector:@selector(updateLeftBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setRightItemTitle:(NSString *)rightItemTitle
{
    if (![_rightItemTitle isEqualToString:rightItemTitle]) {
        _rightItemTitle = rightItemTitle;
        [self performSelector:@selector(updateRightBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setRightItemImage:(UIImage *)rightItemImage
{
    if (![_rightItemImage isEqual:rightItemImage]) {
        _rightItemImage = rightItemImage;
        [self performSelector:@selector(updateRightBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setRightLandscapeImage:(UIImage *)rightLandscapeImage
{
    if (![_rightLandscapeImage isEqual:rightLandscapeImage]) {
        _rightLandscapeImage    = rightLandscapeImage;
        [self performSelector:@selector(updateRightBarButtonItem) withObject:nil afterDelay:0];
    }
}

- (void)setRightItemTitleAttributesDict:(NSMutableDictionary<NSNumber *,NSDictionary<NSString *,id> *> *)rightItemTitleAttributesDict
{
    if (![_rightItemTitleAttributesDict isEqualToDictionary:rightItemTitleAttributesDict]) {
        _rightItemTitleAttributesDict   = rightItemTitleAttributesDict;
        [self performSelector:@selector(updateRightBarButtonItem) withObject:nil afterDelay:0];
    }
}

@end

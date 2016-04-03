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
        }
        
        if (navigationController.presentingViewController) {
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
    if (![self cg_shouldAddLeftBarButtonItem]) {
        return nil;
    }
    
    return [self cg_createBarButtonItemWithTitle:self.leftItemTitle image:self.leftItemImage landscapeImage:self.leftLandscapeImage];
}

- (UIBarButtonItem *)cg_addRightBarButtonItem
{
    if (![self cg_shouldAddRightBarButtonItem]) {
        return nil;
    }
    
    return [self cg_createBarButtonItemWithTitle:self.rightItemTitle image:self.rightItemImage landscapeImage:self.rightLandscapeImage];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    CGPrintClassNameLog()
    
    if (!self.navigationController.navigationBarHidden) {
        
        UINavigationItem *navigationItem    = self.navigationItem;
        navigationItem.rightBarButtonItem   = [self cg_addRightBarButtonItem];
        navigationItem.leftBarButtonItem    = [self cg_addLeftBarButtonItem];
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
//    CGPrintClassNameLog()
}

@end

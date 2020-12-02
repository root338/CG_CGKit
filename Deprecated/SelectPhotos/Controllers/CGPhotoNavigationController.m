//
//  CGPhotoNavigationController.m
//  TestCG_CGKit
//
//  Created by DY on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoNavigationController.h"

#import "CGPhotoListViewController.h"
#import "CGPhotoGroupViewController.h"

#import "CGAssetsLibraryManager.h"

@implementation CGPhotoNavigationController

+ (instancetype)cg_createDefalutNavigationController
{
    NSString *cancelTitle                       = @"取消";
    CGPhotoGroupViewController *photoGroupVC    = [[CGPhotoGroupViewController alloc] init];
    photoGroupVC.title                          = @"相机";
    photoGroupVC.rightItemTitle                 = cancelTitle;
    
    CGPhotoNavigationController *photoNavigationController   = [[self alloc] initWithRootViewController:photoGroupVC];
    
    CGPhotoListViewController *photoListVC      = [CGPhotoListViewController cg_createPhotoList];
    
    [photoNavigationController.assetsLibraryManager cg_assetsGroupsWithGroupsType:ALAssetsGroupAll assetsGroups:^(NSArray<ALAssetsGroup *> * _Nullable paramAssetsGroup) {
        
        if (paramAssetsGroup.count) {
            photoGroupVC.assetsGroups   = paramAssetsGroup;
            photoListVC.assetsGroup     = paramAssetsGroup[0];
        }
        
    } failureBlock:nil];
    
    NSMutableArray *viewControllers             = [NSMutableArray arrayWithArray:photoNavigationController.viewControllers];
    [viewControllers addObject:photoListVC];
    
    [photoNavigationController setViewControllers:viewControllers animated:NO];
    
    return photoNavigationController;
}

#pragma mark - 设置属性

- (CGAssetsLibraryManager *)assetsLibraryManager
{
    if (_assetsLibraryManager) {
        return _assetsLibraryManager;
    }
    
    _assetsLibraryManager = [[CGAssetsLibraryManager alloc] init];;
    
    return _assetsLibraryManager;
}

@end

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
#import "CGImageLibraryManager.h"

@interface CGPhotoNavigationController ()

@property (nonatomic, strong, readwrite) CGImageLibraryManager *assetsLibraryManager;

@end

@implementation CGPhotoNavigationController

+ (instancetype)cg_createDefalutNavigationController
{
    NSString *cancelTitle                       = @"取消";
    CGPhotoGroupViewController *photoGroupVC    = [[CGPhotoGroupViewController alloc] init];
    photoGroupVC.title                          = @"相机";
    photoGroupVC.rightItemTitle                 = cancelTitle;
    
    CGPhotoNavigationController *photoNavigationController   = [[self alloc] initWithRootViewController:photoGroupVC];
    
    CGPhotoListViewController *photoListVC      = [CGPhotoListViewController cg_createPhotoList];
    
    [photoNavigationController.assetsLibraryManager.assetsCollectionManager cg_getAssetsCollectionCompletion:^(NSArray<CGAssetsCollectionModel *> * _Nullable assetsCollectionArray) {
        
        photoGroupVC.assetsCollection   = assetsCollectionArray;
        photoListVC.assetsCollection    = [assetsCollectionArray firstObject];
    } failureBlock:nil];
    
    NSMutableArray *viewControllers             = [NSMutableArray arrayWithArray:photoNavigationController.viewControllers];
    [viewControllers addObject:photoListVC];
    
    [photoNavigationController setViewControllers:viewControllers animated:NO];
    
    return photoNavigationController;
}

#pragma mark - 设置属性

- (CGImageLibraryManager *)assetsLibraryManager
{
    if (_assetsLibraryManager) {
        return _assetsLibraryManager;
    }
    
    _assetsLibraryManager = [[CGImageLibraryManager alloc] init];
    
    return _assetsLibraryManager;
}

@end

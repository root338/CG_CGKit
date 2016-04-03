//
//  CGPhotoListViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoListViewController.h"

#import "CGBrowsePhotoListView.h"

#import "UIView+CGAddConstraints.h"

#import "CGAssetsLibraryManager.h"
#import "CGAssetsFilterObject.h"

@interface CGPhotoListViewController ()

@property (nonatomic, strong) CGBrowsePhotoListView *brosePhotoListView;

@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation CGPhotoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPhotoListView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupPhotoListView
{
    
    CGFloat count                           = 4;
    CGFloat space                           = 5;
    CGFloat length                          = (self.view.width - space * (count - 1)) / (float)count;
    UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing      = space;
    flowLayout.minimumLineSpacing           = space;
    flowLayout.itemSize                     = CGSizeMake(length, length);
    
    self.brosePhotoListView = [[CGBrowsePhotoListView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout photoList:nil];
    [self.view addSubview:self.brosePhotoListView];
    [self.brosePhotoListView cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero];
    
    CGAssetsLibraryManager * assetsLibraryManager   = [CGAssetsLibraryManager sharedManager];
    assetsLibraryManager.assetsFilterType           = CGAssetsFilterTypeAllPhotos;
    assetsLibraryManager.assetsSequenceType         = CGAssetsSequenceTypeDescending;
    
    CGAssetsFilterObject *filterObject              = [[CGAssetsFilterObject alloc] init];
    filterObject.assetsFilterType                   = CGAssetsFilterTypeAllPhotos;
    filterObject.assetsGroupType                    = ALAssetsGroupAll;
    filterObject.assetsSequenceType                 = CGAssetsSequenceTypeDescending;
    
    [assetsLibraryManager cg_assetsListWithAssetsFilter:filterObject assetList:^(NSArray<ALAsset *> * _Nullable paramAssetList) {
        
        paramAssetList  = [paramAssetList arrayByAddingObjectsFromArray:paramAssetList];
        paramAssetList  = [paramAssetList arrayByAddingObjectsFromArray:paramAssetList];
        [self.brosePhotoListView cg_setupPhotoList:paramAssetList];
    } failureBlock:nil];
}

@end

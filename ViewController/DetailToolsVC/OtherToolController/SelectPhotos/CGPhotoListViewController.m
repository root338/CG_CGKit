//
//  CGPhotoListViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoListViewController.h"
#import "CGPhotoNavigationController.h"
#import "CGBrowsePhotoViewController.h"

#import "CGCollectionView.h"
#import "CGPhotoCollectionViewCell.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGAddConstraints.h"
#import "CGBaseViewController+CGSetupItem.h"
#import "UICollectionViewFlowLayout+CGCreateLayout.h"

#import "CGAssetsLibraryManager.h"
#import "ALAssetsGroup+CGProperty.h"
#import "CGCollectionViewDataSourceManager.h"

@interface CGPhotoListViewController ()<UICollectionViewDelegate>

@property (nonatomic, strong) CGCollectionView *collectionView;
@property (nonatomic, strong) CGCollectionViewDataSourceManager *dataSourceManager;

@property (readonly) CGAssetsLibraryManager *assetsLibraryManager;
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation CGPhotoListViewController

+ (instancetype)cg_createPhotoList
{
    CGPhotoListViewController *photoListVC  = [[CGPhotoListViewController alloc] init];
    photoListVC.rightItemTitle  = @"取消";
    return photoListVC;
}

#pragma mark - 处理方法
- (void)cg_setupPhotoList:(NSArray *)photoList
{
    self.dataSourceManager.dataSource   = photoList;
    [self.collectionView reloadData];
}

#pragma mark - 事件
- (void)handleBrowseSelectedImageAction:(id)sender
{
    
}

- (void)handleFinishedAction:(id)sender
{
    
}

- (void)handleRightItemAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGBrowsePhotoViewController *browsePhotoVC  = [[CGBrowsePhotoViewController alloc] init];
    browsePhotoVC.browsePhotoDataSource         = self.dataSourceManager.dataSource;
    browsePhotoVC.startIndex                    = indexPath.row;
    [self.navigationController pushViewController:browsePhotoVC animated:YES];
}

#pragma mark - 视图内容设置
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPhotoListView];
    [self setupToolView];
    [self setupLayout];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupPhotoListView
{
    
    UICollectionViewFlowLayout *flowLayout  = [UICollectionViewFlowLayout cg_createWithWidth:self.view.width count:4 space:5];
    
    NSArray *photoList  = [self.assetsLibraryManager cg_assetsWithGroup:self.assetsGroup];
    
    _collectionView = [[CGCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    Class registerCellClassName = [CGPhotoCollectionViewCell class];
    [_collectionView cg_registerReuseClass:registerCellClassName];
    _dataSourceManager          = [[CGCollectionViewDataSourceManager alloc] initWithDataSource:photoList cellIdentifierForClass:registerCellClassName setupCellBlock:^(UICollectionView * _Nonnull collectionView, __kindof CGCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        [cell setupCollectionViewCellContentWithData:data];
    }];
    
    _collectionView.dataSource  = _dataSourceManager;
    _collectionView.delegate    = self;
}

- (void)setupToolView
{
    self.toolbar    = [[UIToolbar alloc] init];
    UIBarButtonItem *browseItem = [self cg_createItemWithTitle:@"预览" target:self action:@selector(handleBrowseSelectedImageAction:)];
    UIBarButtonItem *middenItem     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *completionItem = [self cg_createItemWithTitle:@"确定" target:self action:@selector(handleFinishedAction:)];
    
    [self.toolbar setItems:@[browseItem, middenItem, completionItem]];
    [self.view addSubview:self.toolbar];
}

- (void)setupLayout
{
    [_collectionView cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero exculdingEdge:CGLayoutEdgeBottom];
    [self.toolbar cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero exculdingEdge:CGLayoutEdgeTop];
    [_collectionView cg_attribute:NSLayoutAttributeBottom toItem:self.toolbar attribute:NSLayoutAttributeTop];
//    [self.toolbar cg_autoDimension:CGDimensionHeight fixedLength:44];
}

#pragma mark - 设置属性

- (CGAssetsLibraryManager *)assetsLibraryManager
{
    if ([self.navigationController isKindOfClass:[CGPhotoNavigationController class]]) {
        CGPhotoNavigationController *photoNavigationController  = (id)self.navigationController;
        return photoNavigationController.assetsLibraryManager;
    }
    return nil;
}

- (void)setAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    _assetsGroup    = assetsGroup;
    self.title      = self.assetsGroup.assetsGroupName;
    
    if (self.collectionView) {
        [self cg_setupPhotoList:[self.assetsLibraryManager cg_assetsWithGroup:assetsGroup]];
    }
}

@end

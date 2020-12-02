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
#import "UIBarButtonItem+CGCreate.h"
#import "UICollectionViewFlowLayout+CGCreateLayout.h"

#import "CGAssetsLibraryManager.h"
#import "CGCollectionViewDataSourceManager.h"

#import "ALAssetsGroup+CGProperty.h"
#import "UIApplication+CGVerifyDeviceDirection.h"

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
    browsePhotoVC.backItemTitle                 = self.title;
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
    
    UICollectionViewFlowLayout *flowLayout  = [self createFlowLayoutWithWidth:self.view.width];
    
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
    UIBarButtonItem *browseItem = [UIBarButtonItem cg_createItemWithTitle:@"预览" target:self action:@selector(handleBrowseSelectedImageAction:)];
    UIBarButtonItem *middenItem     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *completionItem = [UIBarButtonItem cg_createItemWithTitle:@"确定" target:self action:@selector(handleFinishedAction:)];
    
    [self.toolbar setItems:@[browseItem, middenItem, completionItem]];
    [self.view addSubview:self.toolbar];
}

- (void)setupLayout
{
    [_collectionView cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero exculdingEdge:CGLayoutEdgeBottom];
    [self.toolbar cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero exculdingEdge:CGLayoutEdgeTop];
    [self.toolbar cg_autoDimension:CGDimensionHeight fixedLength:44];
    [_collectionView cg_attribute:NSLayoutAttributeBottom toItem:self.toolbar attribute:NSLayoutAttributeTop];
}

- (NSInteger)setupCollectionCount
{
    NSInteger count;
    if ([UIApplication cg_currentDeviceDirection] == CGDeivceDirectionPortrait) {
        count   = 4;
    }else {
        count   = 7;
    }
    return count;
}

- (__kindof UICollectionViewLayout *)createFlowLayoutWithWidth:(CGFloat)width
{
    
    NSInteger count = 4;//[self setupCollectionCount];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout cg_createWithWidth:width count:count space:5];
    
    return flowLayout;
}

#pragma mark - 视图旋转
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        [self.collectionView setCollectionViewLayout:[self createFlowLayoutWithWidth:size.width]];
//    }];
//}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self.collectionView setCollectionViewLayout:[self createFlowLayoutWithWidth:self.collectionView.width]];
//}

#endif

//- (void)updateCollectionViewLayoutWithItemSize:(CGSize)itemSize;
//{
//    UICollectionViewFlowLayout *flowLayout   = (id)self.collectionView.collectionViewLayout;
//    if ([flowLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
//        flowLayout.itemSize = itemSize;
//    }
//}

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

//
//  CGBrowsePhotoViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoViewController.h"

#import "CGCollectionView.h"
#import "CGBrowsePhotoCollectionViewCell.h"

#import "UIView+CGAddConstraints.h"

#import "CGCollectionViewDataSourceManager.h"
#import "CGBrowseImageCollectionViewFlowLayout.h"

@interface CGBrowsePhotoViewController ()

@property (nonatomic, strong) CGCollectionView *browsePhotoCollectionView;
@property (nonatomic, strong) CGCollectionViewDataSourceManager *dataSourceManager;
@end

@implementation CGBrowsePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cg_setupBrowsePhotoListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cg_setupBrowsePhotoListView
{
    
    CGBrowseImageCollectionViewFlowLayout *flowLayout = [[CGBrowseImageCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize                 = self.view.bounds.size;
    flowLayout.minimumInteritemSpacing  = 20;
    flowLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
    
    _browsePhotoCollectionView  = [[CGCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _browsePhotoCollectionView.backgroundColor  = [UIColor whiteColor];
    
    [self.view addSubview:_browsePhotoCollectionView];
    [_browsePhotoCollectionView cg_autoEdgesInsetsZeroToViewController:self];
    
    Class registerCollectionCellClassName   = [CGBrowsePhotoCollectionViewCell class];
    [_browsePhotoCollectionView cg_registerReuseClass:registerCollectionCellClassName];
    
    _dataSourceManager  = [[CGCollectionViewDataSourceManager alloc] initWithDataSource:self.browsePhotoDataSource cellIdentifierForClass:registerCollectionCellClassName setupCellBlock:^(UICollectionView * _Nonnull collectionView, __kindof CGCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        [cell setupCollectionViewCellContentWithData:data];
    }];
    
    _browsePhotoCollectionView.dataSource   = _dataSourceManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

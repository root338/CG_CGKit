//
//  CGBrowsePhotoListView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoListView.h"
#import "CGPhotoCollectionViewCell.h"

#import "UIView+CGAddConstraints.h"
#import "UICollectionView+CGRegisterCell.h"

#import "CGCollectionViewDataSourceManager.h"

@interface CGBrowsePhotoListView ()
<
    UICollectionViewDelegateFlowLayout
>
{
    
}
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) CGCollectionViewDataSourceManager *dataSourceManager;

@end

@implementation CGBrowsePhotoListView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout photoList:(nullable NSArray *)photoList
{
    return [self initWithFrame:frame registerCellClass:[CGPhotoCollectionViewCell class] collectionViewLayout:layout photoList:photoList];
}

- (instancetype)initWithFrame:(CGRect)frame registerCellClass:(Class)registerCellClass collectionViewLayout:(UICollectionViewLayout *)layout photoList:(NSArray *)photoList
{
    self    = [super initWithFrame:frame];
    if (self) {
        
        CGRect bounds   = (CGRect){CGPointZero, frame.size};
        _collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:layout];
        [self addSubview:_collectionView];
        
        [_collectionView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        Class registerCellClassName = registerCellClass;
        [_collectionView cg_registerReuseClass:registerCellClassName];
        _dataSourceManager          = [[CGCollectionViewDataSourceManager alloc] initWithDataSource:photoList cellIdentifierForClass:registerCellClassName setupCellBlock:^(UICollectionView * _Nonnull collectionView, __kindof CGCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            NSAssert([cell respondsToSelector:@selector(setupCollectionViewCellContentWithData:)], @"需要使用的cell没有setupCollectionViewCellContentWithData:方法");
            [cell setupCollectionViewCellContentWithData:data];
        }];
        _collectionView.dataSource  = _dataSourceManager;
    }
    return self;
}

- (void)cg_setupPhotoList:(NSArray *)photoList
{
    self.dataSourceManager.dataSource   = photoList;
    [self.collectionView reloadData];
}

//#pragma mark - UICollectionViewDelegate
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//
//#pragma mark - UICollectionViewDelegateFlowLayout
//
//#pragma mark - 设置属性

@end

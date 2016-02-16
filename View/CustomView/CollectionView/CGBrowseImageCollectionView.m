//
//  CGBrowseImageCollectionView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowseImageCollectionView.h"

#import "CGBrowseImageCollectionViewFlowLayout.h"

@interface CGBrowseImageCollectionView ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@end

@implementation CGBrowseImageCollectionView

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - 设置属性

- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    
    CGBrowseImageCollectionViewFlowLayout *flowLayout   = [[CGBrowseImageCollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate    = self;
    _collectionView.dataSource  = self;
    
//    [_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>]
    
    return _collectionView;
}
@end

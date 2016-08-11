//
//  CGRadioView.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioView.h"
#import "CGRadioSliderView.h"


#import "UIView+CGAddConstraints.h"

@interface CGRadioView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView    *   _collectionView;
}

/** 当前选择的标题索引 */
@property (nonatomic, strong) NSIndexPath *currentSelectedIndexPath;

@end

@implementation CGRadioView

@synthesize currentSelectedIndex   = _currentSelectedIndex;

- (instancetype)initWithFrame:(CGRect)frame appearance:(nonnull CGRadioViewAppearance *)appearance
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset                 = appearance.marginEdgeInsets;
        flowLayout.itemSize                     = appearance.itemSize;
        flowLayout.minimumInteritemSpacing      = appearance.itemSpace;
        flowLayout.scrollDirection              = UICollectionViewScrollDirectionHorizontal;
        
        [self setupLineType:appearance.lineBoxType color:appearance.lineColor length:appearance.lineLength];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.delegate    = self;
        _collectionView.dataSource  = self;
        [self addSubview:_collectionView];
        [_collectionView cg_autoEdgesInsetsZeroToSuperview];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfTitleInRadioView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource radioView:self cellForIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    
    if ([self.dataSource respondsToSelector:@selector(radioView:sizeForIndexPath:)]) {
        itemSize    = [self.dataSource radioView:self sizeForIndexPath:indexPath];
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            itemSize    = [(UICollectionViewFlowLayout *)collectionViewLayout itemSize];
        }
    }
    
    return itemSize;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSelectedIndexPath   = indexPath;
    if ([self.delegate respondsToSelector:@selector(radioView:didSelectItemAtIndexPath:)]) {
        [self.delegate radioView:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)registerClassForCellWithReuseIdentifierClass:(Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [_collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerNibForCellWithReuseIdentifierClass:(Class)cellClass
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:[NSBundle bundleForClass:cellClass]];
    [self registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier
{
    [_collectionView registerNib:nil forCellWithReuseIdentifier:identifier];
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifierClass:(Class)identifierClass forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(identifierClass) forIndexPath:indexPath];
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(nonnull NSIndexPath *)indexPath
{
    return [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - setup Slider View
- (void)setupSliderViewFrameWithCurrentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath beforeSelectedIndexPath:(NSIndexPath *)beforeSelectedIndexPath;
{
    UIView *sliderView = self.sliderView;
    
//    if ([self.dataSource respondsToSelector:@selector(radioView:sliderViewForIndex:)]) {
//        sliderView  = [self.dataSource radioView:self sliderViewForIndex:currentSelectedIndexPath.row];
//    }
    if (!self.sliderView) {
        return;
    }
    
    UICollectionViewCell *beforeSelctedCell     = nil;
    UICollectionViewCell *currentSelectedCell   = nil;
    
    if (beforeSelectedIndexPath) {
        beforeSelctedCell   = [_collectionView cellForItemAtIndexPath:beforeSelectedIndexPath];
    }
    if (currentSelectedIndexPath) {
        currentSelectedCell = [_collectionView cellForItemAtIndexPath:currentSelectedIndexPath];
    }
    
    CGRect sliderViewFrame  = CGRectZero;
    if ([self.delegate respondsToSelector:@selector(radioView:sliderViewFrameBeforeSelectedCell:currentSelectedCell:)]) {
        sliderViewFrame = [self.delegate radioView:self sliderViewFrameBeforeSelectedCell:beforeSelctedCell currentSelectedCell:currentSelectedCell];
    }
    
    BOOL isAnimation        = self.moveSliderViewIsAnimation;
    if ([self.delegate respondsToSelector:@selector(radioView:moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:currentSelectedIndex:)]) {
        isAnimation = [self.delegate radioView:self moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:beforeSelectedIndexPath.row currentSelectedIndex:currentSelectedIndexPath.row];
    }
    
    if (CGSizeEqualToSize(sliderViewFrame.size, CGSizeZero)) {
        return;
    }
    
    if (sliderView.superview) {
        [_collectionView addSubview:sliderView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        sliderView.frame    = sliderViewFrame;
    }];
}

#pragma mark - 设置属性
- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex
{
    if (_currentSelectedIndex != currentSelectedIndex || !_currentSelectedIndexPath) {
        
        _currentSelectedIndex   = currentSelectedIndex;
        [self setCurrentSelectedIndexPath:[NSIndexPath indexPathForRow:currentSelectedIndex inSection:0]];
    }
}

- (NSInteger)currentSelectedIndex
{
    return self.currentSelectedIndexPath.row;
}

- (void)setCurrentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath
{
    if (!_currentSelectedIndexPath || (currentSelectedIndexPath.row != _currentSelectedIndexPath.row && currentSelectedIndexPath.section != currentSelectedIndexPath.section)) {
        
        [self setupSliderViewFrameWithCurrentSelectedIndexPath:currentSelectedIndexPath beforeSelectedIndexPath:_currentSelectedIndexPath];
        
        _currentSelectedIndexPath   = currentSelectedIndexPath;
    }
}

@end

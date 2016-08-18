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
    UICollectionView        *   _collectionView;
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
        _collectionView.showsHorizontalScrollIndicator  = NO;
        
        [self addSubview:_collectionView];
        
        [_collectionView cg_autoEdgesToSuperviewEdgesWithInsets:[appearance getSubviewEdgeInsets]];
        
        self.backgroundColor            = appearance.backgroundColor;
        _collectionView.backgroundColor = appearance.backgroundColor;
    }
    return self;
}

- (void)reloadData
{
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfTitleInRadioView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell  = [self.dataSource radioView:self cellForIndexPath:indexPath];
    
    BOOL isSelected = NO;
    if (indexPath.row == self.currentSelectedIndex) {
        isSelected  = YES;
    }
    if (cell.selected != isSelected) {
        [cell setSelected:isSelected];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (cell.selected && indexPath != _currentSelectedIndexPath) {
        
        NSIndexPath *beforeIndexPath    = _currentSelectedIndexPath;
        _currentSelectedIndexPath       = indexPath;
        _currentSelectedIndex           = indexPath.row;
        [self setupSliderViewFrameWithCurrentSelectedCell:cell currentSelectedIndexPath:indexPath beforeSelectedCell:[collectionView cellForItemAtIndexPath:beforeIndexPath] beforeSelectedIndexPath:beforeIndexPath];
    }
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
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isShouldSelectedItem   = YES;
    if ([self.delegate respondsToSelector:@selector(radioView:shouldSelectedIndexPath:)]) {
        isShouldSelectedItem    = [self.delegate radioView:self shouldSelectedIndexPath:indexPath];
    }
    return isShouldSelectedItem;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setupCurrentIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(radioView:didSelectItemAtIndexPath:)]) {
        [self.delegate radioView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - 注册/重用
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
/** 更新滑块，返回更新是否成功 */
- (BOOL)setupSliderViewFrameWithCurrentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath beforeSelectedIndexPath:(NSIndexPath *)beforeSelectedIndexPath;
{
    
    UICollectionViewCell *beforeSelectedCell     = nil;
    UICollectionViewCell *currentSelectedCell   = nil;
    
    if (beforeSelectedIndexPath) {
        beforeSelectedCell   = [_collectionView cellForItemAtIndexPath:beforeSelectedIndexPath];
    }
    if (currentSelectedIndexPath) {
        currentSelectedCell = [_collectionView cellForItemAtIndexPath:currentSelectedIndexPath];
    }
    
    if (!currentSelectedCell) {
        return NO;
    }
    
    return [self setupSliderViewFrameWithCurrentSelectedCell:currentSelectedCell currentSelectedIndexPath:currentSelectedIndexPath beforeSelectedCell:beforeSelectedCell beforeSelectedIndexPath:beforeSelectedIndexPath];
}

- (BOOL)setupSliderViewFrameWithCurrentSelectedCell:(UICollectionViewCell *)currentSelectedCell currentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath beforeSelectedCell:(UICollectionViewCell *)beforeSelectedCell beforeSelectedIndexPath:(NSIndexPath *)beforeSelectedIndexPath;
{
    CGRadioSliderView *sliderView = self.sliderView;
//    if ([self.dataSource respondsToSelector:@selector(radioView:sliderViewForIndex:)]) {
//        sliderView  = [self.dataSource radioView:self sliderViewForIndex:currentSelectedIndexPath.row];
//    }
    
    if (!self.sliderView) {
        return NO;
    }
    
    if (!sliderView.superview) {
        
        CGRect frame            = sliderView.frame;
        if ([self.delegate respondsToSelector:@selector(radioView:frameWithSliderView:)]) {
            frame   = [self.delegate radioView:self frameWithSliderView:sliderView];
        }else if (sliderView.positionType) {
            
            switch (sliderView.positionType) {
                case CGSliderViewPositionTypeTop:
                    frame.origin.y = 0;
                    break;
                case CGSliderViewPositionTypeBottom:
                    frame.origin.y  = _collectionView.height - CGRectGetHeight(frame);
                    break;
                default:
                    break;
            }
        }
        
        if (!CGRectEqualToRect(frame, sliderView.frame)) {
            sliderView.frame    =   frame;
        }
        
        [_collectionView addSubview:sliderView];
    }
    
    CGRect sliderViewFrame  = CGRectZero;
    if ([self.delegate respondsToSelector:@selector(radioView:sliderViewFrameBeforeSelectedCell:currentSelectedCell:)]) {
        sliderViewFrame = [self.delegate radioView:self sliderViewFrameBeforeSelectedCell:beforeSelectedCell currentSelectedCell:currentSelectedCell];
    }
    
    BOOL isAnimation        = self.moveSliderViewIsAnimation;
    if ([self.delegate respondsToSelector:@selector(radioView:moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:currentSelectedIndex:)]) {
        isAnimation = [self.delegate radioView:self moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:beforeSelectedIndexPath.row currentSelectedIndex:currentSelectedIndexPath.row];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        sliderView.frame    = sliderViewFrame;
    }];
    
    if (!currentSelectedCell.isSelected) {
        [currentSelectedCell setSelected:YES];
    }
    if (beforeSelectedCell.isSelected) {
        [beforeSelectedCell setSelected:NO];
    }
    
    return YES;
}

- (void)setupCurrentIndexPath:(NSIndexPath *)indexPath
{
    self.currentSelectedIndexPath   = indexPath;
    _currentSelectedIndex           = indexPath.row;
}

#pragma mark - 设置属性
- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex
{
    if (_currentSelectedIndex != currentSelectedIndex || !_currentSelectedIndexPath) {
        
        _currentSelectedIndex   = currentSelectedIndex;
        
        if ([_collectionView numberOfItemsInSection:0] > _currentSelectedIndex) {
            [self setCurrentSelectedIndexPath:[NSIndexPath indexPathForRow:currentSelectedIndex inSection:0]];
        }
    }
}

- (BOOL)didSelectedIndexFlag
{
    return self.currentSelectedIndexPath;
}

- (void)setCurrentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath
{
    if (_currentSelectedIndexPath != currentSelectedIndexPath) {
        
        BOOL isResult   = [self setupSliderViewFrameWithCurrentSelectedIndexPath:currentSelectedIndexPath beforeSelectedIndexPath:_currentSelectedIndexPath];
        
        if (isResult) {
            _currentSelectedIndexPath   = currentSelectedIndexPath;
        }
    }
}

@end

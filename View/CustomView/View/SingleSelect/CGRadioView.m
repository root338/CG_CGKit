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

#import "CGVerifyIOSVersionHeader.h"
#import "CGRadioViewAppearanceHeader.h"

@interface CGRadioView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView            *   _collectionView;
}

/** 当前选择的标题索引 */
@property (nonatomic, strong) NSIndexPath *currentSelectedIndexPath;

@property (nonatomic, strong, readwrite) CGRadioViewAppearance *appearance;
@property (nonatomic, copy) void (^updateCollectionSelectedBlock) (void);
@end

@implementation CGRadioView

@synthesize currentSelectedIndex   = _currentSelectedIndex;

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame appearance:[CGRadioViewAppearance new]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame appearance:(nonnull CGRadioViewAppearance *)appearance
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRadioViewFlowLayout *flowLayoutAppearance = appearance.radioViewFlowLayout;
        UICollectionViewFlowLayout *flowLayout  = [self createCollectionViewFlowLayoutWithRadioViewFlowLayout:flowLayoutAppearance];
        
        [self setupLineType:appearance.lineBoxType color:appearance.lineColor length:appearance.lineLength];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.delegate    = self;
        _collectionView.dataSource  = self;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.showsVerticalScrollIndicator    = NO;
        
        [self addSubview:_collectionView];
        
        [_collectionView cg_autoEdgesToSuperviewEdgesWithInsets:[appearance getSubviewEdgeInsets]];
        
        self.backgroundColor            = appearance.backgroundColor;
        _collectionView.backgroundColor = appearance.backgroundColor;
        
        _appearance                     = appearance;
    }
    return self;
}

- (void)reloadData
{
    [_collectionView reloadData];
}

- (void)scrollTopView
{
    [_collectionView setContentOffset:CGPointZero animated:YES];
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
    
    if (cell.selected) {
        [self setupSelectedWithCollectionView:collectionView willSelectedCell:cell forItemAtIndexPath:indexPath];
    }
    
    return cell;
}

- (void)setupSelectedWithCollectionView:(UICollectionView *)collectionView willSelectedCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
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
    
    CGRadioViewFlowLayout *flowLayout   = self.appearance.radioViewFlowLayout;
    if (flowLayout.isAutoItemSize && [self.dataSource respondsToSelector:@selector(radioView:sizeForIndexPath:)]) {
        itemSize    = [self.dataSource radioView:self sizeForIndexPath:indexPath];
    }else {
        
        if (flowLayout.itemWidthEqualSuperViewWidth) {
            itemSize.width  = collectionView.width;
        }else {
            itemSize.width  = flowLayout.itemSize.width;
        }
        
        if (flowLayout.itemHeightWidthEqualSuperViewHeight) {
            itemSize.height = collectionView.height;
        }else {
            itemSize.height = flowLayout.itemSize.height;
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

#pragma mark - update flow layout
- (UICollectionViewFlowLayout *)createCollectionViewFlowLayoutWithRadioViewFlowLayout:(CGRadioViewFlowLayout *)paramFlowLayout
{
    UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset                 = paramFlowLayout.marginEdgeInsets;
    flowLayout.itemSize                     = paramFlowLayout.itemSize;
    flowLayout.minimumInteritemSpacing      = paramFlowLayout.minimumInteritemSpacing;
    flowLayout.minimumLineSpacing           = paramFlowLayout.minimumLineSpacing;
    flowLayout.scrollDirection              = paramFlowLayout.scrollDirection;
    return flowLayout;
}

- (void)setRadioViewFlowLayout:(CGRadioViewFlowLayout *)layout
{
    [self setRadioViewFlowLayout:layout animated:self.updateRadioViewFlowLayoutIsAnimated];
}

- (void)setRadioViewFlowLayout:(CGRadioViewFlowLayout *)layout animated:(BOOL)animated
{
    [self setRadioViewViewLayout:layout animated:animated completion:nil];
}

- (void)setRadioViewViewLayout:(CGRadioViewFlowLayout *)layout animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    CGMutableRadioViewAppearance *appearance    = [self.appearance mutableCopy];
    appearance.radioViewFlowLayout              = layout;
    self.appearance                             = appearance;
    
    UICollectionViewFlowLayout *flowLayout  = [self createCollectionViewFlowLayoutWithRadioViewFlowLayout:layout];
    [_collectionView setCollectionViewLayout:flowLayout animated:animated completion:completion];
}

- (BOOL)isShouldReloadData {
    
    return CGRectGetWidth(_collectionView.frame) > CGFLOAT_MIN && CGRectGetHeight(_collectionView.frame) > CGFLOAT_MIN;
}

- (void)setUpdateCollectionSelected {
    if ([_collectionView numberOfItemsInSection:0] > _currentSelectedIndex && [self isShouldReloadData]) {
        [self setCurrentSelectedIndexPath:[NSIndexPath indexPathForRow:self.currentSelectedIndex inSection:0]];
    }else {
        UICollectionView *collecitonView = _collectionView;
        __weak __block typeof(self) weakself = self;
        self.updateCollectionSelectedBlock = ^{
            [collecitonView performBatchUpdates:^{
                [collecitonView reloadData];
            } completion:^(BOOL finished) {
                [weakself setCurrentSelectedIndexPath:[NSIndexPath indexPathForRow:weakself.currentSelectedIndex inSection:0]];
            }];
            weakself.updateCollectionSelectedBlock = nil;
        };
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    !_updateCollectionSelectedBlock?: _updateCollectionSelectedBlock();
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
    
    BOOL isResult   = currentSelectedCell == nil;
    
    CGRadioSliderView *sliderView   = [self getCurrentRadioSliderView];
    if (sliderView.hidden != isResult) {
        sliderView.hidden   = isResult;
    }
    
    if (isResult) {
        if (!self.disableCurrentSelectedIndexToCenterHorizontalPosition) {
            [_collectionView scrollToItemAtIndexPath:currentSelectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        return NO;
    }
    
    return [self setupSliderViewFrameWithCurrentSelectedCell:currentSelectedCell currentSelectedIndexPath:currentSelectedIndexPath beforeSelectedCell:beforeSelectedCell beforeSelectedIndexPath:beforeSelectedIndexPath];
}

- (__kindof CGRadioSliderView *)getCurrentRadioSliderView
{
    CGRadioSliderView *sliderView = self.sliderView;
    //    if ([self.dataSource respondsToSelector:@selector(radioView:sliderViewForIndex:)]) {
    //        sliderView  = [self.dataSource radioView:self sliderViewForIndex:currentSelectedIndexPath.row];
    //    }
    return sliderView;
}

- (BOOL)setupSliderViewFrameWithCurrentSelectedCell:(UICollectionViewCell *)currentSelectedCell currentSelectedIndexPath:(NSIndexPath *)currentSelectedIndexPath beforeSelectedCell:(UICollectionViewCell *)beforeSelectedCell beforeSelectedIndexPath:(NSIndexPath *)beforeSelectedIndexPath;
{
    if (!currentSelectedCell.isSelected) {
        [currentSelectedCell setSelected:YES];
    }
    if (beforeSelectedCell.isSelected) {
        [beforeSelectedCell setSelected:NO];
    }
    
    if (self.appearance.isHideSliderView) {
        return NO;
    }
    CGRadioSliderView *sliderView   = [self getCurrentRadioSliderView];
    
    if (!sliderView) {
        return NO;
    }
    
    if (!sliderView.superview) {
        
        [self sliderView:sliderView isUpdate:NO];
        
        [_collectionView addSubview:sliderView];
    }
    
    if (self.appearance.isHideSliderView !=  sliderView.hidden) {
        sliderView.hidden   = self.appearance.isHideSliderView;
    }
    
    CGRect sliderViewFrame  = CGRectZero;
    if ([self.delegate respondsToSelector:@selector(radioView:sliderViewFrameBeforeSelectedCell:currentSelectedCell:)]) {
        sliderViewFrame = [self.delegate radioView:self sliderViewFrameBeforeSelectedCell:beforeSelectedCell currentSelectedCell:currentSelectedCell];
    }
    
    BOOL isAnimation        = self.moveSliderViewIsAnimation;
    if ([self.delegate respondsToSelector:@selector(radioView:moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:currentSelectedIndex:)]) {
        isAnimation = [self.delegate radioView:self moveSliderViewFrameShouldAnimationWithBeforeSelectedIndex:beforeSelectedIndexPath.row currentSelectedIndex:currentSelectedIndexPath.row];
    }
    
    [UIView animateWithDuration:isAnimation ? 0.3 : 0 animations:^{
        sliderView.frame    = sliderViewFrame;
    }];
    
    if (!self.disableCurrentSelectedIndexToCenterHorizontalPosition) {
        [_collectionView scrollToItemAtIndexPath:currentSelectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
    return YES;
}

- (void)sliderView:(CGRadioSliderView *)sliderView isUpdate:(BOOL)isUpdate
{
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
        _updateCollectionSelectedBlock = nil;
        [self setUpdateCollectionSelected];
    }
}

- (BOOL)didSelectedIndexFlag
{
    return (self.currentSelectedIndexPath != nil) ? YES : NO;
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

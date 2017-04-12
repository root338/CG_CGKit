//
//  CGTitleRadioView.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioView.h"

#import "CGRadioView.h"
#import "CGRadioSliderView.h"
#import "CGTitleRadioCollectionViewCell.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGAddConstraints.h"
#import "UIView+CGSetupAppearance.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIView+CGUpdateViewLayout.h"

#import "CGDispathMethod.h"
#import "CGRadioViewAppearanceHeader.h"

@interface CGTitleRadioView ()<CGRadioViewDataSource, CGRadioViewDelegate>
{
    CGRadioViewAppearance   *_appearance;
    
    //缓存的标题cell
    CGTitleRadioCollectionViewCell  *_cacheResueCell;
    // 缓存标题的大小
    NSMutableDictionary<NSIndexPath *, NSValue *>   *_cacheTitleSize;
    
    NSArray *_dataSource;
}

@property (nonatomic, strong) CGRadioView *radioView;

@property (nonatomic, copy) CGTitleRadioGetTitleBlock getTitleBlock;
@end

@implementation CGTitleRadioView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame titles:nil appearance:[CGRadioViewAppearance defaultRadioAppearance]];
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles appearance:(nonnull CGRadioViewAppearance *)appearance
{
    CGRect frame  = CGRectZero;
    return [self initWithFrame:frame titles:titles appearance:appearance];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles appearance:(CGRadioViewAppearance *)appearance
{
    self    = [super initWithFrame:frame];
    if (self) {
        
        _titles = titles;
        _isCacheCellsSize           = NO;
        _currentSelectedTitleIndex  = 0;
        
        CGRadioSliderView *sliderView   = nil;
        
        if (!appearance.isHideSliderView) {
            
            CGRadioSliderViewAppearance *radioSliderViewAppearance  = appearance.radioSliderViewAppearance;
            
            sliderView                      = [[CGRadioSliderView alloc] init];
            sliderView.positionType         = radioSliderViewAppearance.sliderViewPositionType;
            sliderView.backgroundColor      = radioSliderViewAppearance.sliderViewBackgroundColor;
            [sliderView cg_setupBorderWithWidth:radioSliderViewAppearance.sliderViewBorderWidth color:radioSliderViewAppearance.sliderViewBorderColor cornerRadius:radioSliderViewAppearance.sliderViewCornerRadius];
            sliderView.hidden               = appearance.isHideSliderView;
        }
        
        _radioView  = [[CGRadioView alloc] initWithFrame:frame appearance:appearance];
        
        _radioView.dataSource   = self;
        _radioView.delegate     = self;
        _radioView.sliderView   = sliderView;
        
        [_radioView registerClassForCellWithReuseIdentifierClass:[CGTitleRadioCollectionViewCell class]];
        
        [self addSubview:_radioView];
        [_radioView cg_autoEdgesInsetsZeroToSuperview];
        
        _appearance = appearance;
        [self setupSelectedTitleIndex:0];
    }
    return self;
}

- (void)setupTitlesWithDataSouce:(NSArray *)dataSource getTitleBlock:(nonnull CGTitleRadioGetTitleBlock)titleBlock
{
    _titles             = nil;
    _dataSource         = dataSource;
    self.getTitleBlock  = titleBlock;
    [self.radioView reloadData];
    
    [self setupSelectedTitleIndex:self.currentSelectedTitleIndex];
}

- (void)setupSelectedTitleIndex:(NSInteger)index
{
    NSArray *dataSource = _titles ? _titles : _dataSource;
    if (dataSource.count > index) {
        self.radioView.currentSelectedIndex = index;
    }
}

- (NSString *)getTitleAtIndex:(NSInteger)index
{
    if (_titles) {
        return _titles[index];
    }else {
        return self.getTitleBlock(index, _dataSource[index]);
    }
}

- (void)scrollTopView
{
    [self.radioView scrollTopView];
}

#pragma mark - CGRadioViewDataSource
- (NSInteger)numberOfTitleInRadioView:(CGRadioView *)radioView
{
    if (_titles) {
        return _titles.count;
    }else {
        return _dataSource.count;
    }
}

- (UICollectionViewCell *)radioView:(CGRadioView *)radioView cellForIndexPath:(NSIndexPath *)indexPath
{
    CGTitleRadioCollectionViewCell *cell = [radioView dequeueReusableCellWithReuseIdentifierClass:[CGTitleRadioCollectionViewCell class] forIndexPath:indexPath];
    
    [cell setupCollectionViewCellContentWithData:_appearance.titleRadioCellAppearance];
    [cell.titleLabel setText:[self getTitleAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)radioView:(CGRadioView *)radioView sizeForIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isCacheCellsSize) {
        return [self calculateSizeWithIndex:indexPath.row];
    }
    
    NSValue *sizeValue  = [_cacheTitleSize objectForKey:indexPath];
    if (!sizeValue) {
        if (!_cacheTitleSize) {
            _cacheTitleSize = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        
        CGSize size = [self calculateSizeWithIndex:indexPath.row];
        sizeValue   = [NSValue valueWithCGSize:size];
        
        [_cacheTitleSize setObject:sizeValue forKey:indexPath];
    }
    
    return [sizeValue CGSizeValue];
}

- (CGSize)calculateSizeWithIndex:(NSInteger)index
{
    if (!_cacheResueCell) {
        _cacheResueCell = [[CGTitleRadioCollectionViewCell alloc] initWithFrame:CGRectZero];
        [_cacheResueCell setupCollectionViewCellContentWithData:_appearance.titleRadioCellAppearance];
    }
    
    [_cacheResueCell.titleLabel setText:[self getTitleAtIndex:index]];
    
    [_cacheResueCell cg_updateContentLayoutIfNeeded];
    
    CGSize size = [_cacheResueCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    CGFloat width, height;
    
    CGRadioViewFlowLayout *flowLayout   = self.appearance.radioViewFlowLayout;
    
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        if (flowLayout.itemWidthEqualSuperViewWidth) {
            width   = self.width;
        }else {
            width   = flowLayout.itemSize.width;
        }
        
        height  = size.height;
    }else {
        
        width   = size.width;
        if (flowLayout.itemHeightWidthEqualSuperViewHeight) {
            height  = self.height;
        }else {
            height  = flowLayout.itemSize.height;
        }
    }
    
    return CGSizeMake(width, height);
}

#pragma mark - CGRadioViewDelegate

- (CGRect)radioView:(CGRadioView *)radioView sliderViewFrameBeforeSelectedCell:(__kindof UICollectionViewCell *)beforeSelectedCell currentSelectedCell:(__kindof UICollectionViewCell *)currentSelectedCell
{
    CGSize sliderViewSize = CGSizeMake(currentSelectedCell.width, self.appearance.radioSliderViewAppearance.sliderViewHeight);
    CGPoint sliderViewOrigin    = CGPointMake(currentSelectedCell.xCenter - sliderViewSize.width / 2.0, currentSelectedCell.height - sliderViewSize.height);
    return (CGRect){sliderViewOrigin, sliderViewSize};
}

- (void)radioView:(CGRadioView *)radioView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSelectedTitleIndex  = indexPath.row;
    if (self.didSelectedCallback) {
        self.didSelectedCallback(indexPath.row, self.currentDataSouce[indexPath.row]);
    }
}

#pragma mark - 设置属性
- (NSArray *)currentDataSouce
{
    return _titles ? _titles : _dataSource;
}

- (void)setTitles:(NSArray<NSString *> *)titles
{
    _dataSource     = nil;
    _titles         = titles;
    [self.radioView reloadData];
    [self setupSelectedTitleIndex:self.currentSelectedTitleIndex];
}

- (void)setCurrentSelectedTitleIndex:(NSInteger)currentSelectedTitleIndex
{
    
    _currentSelectedTitleIndex  = currentSelectedTitleIndex;
    [self setupSelectedTitleIndex:currentSelectedTitleIndex];
}

- (CGRadioViewAppearance *)appearance
{
    if (_appearance != nil) {
        return _appearance;
    }
    
    _appearance = [CGRadioViewAppearance defaultRadioAppearance];
    return _appearance;
}

- (void)setDisableCurrentSelectedIndexToCenterHorizontalPosition:(BOOL)disableCurrentSelectedIndexToCenterHorizontalPosition
{
    _disableCurrentSelectedIndexToCenterHorizontalPosition  = disableCurrentSelectedIndexToCenterHorizontalPosition;
    self.radioView.disableCurrentSelectedIndexToCenterHorizontalPosition    = disableCurrentSelectedIndexToCenterHorizontalPosition;
}

@end

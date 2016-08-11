//
//  CGTitleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 16/8/11.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleScrollView.h"
#import "CGSingleScrollView.h"

#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"

#import "UIView+CGSetupFrame.h"
#import "CGRadioViewDelegate.h"
#import "UIScrollView+CGCreate.h"
#import "CGSingleViewDataSource.h"

@interface CGTitleScrollView ()
<
    CGRadioViewDelegate,
    UIScrollViewDelegate,
    CGSingleViewDataSource
>
{
    //标题视图的高度约束
    NSLayoutConstraint *_titleViewHeightConstraint;
    
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CGSingleScrollView *titleScrollView;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, __kindof UIView *> *didAddToScrollView;
@end

@implementation CGTitleScrollView

- (instancetype)initWithTitleHeight:(CGFloat)titleHeight titles:(NSArray<NSString *> *)titles
{
    self    = [self initWithFrame:CGRectZero];
    if (self) {
        
        _titleViewHeight    = titleHeight;
        _titles = titles;
        [self setupTitleViewHeight:titleHeight];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView         = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:YES];
        _titleScrollView    = [[CGSingleScrollView alloc] init];
        
        NSArray *subviews   = @[
                                _titleScrollView,
                                _scrollView,
                                ];
        [self addSubview:_titleScrollView];
        [self addSubview:_scrollView];
        
        [subviews cg_autoSetupVerticalSubviewsLayout];
        
        [self setupContentView];
    }
    return self;
}

- (void)setupTitleViewHeight:(CGFloat)titleViewHeight
{
    if (_titleViewHeightConstraint) {
        
        _titleViewHeightConstraint.constant = titleViewHeight;
    }else {
        
        _titleViewHeightConstraint  = [_titleScrollView cg_autoDimension:CGDimensionHeight fixedLength:titleViewHeight];
    }
}

- (void)setupContentView
{
    _scrollView.delegate        = self;
    _titleScrollView.delegate   = self;
    _titleScrollView.dataSource = self;
}

- (void)reloadAllView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.didAddToScrollView removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self setupScrollViewLayout];
}

- (void)setupScrollViewLayout
{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.titles.count, self.scrollView.height);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * self.currentPage, 0)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupScrollViewLayout];
    [self.didAddToScrollView enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, __kindof UIView * _Nonnull obj, BOOL * _Nonnull stop) {
        [self setupPageViewLayoutWithIndex:key.integerValue];
    }];
}

#pragma mark - CGRadioViewDelegate
- (void)radioView:(CGRadioView *)radioView selectedAtIndex:(NSInteger)selectedIndex
{
    
}

#pragma mark - CGSingleViewDataSource
- (NSInteger)singleView:(CGRadioView *)singleView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (NSString *)singleView:(CGRadioView *)singleView controlTitleAtIndex:(NSIndexPath *)indexPath
{
    return [self.titles objectAtIndex:indexPath.row];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.width;
    self.currentPage    = pageIndex;
}

- (void)setupPageViewWithIndex:(NSInteger)index
{
    NSNumber *key = @(index);
    if ([self.didAddToScrollView objectForKey:key]) {
        return;
    }
    UIView *view = [self.dataSource titleScrollView:self viewForAtIndex:index];
    
    [self.didAddToScrollView setObject:view forKey:key];
    [self.scrollView addSubview:view];
    [self setupPageViewLayoutWithIndex:index];
}

- (void)setupPageViewLayoutWithIndex:(NSInteger)index
{
    UIView *view    = [self.didAddToScrollView objectForKey:@(index)];
    view.frame      = CGRectMake(self.scrollView.width * index, 0, self.scrollView.width, self.scrollView.height);
}

#pragma mark - 设置属性
- (void)setTitleViewHeight:(CGFloat)titleViewHeight
{
    if (_titleViewHeight != titleViewHeight) {
        
        _titleViewHeight    = titleViewHeight;
        [self setupTitleViewHeight:titleViewHeight];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage != currentPage) {
        _currentPage    = currentPage;
        [self setupPageViewWithIndex:currentPage];
    }
}

- (NSMutableDictionary<NSNumber *, __kindof UIView *> *)didAddToScrollView
{
    if (_didAddToScrollView) {
        return _didAddToScrollView;
    }
    
    _didAddToScrollView = [NSMutableDictionary dictionaryWithCapacity:1];
    return _didAddToScrollView;
}

- (void)setDataSource:(id<CGTitleScrollViewDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        
        _dataSource = dataSource;
        [self performSelector:@selector(reloadAllView) withObject:nil afterDelay:0.0];
    }
}

- (void)setTitleAppearance:(CGRadioTitleCellAppearance *)titleAppearance
{
    self.titleScrollView.titleAppearance   = titleAppearance;
}

- (CGRadioTitleCellAppearance *)titleAppearance
{
    return self.titleScrollView.titleAppearance;
}
@end

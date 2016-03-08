//
//  CGCycleBrowseScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleBrowseImageScrollView.h"
#import "CGCycleScrollView.h"

#import "UIView+CGSetupFrame.h"

#import "UIImageView+CGCreateView.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIImageView+CGSetupImageURL.h"

#import "NSArray+CGArray.h"

@interface CGCycleBrowseImageScrollView ()<CGCycleScrollViewDataSource, CGCycleScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property (strong, nonatomic, readwrite) CGCycleScrollView *cycleScrollView;

@property (strong, nonatomic, readwrite) UIPageControl *pageControl;
@end

@implementation CGCycleBrowseImageScrollView

+ (instancetype)createCycleBrowseImageScrollViewWithImages:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    CGCycleBrowseImageScrollView *browseImageView = [[self alloc] init];
    
    [browseImageView setupDataSourceWithObject:dataSource extractBlock:extractBlock];
    
    return browseImageView;
}

- (void)initialization
{
    _imageViewContentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)setupDataSourceWithObject:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    if (dataSource.count) {
        
        if (!extractBlock) {
            
            self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        }else {
            
            if (!self.dataSource) {
                self.dataSource = [NSMutableArray arrayWithCapacity:dataSource.count];
            }else {
                [self.dataSource removeAllObjects];
            }
            
            __weak __block typeof(self) weakself = self;
            [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *imagePath = extractBlock(obj);
                
                [weakself.dataSource addObject:imagePath ? imagePath : @""];
            }];
        }
    }else {
        
        self.dataSource = nil;
    }
    
    if (_cycleScrollView) {
        [self.cycleScrollView reloadAllView];
    }
    
    self.cycleScrollView.superview ?: [self addSubview:self.cycleScrollView];
    [self setupCycleScrollViewFrame];
    
    if (self.isHidePageControl) {
        if (_pageControl.superview) {
            [_pageControl removeFromSuperview];
        }
        _pageControl = nil;
    }else {
        
        if (!self.pageControl.superview) {
            [self addSubview:self.pageControl];
        }
        
        self.pageControl.numberOfPages  = self.dataSource.count;
        self.pageControl.currentPage    = self.cycleScrollView.currentIndex;
        
        [self setupPageControlShowArea];
    }
}

#pragma mark - CGCycleScrollViewDataSource
- (NSInteger)numberCycleScrollView:(CGCycleScrollView *)cycleScrollView
{
    return self.dataSource.count;
}

- (UIView *)cycleScrollView:(CGCycleScrollView *)cycleScrollView viewAtIndex:(NSInteger)index
{
    UIImageView *imageView = [UIImageView cg_createImageViewWithContentMode:self.imageViewContentMode];
    [imageView cg_setupImageWithPath:[self.dataSource cg_objectAtIndex:index]];
    if (self.setupImageViewContent) {
        self.setupImageViewContent(imageView, index);
    }
    return imageView;
}

#pragma mark - CGCycleScrollViewDelegate
- (void)cycleScrollView:(CGCycleScrollView *)cycleScrollView didChangeCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
        
        _currentIndex   = currentIndex;
        self.pageControl.currentPage = currentIndex;
        
        if (self.currentIndexDidChangeCallback) {
            
            self.currentIndexDidChangeCallback(currentIndex);
        }
    }
}

- (void)cycleScrollView:(CGCycleScrollView *)cycleScrollView didSelectRowAtIndex:(NSInteger)index
{
    if (self.clickIndexCallback) {
        self.clickIndexCallback(index);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupCycleScrollViewFrame];
    [self setupPageControlShowArea];
}

- (void)setupCycleScrollViewFrame
{
    
    CGRect frame = CG_CGRectWithMargin(self.bounds, self.marginEdgeInset);
    if (!CGRectEqualToRect(self.cycleScrollView.frame, frame)) {
        self.cycleScrollView.frame = frame;
    }
}

- (void)setupPageControlShowArea
{
    if (!_pageControl) {
        return;
    }
    
    if (CGRectEqualToRect(self.pageControl.frame, CGRectZero) && self.pageControl.numberOfPages) {
        [self.pageControl sizeToFit];
    }
    
    if (self.setupPageControlFrame) {
        
        CGRect frame = self.setupPageControlFrame(self.frame, self.pageControl);
        if (!CGRectEqualToRect(frame, self.pageControl.frame)) {
            self.pageControl.frame = frame;
        }
    }else {
        
        CGPoint origin = CGPointMake((self.width - self.pageControl.width) / 2, 0);
        if (self.positionForPageControl == CGCycleBrowseImageViewPageControlPositionBottom) {
            origin = CGPointMake(0, self.height - self.pageControl.height);
        }
        
        if (!CGPointEqualToPoint(origin, self.pageControl.origin)) {
            self.pageControl.origin = origin;
        }
    }
}

#pragma mark - 设置属性
- (CGCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView) {
        return _cycleScrollView;
    }
    
    _cycleScrollView                = [[CGCycleScrollView alloc] init];
    _cycleScrollView.dataSource     = self;
    _cycleScrollView.delegate       = self;
    _cycleScrollView.pagingEnabled  = YES;
    
    return _cycleScrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl) {
        return _pageControl;
    }
    
    _pageControl = [[UIPageControl alloc] init];
    return _pageControl;
}

- (void)setMarginEdgeInset:(UIEdgeInsets)marginEdgeInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_marginEdgeInset, marginEdgeInset)) {
        
        _marginEdgeInset = marginEdgeInset;
        [self setupCycleScrollViewFrame];
    }
}

- (void)setMarginEdgeInsetForSubview:(UIEdgeInsets)marginEdgeInsetForSubview
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsetForSubview, _marginEdgeInsetForSubview)) {
        _marginEdgeInsetForSubview = marginEdgeInsetForSubview;
        self.cycleScrollView.marginEdgeInsetForSubviews = marginEdgeInsetForSubview;
    }
}

- (void)setContentViewSpace:(CGFloat)contentViewSpace
{
    if (_contentViewSpace != contentViewSpace) {
        
        _contentViewSpace   = contentViewSpace;
        self.cycleScrollView.subviewSpace   = contentViewSpace;
    }
}

- (void)setClipsToBounds:(BOOL)clipsToBounds
{
    [super setClipsToBounds:clipsToBounds];
    self.cycleScrollView.clipsToBounds  = clipsToBounds;
}
@end

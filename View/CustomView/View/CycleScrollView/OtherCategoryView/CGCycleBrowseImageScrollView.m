//
//  CGCycleBrowseScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleBrowseImageScrollView.h"

#import "CGImageView.h"
#import "CGCycleScrollView.h"

#import "UIView+CGSetupFrame.h"

#import "UIImageView+CGCreate.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIImageView+CGSetupImageURL.h"

#import "NSArray+CGArray.h"

#import "UIView+Constant.h"

#import "CGPrintLogHeader.h"

@interface CGCycleBrowseImageScrollView ()<CGCycleScrollViewDataSource, CGCycleScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property (nonatomic, assign, readwrite) BOOL imageScrollZoom;

@property (strong, nonatomic, readwrite) CGCycleScrollView *cycleScrollView;

@property (strong, nonatomic, readwrite) UIPageControl *pageControl;
@end

@implementation CGCycleBrowseImageScrollView

@synthesize enableSingleImageCycleScroll = _enableSingleImageCycleScroll;

+ (instancetype)createCycleBrowseImageScrollViewWithImages:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    CGCycleBrowseImageScrollView *browseImageView = [[self alloc] init];
    
    [browseImageView setupDataSourceWithObject:dataSource extractBlock:extractBlock];
    
    return browseImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame imageScrollZoom:NO];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame imageScrollZoom:(BOOL)imageScrollZoom
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageScrollZoom    = imageScrollZoom;
        _imageViewSizeEqualViewSize = !imageScrollZoom;
    }
    return self;
}

- (void)initialization
{
    _imageViewContentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)setupDataSourceWithObject:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    if (dataSource.count) {
        
        if (!extractBlock) {
            
            _dataSource = dataSource;
        }else {
            
            NSMutableArray *tempDataSource  = [NSMutableArray arrayWithCapacity:dataSource.count];
            
            [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *imagePath = extractBlock(obj);
                if ([imagePath isKindOfClass:[NSString class]]) {
                    [tempDataSource addObject:imagePath ? imagePath : @""];
                }else {
                    CGErrorLog(@"只支持NSString * 类型的返回");
                }
                
            }];
            _dataSource = tempDataSource;
        }
    }else {
        
        _dataSource = nil;
    }
    
    [self setupCycleScroll];
    
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
        
        self.pageControl.numberOfPages  = _dataSource.count;
        self.pageControl.currentPage    = self.cycleScrollView.currentIndex;
        
        [self setupPageControlShowArea];
    }
}

- (void)setupDataSourceWithObject:(NSArray *)dataSource startIndex:(NSInteger)startIndex extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    [self setupDataSourceWithObject:dataSource extractBlock:extractBlock];
    [self scrollBrowseImageCellToIndex:startIndex];
}

- (void)scrollBrowseImageCellToIndex:(NSInteger)index
{
    [self.cycleScrollView scrollToIndex:index];
}

#pragma mark - CGCycleScrollViewDataSource
- (NSInteger)numberCycleScrollView:(CGCycleScrollView *)cycleScrollView
{
    return self.dataSource.count;
}

- (UIView *)cycleScrollView:(CGCycleScrollView *)cycleScrollView viewAtIndex:(NSInteger)index
{
    CGImageView *cell  = [[CGImageView alloc] init];
    cell.imageViewSizeEqualViewSize = self.imageViewSizeEqualViewSize;
    
    cell.disableScale   = !self.imageScrollZoom;
    cell.imageView.contentMode  = self.imageViewContentMode;
    
    if (self.setupLoadImage) {
        
        self.setupLoadImage([self.dataSource cg_objectAtIndex:index], cell.imageView);
    }else {
        
#if __has_include(<UIImageView+WebCache>) && __has_include(<SDWebImageManager.h>)
        
        [cell.imageView cg_setupImageWithPath:[self.dataSource cg_objectAtIndex:index]];
#else
        
        NSAssert(nil, @"缺少自动网络加载方法cg_setupImageWithPath:, 如果添加UIImageView+CGSetupImageURL扩展，那需要 SDWebImage 第三方库");
#endif
    }
    
    if (self.imageScrollZoom) {
        cell.imageScrollView.maximumZoomScale   = 3.0;
    }else {
        cell.userInteractionEnabled = NO;
    }
    
    if (self.setupImageViewContent) {
        self.setupImageViewContent(cell.imageView, index);
    }
    
    return cell;
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
    if (self.clickImageCallback) {
        
        CGImageView *cell = (id)[cycleScrollView cycleScrollViewCellWithIndex:index];
        if ([cell isKindOfClass:[CGImageView class]]) {
            self.clickImageCallback(index, cell.imageView);
        }
    }
}

- (void)reloadDataDidFinishWithCycleScrollView:(CGCycleScrollView *)cycleScrollView
{
    if (self.reloadDataDidFinishCallback) {
        self.reloadDataDidFinishCallback();
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
    if (!_pageControl || _pageControl.hidden || !_pageControl.superview) {
        return;
    }
    
    if (self.setupPageControlFrame) {
        
        CGRect frame = self.setupPageControlFrame(self.frame, self.pageControl);
        if (!CGRectEqualToRect(frame, self.pageControl.frame)) {
            self.pageControl.frame = frame;
        }
    }else {
        
        if (self.pageControlVerticalSpace < CGZeroFloatValue) {
            if (CGRectEqualToRect(self.pageControl.frame, CGRectZero) && self.pageControl.numberOfPages) {
                [self.pageControl sizeToFit];
            }
            
            CGPoint origin = CGPointMake((self.width - self.pageControl.width) / 2, 0);
            if (self.positionForPageControl == CGCycleBrowseImageViewPageControlPositionBottom) {
                origin = CGPointMake(0, self.height - self.pageControl.height);
            }
            
            if (!CGPointEqualToPoint(origin, self.pageControl.origin)) {
                self.pageControl.origin = origin;
            }
        }else {
            
            CGSize  size;
            size    = CGSizeMake(MIN(self.pageControl.numberOfPages * 16 + 9, self.width), 20);
            
            CGFloat originY = 0;
            if (self.positionForPageControl == CGCycleBrowseImageViewPageControlPositionTop) {
                originY = self.pageControlVerticalSpace;
            }else if (self.positionForPageControl == CGCycleBrowseImageViewPageControlPositionBottom) {
                originY = self.height - self.pageControl.height;
            }
            
            CGPoint origin = CGPointMake((self.width - self.pageControl.width) / 2.0, originY);
            self.pageControl.frame  = (CGRect){origin, size};
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
    _pageControl.hidesForSinglePage = YES;
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

- (void)setDataSource:(NSArray<NSString *> *)dataSource
{
    [self setupDataSourceWithObject:dataSource extractBlock:nil];
}

- (void)setEnableSingleImageCycleScroll:(BOOL)enableSingleImageCycleScroll
{
    if (_enableSingleImageCycleScroll != enableSingleImageCycleScroll) {
        
        _enableSingleImageCycleScroll   = enableSingleImageCycleScroll;
        [self setupCycleScroll];
    }
}

- (BOOL)enableSingleImageCycleScroll
{
    if (self.dataSource.count == 1 && self.cycleScrollView.isCycle == YES) {
        return NO;
    }
    return _enableSingleImageCycleScroll;
}

- (void)setupCycleScroll
{
    if (self.dataSource.count <= 1 && !self.enableSingleImageCycleScroll) {
        self.cycleScrollView.isCycle    = NO;
    }
}

@end

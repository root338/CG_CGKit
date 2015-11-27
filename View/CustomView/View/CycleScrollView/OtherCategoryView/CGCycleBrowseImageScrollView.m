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
#import "UIImageView+CGSetupImageURL.h"
#import "NSArray+CGArray.h"


@interface CGCycleBrowseImageScrollView ()<CGCycleScrollViewDataSource, CGCycleScrollViewDelegate>

@property (strong, nonatomic) CGCycleScrollView *cycleScrollView;

@property (strong, nonatomic, readwrite) UIPageControl *pageControl;
@end

@implementation CGCycleBrowseImageScrollView

+ (instancetype)createCycleBrowseImageScrollViewWithImages:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock
{
    CGCycleBrowseImageScrollView *browseImageView = [[self alloc] init];
    
    [browseImageView setupDataSourceWithObject:dataSource extractBlock:extractBlock];
    
    return browseImageView;
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
    }else {
        [self cycleScrollView];
        [self addSubview:self.cycleScrollView];
        self.cycleScrollView.frame = self.bounds;
    }
    
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
            
        [self setupPageControlFrame];
    }
}

#pragma mark - CGCycleScrollViewDataSource
- (NSInteger)numberCycleScrollView:(CGCycleScrollView *)cycleScrollView
{
    return self.dataSource.count;
}

- (UIView *)cycleScrollView:(CGCycleScrollView *)cycleScrollView viewAtIndex:(NSInteger)index
{
    UIImageView *imageView = [UIImageView cg_createImageViewWithContentMode:UIViewContentModeScaleAspectFit];
    [imageView cg_setupImageWithPath:[self.dataSource cg_objectAtIndex:index]];
    return imageView;
}

#pragma mark - CGCycleScrollViewDelegate
- (void)cycleScrollView:(CGCycleScrollView *)cycleScrollView didChangeCurrentIndex:(NSInteger)currentIndex
{
    if (self.pageControl.currentPage != currentIndex) {
        
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
    _cycleScrollView.frame = self.bounds;
    [self setupPageControlFrame];
}

- (void)setupPageControlFrame
{
    if (!_pageControl) {
        return;
    }
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
@end

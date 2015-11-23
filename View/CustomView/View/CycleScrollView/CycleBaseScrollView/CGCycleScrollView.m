//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"
#import "CGCycleContentView.h"

//创建视图
#import "UIScrollView+CGCreate.h"

//设置属性
#import "NSTimer+ChangeTimerStatus.h"
#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"

/**
 *  子视图的类型
 */
typedef NS_ENUM(NSInteger, _CGCycleSubviewType) {
    /**
     *  上一视图
     */
    _CGCycleSubviewTypePreviousIndex = -1,
    /**
     *  当前视图
     */
    _CGCycleSubviewTypeCurrentIndex,
    /**
     *  下一视图
     */
    _CGCycleSubviewTypeNextIndex,
};

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///当前总的加载数
    NSInteger _totalViews;
    
    CGCycleContentView *_previousView;
    CGCycleContentView *_currentView;
    CGCycleContentView *_nextView;
}

///加载的滑动视图
@property (nonatomic, strong) UIScrollView *cycleScrollView;

///计时器
@property (strong, nonatomic) NSTimer *autoScrollTimer;

/** 被缓存的视图 */
@property (strong, nonatomic) NSMutableDictionary *cacheViews;
@end

@implementation CGCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame delayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (delayTimeInterval > 0) {
            _isAutoScrollView = YES;
            _delayTimeInterval = delayTimeInterval;
        }
        
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialization];
}

- (void)initialization
{
    if (!self.cycleScrollView.superview) {
        [self addSubview:self.cycleScrollView];
    }
}

- (void)handleAutoScrollViewTimer:(NSTimer *)paramTimer
{
    
}

#pragma mark
///更新视图
- (void)reloadAllView
{
    
    [self setupTotalNumberWithForced:YES];
    [self removeAllCacheViews];
    [self setupScrollContentView];
}

- (void)removeAllCacheViews
{
    [self.cacheViews removeAllObjects];
}

///设置滑动视图总数量(isForced是否强制获取，即不使用历史数据)
- (void)setupTotalNumberWithForced:(BOOL)isForced
{
    if (isForced) {
        _totalViews = 0;
    }
    
    if (!_totalViews) {
        _totalViews = [self.dataSource numberCycleScrollView:self];
        self.isCycle ?: [self updateScrollViewContentSize];
    }
}

/** 获取缓存的视图 */
- (CGCycleContentView *)cycleContentViewAtIndex:(NSInteger)index
{
    
    return [self.cacheViews objectForKey:@(index)];
}

/** 保存创建的视图 */
- (void)saveCycleContentView:(CGCycleContentView *)paramCycleContentView
{
    
    if (self.maxCacheCountForViews > 0 && self.isCacheViews) {
        
        CGDebugAssert([paramCycleContentView isKindOfClass:[CGCycleContentView class]], @"若使用缓存功能必须使用CGCycleContentView类或其子类来创建滑动内容视图");
        
        if (!self.cacheViews) {
            self.cacheViews = [NSMutableDictionary dictionaryWithCapacity:self.maxCacheCountForViews];
        }
        
        if (paramCycleContentView) {
            
            if ([self cycleContentViewAtIndex:paramCycleContentView.viewIndex]) {
                //当缓存的视图已存在
                return;
            }
            
            if (self.maxCacheCountForViews > self.cacheViews.count) {
                //当缓存还有空余时
                [self.cacheViews setObject:paramCycleContentView forKey:@(paramCycleContentView.viewIndex)];
            }else {
                
                __block NSInteger removeViewIndex;
                if (self.cacheViews.count > 3) {
                    //当缓存的视图数大于显示的视图数
                    NSArray *indexsArr = self.cacheViews.allValues;
                    [indexsArr enumerateObjectsUsingBlock:^(CGCycleContentView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj isKindOfClass:[CGCycleContentView class]]) {
                            
                            NSInteger viewIndex = obj.viewIndex;
                            if (viewIndex != _previousView.viewIndex && viewIndex != _currentView.viewIndex && viewIndex != _nextView.viewIndex) {
                                //查找不是当前加载的视图索引
                                removeViewIndex = viewIndex;
                                *stop = YES;
                            }
                        }
                        
                    }];
                }else {
                    //当缓存的视图小于或等于显示的视图数时
                    
                    if ([self cycleContentViewAtIndex:_previousView.viewIndex]) {
                        removeViewIndex = _previousView.viewIndex;
                    }else if ([self cycleContentViewAtIndex:_nextView.viewIndex]) {
                        removeViewIndex = _nextView.viewIndex;
                    }else if ([self cycleContentViewAtIndex:_currentView.viewIndex]) {
                        removeViewIndex = _currentView.viewIndex;
                    }
                }
                
                //移除已缓存视图
                [self.cacheViews removeObjectForKey:@(removeViewIndex)];
                
                //添加新视图
                [self.cacheViews setObject:paramCycleContentView forKey:@(paramCycleContentView.viewIndex)];
            }
            
        }
    }
}

/** 创建单个滑动视图 */
- (CGCycleContentView *)createCycleContentViewAtIndex:(NSInteger)index
{
    CGCycleContentView *contentView = [self cycleContentViewAtIndex:index];
    if (!contentView) {
        
        UIView *view = [self.dataSource cycleScrollView:self viewAtIndex:index];
        
        CGDebugAssert(view, @"显示的视图为nil，允许的话就注释这句代码吧-_-");
        
        contentView = [CGCycleContentView cg_createCycleContentViewWithContentView:view index:index];
        [self saveCycleContentView:contentView];
    }
    
    return contentView;
}

/** 获取相应索引 */
- (NSInteger)getViewIndexForType:(_CGCycleSubviewType)subviewType
{
    //更新当前显示索引
    if (self.currentIndex >= _totalViews) {
        
        self.currentIndex = _totalViews - 1;
        CGLog(@"初始加载的视图索引大于总数(%li)，自动重置为 %li", _totalViews, self.currentIndex);
    }
    
    if (self.currentIndex < 0) {
        self.currentIndex = 0;
        CGLog(@"初始加载的视图索引小于0，自动重置为 %li", self.currentIndex);
    }
    
    //更新当前显示索引前后索引
    NSInteger viewIndex = self.currentIndex + subviewType;
    
    if (viewIndex < 0) {
        viewIndex = _totalViews - 1;
    }
    
    if (viewIndex >= _totalViews) {
        viewIndex = 0;
    }
    
    return viewIndex;
}

#pragma mark - 更新布局

///更新滑动视图的大小
- (void)updateScrollViewContentSize
{
    CGSize scrollViewContentSize = CGSizeZero;
    scrollViewContentSize.height = self.height;
    
    CGFloat maxWidth = self.cycleScrollView.width;
    if (self.isCycle) {
        scrollViewContentSize.width = maxWidth * 3;
    }else {
        scrollViewContentSize.width = MIN(_totalViews, 3) * maxWidth;
    }
    
    self.cycleScrollView.contentSize = scrollViewContentSize;
}

///更新显示视图的显示区域
- (void)updateCycleScrollViewLayoutSubviews
{
    if (_previousView && !_previousView.superview) {
        [self.cycleScrollView addSubview:_previousView];
    }
    if (_currentView && !_currentView.superview) {
        [self.cycleScrollView addSubview:_currentView];
    }
    if (_nextView && !_nextView.superview) {
        [self.cycleScrollView addSubview:_nextView];
    }
    NSArray *cycleScrollViewSubviews = self.cycleScrollView.subviews;
    
    [cycleScrollViewSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CGCycleContentView class]]) {
            if (_previousView != obj && _currentView != obj && _nextView != obj) {
                //当显示的视图不是CGCycleContentView类型且不等显示的视图时移除多余视图
                [obj removeFromSuperview];
            }
        }
    }];
    
    CGSize scrollViewSize       = self.cycleScrollView.size;
    
    CGRect previousViewFrame    = CGRectMake(0, 0, _previousView ? scrollViewSize.width : 0, scrollViewSize.height);
    CGRect currentViewFrame     = CGRectMake(CGRectGetMaxX(previousViewFrame), 0, scrollViewSize.width, scrollViewSize.height);
    CGRect nextViewFrame        = CGRectMake(CGRectGetMaxX(currentViewFrame), 0, _nextView ? scrollViewSize.width : 0, scrollViewSize.height);
    
    _previousView.frame         = previousViewFrame;
    _currentView.frame          = currentViewFrame;
    _nextView.frame             = nextViewFrame;
    
    [self.cycleScrollView setContentOffset:CGPointMake(CGRectGetMinX(currentViewFrame), 0)];
    
    if (!self.isCycle) {
        self.cycleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(nextViewFrame), 0);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cycleScrollView.frame = CGRectWithMargin(self.bounds, self.marginEdgeInsetForScrollView);
    
    [self updateScrollViewContentSize];
    [self updateCycleScrollViewLayoutSubviews];
}

///设置滑动内容视图
- (void)setupScrollContentView
{
    [self setupTotalNumberWithForced:NO];
    
    NSInteger previousIndex = [self getViewIndexForType:_CGCycleSubviewTypePreviousIndex];
    NSInteger currentIndex  = [self getViewIndexForType:_CGCycleSubviewTypeCurrentIndex];
    NSInteger nextIndex     = [self getViewIndexForType:_CGCycleSubviewTypeNextIndex];
    
    //重置视图
    _previousView   = nil;
    _currentView    = nil;
    _nextView       = nil;
    
    if (!(!self.isCycle && previousIndex >= currentIndex)) {
        //当不满足不循环滑动且上一视图的索引比当前视图索引不小于时执行
        _previousView           = [self createCycleContentViewAtIndex:previousIndex];
    }
    
    _currentView            = [self createCycleContentViewAtIndex:currentIndex];
    
    
    if (!(!self.isCycle && nextIndex <= currentIndex)) {
        //当不满足不循环滑动且下一视图的索引比当前视图索引不大于时执行
        _nextView               = [self createCycleContentViewAtIndex:nextIndex];
    }
    
    [self updateCycleScrollViewLayoutSubviews];
}

/** 是否应该更新滑动视图，paramNextIndex为是否翻下一页 */
- (BOOL)isShouldUpdateContentViewWithNextIndex:(BOOL)paramNextIndex
{
    BOOL isShouldUpdateContentView = YES;
    if (self.isCycle) {
        
        isShouldUpdateContentView = YES;
    }else {
        
        //当不需要循环滑动时
        
        if (paramNextIndex) {
            if (self.currentIndex >= _totalViews - 2) {
                //当翻下一页时，当前显示视图索引大于等于 (_totalViews - 2) 时
                isShouldUpdateContentView = NO;
            }
        }else {
            if (self.currentIndex <= 1) {
                //当翻上一页时，当前显示视图索引小于等于 1 时
                isShouldUpdateContentView = NO;
            }
        }
    }
    
    return isShouldUpdateContentView;
}

///滑动到下一视图
- (void)scrollToNextView
{
//    if ([self isShouldUpdateContentViewWithNextIndex:YES]) {
        self.currentIndex++;
        [self setupScrollContentView];
//    }
}

//滑动到上一视图
- (void)scrollToPreviousView
{
//    if ([self isShouldUpdateContentViewWithNextIndex:NO]) {
        self.currentIndex--;
        [self setupScrollContentView];
//    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX <= 0 && !(!self.isCycle && self.currentIndex == 0)) {
        
        [self scrollToPreviousView];
    }
    
    if (offsetX >= scrollView.width * 2 && !(!self.isCycle && self.currentIndex == _totalViews - 1)) {
        [self scrollToNextView];
    }
}

#pragma mark - 属性设置
- (void)setDataSource:(id<CGCycleScrollViewDataSource>)dataSource
{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        [self performSelector:@selector(reloadAllView) withObject:nil afterDelay:0];
    }
}

- (void)setIsCycle:(BOOL)isCycle
{
    if (_isCycle != isCycle) {
        
        _isCycle = isCycle;
        [self updateScrollViewContentSize];
    }
}

- (void)setIsCacheViews:(BOOL)isCacheViews
{
    if (_isCacheViews != isCacheViews) {
        _isCacheViews = isCacheViews;
        if (_maxCacheCountForViews == 0) {
            _maxCacheCountForViews = 5;
        }
        isCacheViews ?: [self removeAllCacheViews];
    }
}

- (UIScrollView *)cycleScrollView
{
    if (_cycleScrollView) {
        return _cycleScrollView;
    }
    
    _cycleScrollView = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:YES];
    _cycleScrollView.delegate = self;
    return _cycleScrollView;
}
@end

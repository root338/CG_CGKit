//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

#import "CGScrollView.h"
#import "CGCycleScrollViewCellManager.h"

//创建视图
#import "UIScrollView+CGCreate.h"

//设置属性
#import "UIView+CGCreate.h"
#import "UIView+CGSetupFrame.h"
#import "UIScrollView+CGProperty.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"
#import "NSArray+CGArray.h"
#import "NSTimer+ChangeTimerStatus.h"

//功能相关扩展
#import "CGCycleScrollView+CGBuildView.h"
#import "CGCycleScrollView+CGScrollAnimation.h"

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///计时器
    NSTimer *autoScrollTimer;
}

///加载的滑动视图
@property (nonatomic, strong, readwrite) UIScrollView *cycleScrollView;
/** 添加到视图的索引集合 */
@property (nonatomic, strong) NSMutableArray *addToViewIndexArray;
@end

@implementation CGCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame delayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (delayTimeInterval > 0) {
            
            _delayTimeInterval  = delayTimeInterval;
            _isAutoScrollView   = YES;
        }
        
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _isCycle = YES;
    if (![self cycleScrollView].superview) {
        [self addSubview:_cycleScrollView];
    }
}

#pragma mark - 计时器
- (void)scrollingHandleTimer
{
    if (autoScrollTimer) {
        [self startAutoScroll];
    }
}

- (void)startAutoScroll
{
    
    if (self.isAutoScrollView && self.delayTimeInterval > 0 && self.isCycle) {
        
        if (!autoScrollTimer) {
            autoScrollTimer = [NSTimer timerWithTimeInterval:self.delayTimeInterval target:self selector:@selector(handleAutoScroll:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:autoScrollTimer forMode:NSDefaultRunLoopMode];
        }
        CGInfoLog(@"启动计时器");
        [autoScrollTimer resumeTimerAfterTimeInterval:self.delayTimeInterval];
    }
}

- (void)pasueAutoScroll
{
    if (autoScrollTimer) {
        
        CGInfoLog(@"暂停计时器");
        [autoScrollTimer pauseTimer];
    }
}

- (void)stopAutoScroll
{
    if (autoScrollTimer) {
        
        CGInfoLog(@"停止计时器");
        [autoScrollTimer stopTimer];
        autoScrollTimer = nil;
    }
}

- (void)handleAutoScroll:(NSTimer *)paramTimer
{
    
    CGPoint contentOffset;
    if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        contentOffset = CGPointMake((self.cycleScrollView.width + self.subviewSpace) * 2, 0);
    }else {
        contentOffset = CGPointMake(0, (self.cycleScrollView.height + self.subviewSpace) * 2);
    }
    
    [self.cycleScrollView setContentOffset:contentOffset animated:YES];
}

#pragma mark
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    [self setupTimerWithWindows:newWindow];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (!self.isCloseDefaultTimerSetting && !newSuperview) {
        
        [self stopAutoScroll];
    }
}

- (void)setupTimerWithWindows:(UIWindow *)newWindow
{
    if (!self.isCloseDefaultTimerSetting) {
        
        if (newWindow) {
            
            [self startAutoScroll];
        }else {
            
            [self pasueAutoScroll];
        }
    }
}

#pragma mark
///更新视图
- (void)reloadAllView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reloadAllView) object:nil];
    
    [self setupTotalNumberWithForced:YES];
    [self setupScrollContentView];
    [self reloadPageView];
    
    [self cg_scrollWithScrollView:self.cycleScrollView animationStyle:self.animationStyle];
}

- (void)reloadPageView
{
    if ([self.dataSource respondsToSelector:@selector(cycleScrollViewAddPageView:)]) {
        
        UIView *pageView = [self.dataSource cycleScrollViewAddPageView:self];
        
        if (_pageContentView) {
            [self.pageContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        
        if (!pageView) {
            
            if (_pageContentView.superview) {
                [_pageContentView removeFromSuperview];
                _pageContentView = nil;
            }
            //没有设置分页视图，且分页视图容器也为空时
            return;
        }
        
        [self.pageContentView addSubview:pageView];
        self.pageContentView.frame = self.bounds;
        if (!self.pageContentView.superview) {
            [self addSubview:self.pageContentView];
        }
    }
}

#pragma mark - 系统视图设置
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    //将分页视图提取到最前面
    if (_pageContentView.superview && [self.subviews lastObject] != _pageContentView) {
        [self bringSubviewToFront:_pageContentView];
    }
}

#pragma mark - 添加子视图
/** 设置需要添加的索引 */
- (void)setupNeedAddViewIndex
{
    if (!self.addToViewIndexArray) {
        self.addToViewIndexArray    = [NSMutableArray array];
    }
    
    CGRect scrollVisibleRect    = self.cycleScrollView.scrollVisibleRect;
    
}

- (void)setupScrollContentView
{
    CGRect scrollVisibleRect    = self.cycleScrollView.scrollVisibleRect;
    
}

#pragma mark - 更新布局
- (void)setupScrollViewConentSize:(CGSize)paramContentSize
{
    if (!CGSizeEqualToSize(paramContentSize, self.cycleScrollView.contentSize)) {
        
        self.cycleScrollView.contentSize = paramContentSize;
    }
}

///更新滑动视图的大小
- (void)updateScrollViewContentSize
{
    if (self.isCycle) {
        
        //循环滑动下滑动区域始终为 maxWidth * 3 或 maxHeight * 3
        CGSize scrollViewContentSize = CGSizeZero;
        scrollViewContentSize = self.size;
        
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            
            CGFloat maxWidth                = self.cycleScrollView.width;
            scrollViewContentSize.width     = (maxWidth + self.subviewSpace) * 3;
        }else {
            
            CGFloat maxHeight               = self.cycleScrollView.height;
            scrollViewContentSize.height    = (maxHeight + self.subviewSpace) * 3;
        }
        
        [self setupScrollViewConentSize:scrollViewContentSize];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cycleScrollView.frame  = CG_CGRectWithMargin(self.bounds, self.marginEdgeInsetForScrollView);
    _pageContentView.frame      = self.bounds;
    
    [self updateScrollViewContentSize];
    [self updateCycleScrollViewLayoutSubviews];
    
}

///滑动到下一视图
- (void)scrollToNextView
{
    NSNumber *nextIndex = [self getViewIndexWithCurrentIndex:self.currentIndex + 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //下一个当前索引是否存在
    if (nextIndex) {
        
        self.currentIndex = nextIndex.integerValue;
    }
}

//滑动到上一视图
- (void)scrollToPreviousView
{
    NSNumber *previousIndex = [self getViewIndexWithCurrentIndex:self.currentIndex - 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //上一个当前索引是否存在
    if (previousIndex) {
        
        self.currentIndex = previousIndex.integerValue;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isDraggerPauseTimerMark     = YES;
    isDraggerScrollSubviewMark  = YES;
    
    [self pasueAutoScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (isDraggerPauseTimerMark) {
        [self scrollingHandleTimer];
        isDraggerPauseTimerMark = NO;
    }
    
    [self scrollView:scrollView isMinUpdateContentMark:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isDraggerScrollSubviewMark  = NO;
    if (!decelerate) {
        //手指离开没有减速效果时
        [self scrollingHandleTimer];
        isDraggerPauseTimerMark         = NO;
    }
}

/** 分页时重置滑动停止坐标 */
- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat     pageSize;
    NSInteger   page;
    CGFloat     targetSpace;
    CGPoint     targetOffset;
    
    if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        
        pageSize = self.cycleScrollView.width + self.subviewSpace;
        page = roundf(offset.x / pageSize);
        targetSpace = pageSize * page;
        targetOffset    = CGPointMake(targetSpace, offset.y);
    }else {
        
        pageSize = self.cycleScrollView.height + self.subviewSpace;
        page = roundf(offset.y / pageSize);
        targetSpace = pageSize * page;
        targetOffset    = CGPointMake(offset.x, targetSpace);
    }
    
    CGInfoLog(@"重置滑动停止坐标：%@, page:%li, 原停止坐标：%@",NSStringFromCGPoint(targetOffset), page, NSStringFromCGPoint(offset));
    return targetOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.pagingEnabled) {
        CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
        targetContentOffset->x = targetOffset.x;
        targetContentOffset->y = targetOffset.y;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self scrollView:scrollView isMinUpdateContentMark:isDraggerScrollSubviewMark];
    
    [self cg_scrollWithScrollView:scrollView
                   animationStyle:self.animationStyle];
}

- (void)scrollView:(UIScrollView *)scrollView isMinUpdateContentMark:(BOOL)isUpdateContentMark
{
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat paramSubviewSpace   = self.subviewSpace;
    //是否刷新上一页标识
    BOOL isUpdatePreviousMark   = NO;
    //是否刷新下一页标识
    BOOL isUpdateNextMark       = NO;
    
    if (self.isCycle) {
        //循环滑动下
        
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            
            isUpdatePreviousMark    = (offset.x <= 0);
            isUpdateNextMark        = (offset.x >= (NSInteger)(scrollView.width + paramSubviewSpace) * 2);
        }else {
            
            isUpdatePreviousMark    = (offset.y <= 0);
            isUpdateNextMark        = (offset.y >= (NSInteger)(scrollView.height + paramSubviewSpace) * 2);
        }
        
    }else {
        
        //不循环滑动情况下需要满足的条件
        BOOL isMaxIndex             = NO;
        BOOL isMinIndex             = NO;
        BOOL isShouldUpdateNextView = NO;
        
        //不循环滑动时，当滑动到最大索引处时不刷新 （YES不刷新）
        isMaxIndex              = self.currentIndex >= _totalViews - 1;
        //不循环滑动时，当滑动到最小索引处时不刷新 （YES不刷新）
        isMinIndex              = self.currentIndex <= 0;
        
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            //当当前视图x坐标为0，但滑动视图偏移量为一个视图宽度时执行刷新 （YES 刷新）
            isShouldUpdateNextView  = (_currentView.xOrigin == 0 && offset.x >= (scrollView.width + paramSubviewSpace));
            
            isUpdatePreviousMark    = (offset.x <= 0) && !isMinIndex;
            
            isUpdateNextMark        = (((offset.x >= (NSInteger)(scrollView.width * 2 + paramSubviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
        }else {
            
            //当当前视图y坐标为0，但滑动视图偏移量为一个视图高度时执行刷新 （YES 刷新）
            isShouldUpdateNextView  = (_currentView.yOrigin == 0 && offset.y >= (scrollView.height + paramSubviewSpace));
            
            isUpdatePreviousMark    = (offset.y <= 0) && !isMinIndex;
            
            isUpdateNextMark        = (((offset.y >= (NSInteger)(scrollView.height * 2 + paramSubviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
        }
        
    }
    
    {
        //与是否循环滑动无关的条件
        //是否可以刷新
        BOOL isShouldUpdate = ((isUpdateContentMark && self.pagingEnabled) || !isDraggerPauseTimerMark || !self.pagingEnabled);
        
        isUpdatePreviousMark    = (isUpdatePreviousMark && isShouldUpdate);
        isUpdateNextMark        = (isUpdateNextMark && isShouldUpdate);
    }
    
    if (isUpdatePreviousMark) {
        
        [self scrollToPreviousView];
        CGInfoLog(@"刷新上一页");
    }
    
    if (isUpdateNextMark) {
        [self scrollToNextView];
        CGInfoLog(@"刷新下一页");
    }
}

- (void)dealloc
{
    CGLog(@"已释放");
}

#pragma mark - 属性内部方法
- (void)setupAutoScrollTimer
{
    if (self.isAutoScrollView) {
        [self stopAutoScroll];
        [self setupTimerWithWindows:self.window];
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

- (void)setIsAutoScrollView:(BOOL)isAutoScrollView
{
    if (isAutoScrollView != _isAutoScrollView) {
        
        _isAutoScrollView = isAutoScrollView;
        if (!self.delayTimeInterval) {
            self.delayTimeInterval = 2;
        }else {
            [self setupAutoScrollTimer];
        }
    }
}

- (void)setDelayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    if (delayTimeInterval <= 0) {
        CGErrorConditionLog(delayTimeInterval <= 0, @"自动滑动的时间不应小于0");
        return;
    }
    if (_delayTimeInterval != delayTimeInterval) {
        
        _delayTimeInterval  = delayTimeInterval;
        
        [self setupAutoScrollTimer];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex != _currentIndex) {
        _currentIndex = currentIndex;
        
        [self setupScrollContentView];
        if ([self.delegate respondsToSelector:@selector(cycleScrollView:didChangeCurrentIndex:)]) {
            [self.delegate cycleScrollView:self didChangeCurrentIndex:self.currentIndex];
        }
    }
}

- (NSInteger)totalViewNumber
{
    return _totalViews;
}

- (UIScrollView *)cycleScrollView
{
    if (_cycleScrollView) {
        return _cycleScrollView;
    }
    
    _cycleScrollView = [CGScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:NO];
    _cycleScrollView.delegate = self;
    return _cycleScrollView;
}

- (void)setClipsToBounds:(BOOL)clipsToBounds
{
    [super setClipsToBounds:clipsToBounds];
    self.cycleScrollView.clipsToBounds  = clipsToBounds;
}

//- (void)setEnableScrollDirectionMonitor:(BOOL)enableScrollDirectionMonitor
//{
//    _enableScrollDirectionMonitor   = enableScrollDirectionMonitor;
//    self.cycleScrollView.enableScrollDirectionMonitor   = enableScrollDirectionMonitor;
//}
//
//- (CGScrollDirectionType)scrollDirectionType
//{
//    return self.cycleScrollView.scrollDirectionType;
//}
@end

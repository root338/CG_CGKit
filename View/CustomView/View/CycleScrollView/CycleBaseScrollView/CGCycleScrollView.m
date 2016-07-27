//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

#import "CGScrollView.h"
#import "CGCycleScrollViewCell.h"
#import "CGCycleScrollViewCellManager.h"

//创建视图
#import "CGCycleCellConfigModel.h"
#import "UIScrollView+CGCreate.h"

//设置属性
#import "UIView+CGCreate.h"
#import "UIView+CGSetupFrame.h"
#import "UIScrollView+CGProperty.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIView+CGAddConstraints.h"

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

@property (nonatomic, strong) CGCycleScrollViewCellManager *cellManager;
/** 加载cell的配置集合 */
@property (nonatomic, strong) NSMutableArray<CGCycleCellConfigModel *> *cellsConfigArray;
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
    
    _cellLength         = 0;
    _currentIndex       = 0;
    _cellbetweenSpace   = 0;
//    _cellPosition       = CGCycleCellPositionNone;
    
    _cycleScrollView = [CGScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:NO];
    _cycleScrollView.delegate = self;
    [self addSubview:_cycleScrollView];
    [_cycleScrollView cg_autoEdgesInsetsZeroToSuperview];
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
//    if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
//        contentOffset = CGPointMake((self.cycleScrollView.width + self.subviewSpace) * 2, 0);
//    }else {
//        contentOffset = CGPointMake(0, (self.cycleScrollView.height + self.subviewSpace) * 2);
//    }
    
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
    
    [self setupScrollContentView];
    
    [self cg_scrollWithScrollView:self.cycleScrollView animationStyle:self.animationStyle];
}

#pragma mark - 系统视图设置

#pragma mark - 添加子视图
/** 设置需要添加的索引 */
- (void)setupNeedAddViewIndex
{
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        [self.cellsConfigArray removeAllObjects];
        return;
    }
    if (!self.cellsConfigArray) {
        self.cellsConfigArray   = [NSMutableArray array];
    }
    
    NSInteger totalIndex        = [self.dataSource numberCycleScrollView:self];
    
    if (totalIndex <= 0) {
        return;
    }
    CGRect scrollVisibleRect    = self.cycleScrollView.scrollVisibleRect;
    
    NSInteger firstIndex        = self.currentIndex;
    
    CGPoint cellPoint           = CGPointZero;
    CGSize  cellSize            = CGSizeZero;
    NSInteger loadIndex         = firstIndex;
    if (self.isCycle) {
        loadIndex   -= 1;
        if (loadIndex < 0) {
            loadIndex   = totalIndex - 1;
        }
    }
    
    NSInteger i                 = 0;
    for (;;) {
        
        CGCycleCellConfigModel *config = [self.cellsConfigArray cg_objectAtIndex:i];
        if (config == nil) {
            config  = [[CGCycleCellConfigModel alloc] initWithIndex:firstIndex];
            [self.cellsConfigArray addObject:config];
        }
        
        cellSize  = [self cycleCellFrameAtIndex:loadIndex];
        
        config.index    = loadIndex;
        config.frame    = (CGRect){cellPoint, cellSize};
        
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            
            cellPoint   = CGPointMake(cellPoint.x + cellSize.width, cellPoint.y);
        }else {
            
            cellPoint   = CGPointMake(cellPoint.x, cellSize.height + cellPoint.y);
        }
        i++;
        
        if (!CGRectContainsRect(scrollVisibleRect, config.frame)) {
            
            break;
        }
        
        loadIndex += 1;
        if (self.isCycle) {
            if (loadIndex >= totalIndex) {
                loadIndex   = 0;
            }
        }else {
            if (loadIndex >= totalIndex) {
                break;
            }
        }
    }
    
    if (self.cellsConfigArray.count > i) {
        [self.cellsConfigArray removeObjectsInRange:NSMakeRange(0, self.cellsConfigArray.count - i)];
    }
}

/** 计算指定索引视图的大小 */
- (CGSize)cycleCellFrameAtIndex:(NSInteger)index
{
//    CGPoint point;
    CGSize  size    = CGSizeZero;
    CGFloat length  = 0.0;
//    CGCycleCellPosition cellPosition    = CGCycleCellPositionNone;
    
//    //设置坐标
//    if ([self.delegate respondsToSelector:@selector(cycleScrollView:pointAtIndex:)]) {
//        point   = [self.delegate cycleScrollView:self pointAtIndex:index];
//    }else if ([self.delegate respondsToSelector:@selector(cycleScrollView:postitionAtIndex:)]) {
//        cellPosition    = [self.delegate cycleScrollView:self postitionAtIndex:index];
//    }else {
//        cellPosition    = self.cellPosition;
//    }
    
    //设置大小
//    if ([self.delegate respondsToSelector:@selector(cycleScrollView:sizeAtIndex:)]) {
//        size    = [self.delegate cycleScrollView:self sizeAtIndex:index];
//    }else
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:lenghtAtIndex:)]) {
        length  = [self.delegate cycleScrollView:self lenghtAtIndex:index];
    }else {
        length  = self.cellLength;
    }
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        
        if (length > 0) {
            if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
                size    = CGSizeMake(length, self.height);
            }else if (self.scrollDirection == CGCycleViewScrollDirectionVertical) {
                size    = CGSizeMake(self.width, length);
            }
        }else {
            
            //当size为{0,0}时，设置cell大小等于循环视图大小
            size    = self.size;
        }
    }
    
//    if (CGPointEqualToPoint(point, CGPointZero)) {
//        
//        switch (cellPosition) {
//            case CGCycleCellPositionMiddle:
//                point   = CG_CGCenterOriginWith(self.size, size);
//                break;
//            case CGCycleCellPositionBottom:
//                point   = CGPointMake(0, self.height - size.height);
//                break;
//            default:
//                break;
//        }
//    }
//    
//    return (CGRect){point, size};
    return size;
}

- (void)setupVisibleRectInCells
{
    [self.cycleScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.cellsConfigArray enumerateObjectsUsingBlock:^(CGCycleCellConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.cell    = [self.dataSource cycleScrollView:self cellAtIndex:obj.index];
        obj.cell.frame  = obj.frame;
        [self.cycleScrollView addSubview:obj.cell];
    }];
}

- (void)setupScrollContentView
{
    [self setupNeedAddViewIndex];
    if (self.cellsConfigArray) {
        [self setupVisibleRectInCells];
    }
}

#pragma mark - 更新布局
- (void)setupScrollViewConentSize:(CGSize)paramContentSize
{
    if (!CGSizeEqualToSize(paramContentSize, self.cycleScrollView.contentSize)) {
        
        self.cycleScrollView.contentSize = paramContentSize;
    }
}

///滑动到下一视图
- (void)scrollToNextView
{
    NSNumber *nextIndex = nil;//[self getViewIndexWithCurrentIndex:self.currentIndex + 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //下一个当前索引是否存在
    if (nextIndex) {
        
        self.currentIndex = nextIndex.integerValue;
    }
}

//滑动到上一视图
- (void)scrollToPreviousView
{
    NSNumber *previousIndex = nil;//[self getViewIndexWithCurrentIndex:self.currentIndex - 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //上一个当前索引是否存在
    if (previousIndex) {
        
        self.currentIndex = previousIndex.integerValue;
    }
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    isDraggerPauseTimerMark     = YES;
//    isDraggerScrollSubviewMark  = YES;
//    
//    [self pasueAutoScroll];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (isDraggerPauseTimerMark) {
//        [self scrollingHandleTimer];
//        isDraggerPauseTimerMark = NO;
//    }
//    
//    [self scrollView:scrollView isMinUpdateContentMark:YES];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    isDraggerScrollSubviewMark  = NO;
//    if (!decelerate) {
//        //手指离开没有减速效果时
//        [self scrollingHandleTimer];
//        isDraggerPauseTimerMark         = NO;
//    }
//}
//
///** 分页时重置滑动停止坐标 */
//- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
//{
//    CGFloat     pageSize;
//    NSInteger   page;
//    CGFloat     targetSpace;
//    CGPoint     targetOffset;
//    
//    if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
//        
//        pageSize = self.cycleScrollView.width + self.subviewSpace;
//        page = roundf(offset.x / pageSize);
//        targetSpace = pageSize * page;
//        targetOffset    = CGPointMake(targetSpace, offset.y);
//    }else {
//        
//        pageSize = self.cycleScrollView.height + self.subviewSpace;
//        page = roundf(offset.y / pageSize);
//        targetSpace = pageSize * page;
//        targetOffset    = CGPointMake(offset.x, targetSpace);
//    }
//    
//    CGInfoLog(@"重置滑动停止坐标：%@, page:%li, 原停止坐标：%@",NSStringFromCGPoint(targetOffset), page, NSStringFromCGPoint(offset));
//    return targetOffset;
//}
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if (self.pagingEnabled) {
//        CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
//        targetContentOffset->x = targetOffset.x;
//        targetContentOffset->y = targetOffset.y;
//    }
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    [self scrollView:scrollView isMinUpdateContentMark:isDraggerScrollSubviewMark];
//    
//    [self cg_scrollWithScrollView:scrollView
//                   animationStyle:self.animationStyle];
//}
//
//- (void)scrollView:(UIScrollView *)scrollView isMinUpdateContentMark:(BOOL)isUpdateContentMark
//{
//    CGPoint offset = scrollView.contentOffset;
//    
//    CGFloat paramSubviewSpace   = self.subviewSpace;
//    //是否刷新上一页标识
//    BOOL isUpdatePreviousMark   = NO;
//    //是否刷新下一页标识
//    BOOL isUpdateNextMark       = NO;
//    
//    if (self.isCycle) {
//        //循环滑动下
//        
//        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
//            
//            isUpdatePreviousMark    = (offset.x <= 0);
//            isUpdateNextMark        = (offset.x >= (NSInteger)(scrollView.width + paramSubviewSpace) * 2);
//        }else {
//            
//            isUpdatePreviousMark    = (offset.y <= 0);
//            isUpdateNextMark        = (offset.y >= (NSInteger)(scrollView.height + paramSubviewSpace) * 2);
//        }
//        
//    }else {
//        
//        //不循环滑动情况下需要满足的条件
//        BOOL isMaxIndex             = NO;
//        BOOL isMinIndex             = NO;
//        BOOL isShouldUpdateNextView = NO;
//        
//        //不循环滑动时，当滑动到最大索引处时不刷新 （YES不刷新）
//        isMaxIndex              = self.currentIndex >= _totalViews - 1;
//        //不循环滑动时，当滑动到最小索引处时不刷新 （YES不刷新）
//        isMinIndex              = self.currentIndex <= 0;
//        
//        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
//            //当当前视图x坐标为0，但滑动视图偏移量为一个视图宽度时执行刷新 （YES 刷新）
//            isShouldUpdateNextView  = (_currentView.xOrigin == 0 && offset.x >= (scrollView.width + paramSubviewSpace));
//            
//            isUpdatePreviousMark    = (offset.x <= 0) && !isMinIndex;
//            
//            isUpdateNextMark        = (((offset.x >= (NSInteger)(scrollView.width * 2 + paramSubviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
//        }else {
//            
//            //当当前视图y坐标为0，但滑动视图偏移量为一个视图高度时执行刷新 （YES 刷新）
//            isShouldUpdateNextView  = (_currentView.yOrigin == 0 && offset.y >= (scrollView.height + paramSubviewSpace));
//            
//            isUpdatePreviousMark    = (offset.y <= 0) && !isMinIndex;
//            
//            isUpdateNextMark        = (((offset.y >= (NSInteger)(scrollView.height * 2 + paramSubviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
//        }
//        
//    }
//    
//    {
//        //与是否循环滑动无关的条件
//        //是否可以刷新
//        BOOL isShouldUpdate = ((isUpdateContentMark && self.pagingEnabled) || !isDraggerPauseTimerMark || !self.pagingEnabled);
//        
//        isUpdatePreviousMark    = (isUpdatePreviousMark && isShouldUpdate);
//        isUpdateNextMark        = (isUpdateNextMark && isShouldUpdate);
//    }
//    
//    if (isUpdatePreviousMark) {
//        
//        [self scrollToPreviousView];
//        CGInfoLog(@"刷新上一页");
//    }
//    
//    if (isUpdateNextMark) {
//        [self scrollToNextView];
//        CGInfoLog(@"刷新下一页");
//    }
//}

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

//- (NSInteger)totalViewNumber
//{
//    return _totalViews;
//}

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

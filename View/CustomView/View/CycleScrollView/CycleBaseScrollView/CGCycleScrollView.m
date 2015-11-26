//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

/** CGCycleContentView的子类 */
#import "CGCycleContentView.h"

//创建视图
#import "UIScrollView+CGCreate.h"

//设置属性
#import "NSTimer+ChangeTimerStatus.h"
#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"
#import "NSArray+CGArray.h"
#import "UIView+CGCopyView.h"

//功能相关扩展
#import "CGCycleScrollView+CGCondition.h"
#import "CGCycleScrollView+CGBuildView.h"

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///当前总的加载数
    NSInteger _totalViews;
    
    CGCycleContentView *_previousView;
    CGCycleContentView *_currentView;
    CGCycleContentView *_nextView;
    
    //辅助视图
    CGCycleContentView *_aideView;
    
    ///计时器
    NSTimer *autoScrollTimer;
    
    ///手指拖动滑动时暂停计时器标识
    BOOL isDraggerPauseTimerMark;
    
    /**
     *  手指拖动滑动时的标识
     *  添加标识的原因：再循环滑动的条件下,在代理方法scrollViewWillEndDragging:withVelocity:targetContentOffset:中设置偏移量{0,0}时，由于有反弹效果索引，在代理方法scrollViewDidScroll:到偏移量小于0时就会更新导致偏移量变为滑动视图宽度+视图间距，但是滑动没有停止所以还会继续滑动，导致分页效果出现问题
     */
    BOOL isDraggerScrollSubviewMark;
}

///加载的滑动视图
@property (nonatomic, strong) UIScrollView *cycleScrollView;

/** 被缓存的视图 */
@property (strong, nonatomic) NSMutableDictionary *cacheViews;

@end

@implementation CGCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame delayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (delayTimeInterval > 0) {
            
            self.delayTimeInterval = delayTimeInterval;
            self.isAutoScrollView = YES;
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

#pragma mark - 计时器
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
    
    if (!self.isCloseDefaultTimerSetting) {
        if (newWindow) {
            
            [self startAutoScroll];
            
        }else {
            
            [self pasueAutoScroll];
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (!self.isCloseDefaultTimerSetting && !newSuperview) {
        
        [self stopAutoScroll];
    }
}

#pragma mark
///更新视图
- (void)reloadAllView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reloadAllView) object:nil];
    
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
        !self.isCycle ?: [self updateScrollViewContentSize];
    }
}

#pragma mark - 创建、获取子视图
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
                CGInfoLog(@"添加缓存视图：%@, 视图索引：%li", paramCycleContentView, paramCycleContentView.viewIndex);
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
                
                CGInfoLog(@"移除缓存视图：%@, 视图索引：%li", self.cacheViews[@(removeViewIndex)], removeViewIndex);
                //移除已缓存视图
                [self.cacheViews removeObjectForKey:@(removeViewIndex)];
                
                //添加新视图
                [self.cacheViews setObject:paramCycleContentView forKey:@(paramCycleContentView.viewIndex)];
                CGInfoLog(@"添加缓存视图：%@, 视图索引：%li", paramCycleContentView, paramCycleContentView.viewIndex);
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
    }else {
        
        if (contentView == _currentView || contentView == _previousView || contentView == _aideView) {
            contentView = [contentView copyView];
        }
        //因为_nextView是最后赋值的，所以新视图不会与其相等
        
        CGInfoLog(@"复制视图：%@，视图索引：%li", contentView, contentView.viewIndex);
    }
    
    return contentView;
}

/** 获取相应索引 */
- (NSInteger)getViewIndexForType:(_CGCycleSubviewType)subviewType
{
    //更新当前显示索引
    if (self.currentIndex >= _totalViews || self.currentIndex < 0) {
        
        NSInteger maxIndex = _totalViews - 1;
        NSInteger minIndex = 0;
        
        NSInteger currentIndex;
        
        if (self.currentIndex >= _totalViews) {
            
            if (self.isCycle) {
                
                currentIndex = minIndex;
            }else {
                
                CGLog(@"加载的视图索引大于最大索引数(%li)，你设置为(%li)，自动重置为 %li", maxIndex, self.currentIndex, maxIndex);
                currentIndex = maxIndex;
            }
        }else  {
            
            if (self.isCycle) {
                
                currentIndex = maxIndex;
            }else {
                
                CGLog(@"初始加载的视图索引小于最小索引数(%li)，你设置为(%li)，自动重置为 %li", minIndex, self.currentIndex, minIndex);
                currentIndex = minIndex;
            }
        }
        
        self.currentIndex = currentIndex;
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

- (void)addAideViewToCycleScrollViewWithType:(_CGCycleSubviewType)type
{
    if (_aideView.superview) {
        return;
    }
    BOOL isShouldAdd = NO;
    NSInteger targetIndex = 0;
    NSInteger willCurrentIndex = 0;
    CGCycleContentView *willCurrentCycleContentView = nil;
    
    if (type == _CGCycleSubviewTypePreviousIndex) {
        if (_previousView) {
            willCurrentIndex    = _previousView.viewIndex;
            NSNumber *targetIndexNumber = [self getViewIndexWithCurrentIndex:willCurrentIndex type:type];
            if (targetIndexNumber) {
                targetIndex = targetIndexNumber.integerValue;
            }else {
                return;
            }
            willCurrentCycleContentView = _previousView;
            isShouldAdd = [self isShouldCreatePrevioursViewWithIndex:targetIndex currentIndex:willCurrentIndex];
        }
    }else if (type == _CGCycleSubviewTypeNextIndex) {
        if (_nextView) {
            willCurrentIndex    = _nextView.viewIndex;
            targetIndex         = willCurrentIndex + 1;
            willCurrentCycleContentView = _nextView;
            isShouldAdd = [self isShouldCreateNextViewWithIndex:targetIndex currentIndex:willCurrentIndex];
        }
    }else {
        CGErrorLog(@"加载的子视图类型错误");
    }
    
    if (isShouldAdd) {
        
        _aideView = [self createCycleContentViewAtIndex:targetIndex];
        CGRect frame = willCurrentCycleContentView.frame;
        BOOL isScrollDirectionHorizontal = (self.scrollDirection == CGCycleViewScrollDirectionHorizontal);
        BOOL isNextIndex = (type == _CGCycleSubviewTypeNextIndex);
        
        if (isScrollDirectionHorizontal) {
            CGFloat targetWidthSpace = self.subviewSpace + CGRectGetWidth(frame);
            if (isNextIndex) {
                frame.origin.x += targetWidthSpace;
            }else {
                frame.origin.x -= targetWidthSpace;
            }
        }else {
            
            CGFloat targetHeightSpace = self.subviewSpace + CGRectGetHeight(frame);
            if (isNextIndex) {
                frame.origin.y += targetHeightSpace;
            }else {
                frame.origin.y -= targetHeightSpace;
            }
        }
        
        _aideView.frame = frame;
        [self.cycleScrollView addSubview:_aideView];
        
        CGInfoLog(@"加载辅助视图");
    }
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
                //当显示的视图不是CGCycleContentView类型且不等显示的视图时判定为多余视图，移除!!!
                [obj removeFromSuperview];
            }
        }
    }];
    
    if (_aideView) {
        CGInfoLog(@"移除辅助视图");
        
        if (_aideView.superview) {
            [_aideView removeFromSuperview];
        }
        _aideView = nil;
    }
    
    CGFloat currentViewSpace    = _previousView ? self.subviewSpace : 0;
    
    //只要有数据_currentView就肯定不为空，为了计算scrollView.contentSize不会出现偏差
    CGFloat nextViewSpace       = _nextView ? self.subviewSpace : 0;
    
    CGPoint contentOffset       = CGPointZero;
    CGSize scrollViewSize       = self.cycleScrollView.size;
    CGRect previousViewFrame    = CGRectMake(0, 0, _previousView ? scrollViewSize.width : 0, _previousView ? scrollViewSize.height : 0);
    
    CGRect currentViewFrame     = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height);
    CGRect nextViewFrame        = CGRectMake(0, 0, _nextView ? scrollViewSize.width : 0, _nextView ? scrollViewSize.height : 0);
    
    if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        
        currentViewFrame.origin.x   = CGRectGetMaxX(previousViewFrame) + currentViewSpace;
        nextViewFrame.origin.x      = CGRectGetMaxX(currentViewFrame) + nextViewSpace;
        contentOffset               = CGPointMake(CGRectGetMinX(currentViewFrame), 0);
    }else {
        
        currentViewFrame.origin.y   = CGRectGetMaxY(previousViewFrame) + currentViewSpace;
        nextViewFrame.origin.y      = CGRectGetMaxY(currentViewFrame) + nextViewSpace;
        contentOffset               = CGPointMake(0, CGRectGetMinY(currentViewFrame));
    }
    
    _previousView.frame         = previousViewFrame;
    _currentView.frame          = currentViewFrame;
    _nextView.frame             = nextViewFrame;
    
    [self.cycleScrollView setContentOffset:contentOffset];
    
    CGInfoLog(@"更新视图内容，设置滑动视图偏移量:%@", NSStringFromCGPoint(self.cycleScrollView.contentOffset));
    if (!self.isCycle) {
        
        CGSize contentSize;
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            contentSize = CGSizeMake(CGRectGetMaxX(nextViewFrame), self.cycleScrollView.height);
        }else {
            contentSize = CGSizeMake(self.cycleScrollView.width, CGRectGetMaxY(nextViewFrame));
        }
        [self setupScrollViewConentSize:contentSize];
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
    
    if (_totalViews <= 0) {
        
        CGLog(@"没有任何需要加载的视图");
        return;
    }
    NSInteger previousIndex = [self getViewIndexForType:_CGCycleSubviewTypePreviousIndex];
    NSInteger currentIndex  = [self getViewIndexForType:_CGCycleSubviewTypeCurrentIndex];
    NSInteger nextIndex     = [self getViewIndexForType:_CGCycleSubviewTypeNextIndex];
    
    //重置视图
    _previousView   = nil;
    _currentView    = nil;
    _nextView       = nil;
    
    if ([self isShouldCreatePrevioursViewWithIndex:previousIndex currentIndex:currentIndex]) {
        //当不满足不循环滑动且上一视图的索引比当前视图索引不小于时执行
        _previousView           = [self createCycleContentViewAtIndex:previousIndex];
    }
    
    _currentView            = [self createCycleContentViewAtIndex:currentIndex];
    
    
    if ([self isShouldCreateNextViewWithIndex:nextIndex currentIndex:currentIndex]) {
        //当不满足不循环滑动且下一视图的索引比当前视图索引不大于时执行
        _nextView               = [self createCycleContentViewAtIndex:nextIndex];
    }
    
    [self updateCycleScrollViewLayoutSubviews];
}

///滑动到下一视图
- (void)scrollToNextView
{
    self.currentIndex++;
    [self setupScrollContentView];
}

//滑动到上一视图
- (void)scrollToPreviousView
{
    self.currentIndex--;
    [self setupScrollContentView];
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
        [self startAutoScroll];
        isDraggerPauseTimerMark = NO;
    }
    
    [self scrollView:scrollView isMinUpdateContentMark:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isDraggerScrollSubviewMark  = NO;
    if (!decelerate) {
        //手指离开没有减速效果时
        [self startAutoScroll];
        isDraggerPauseTimerMark = NO;
    }
}

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
}

- (void)scrollView:(UIScrollView *)scrollView isMinUpdateContentMark:(BOOL)isUpdateContentMark
{
    CGPoint offset = scrollView.contentOffset;
    
    //是否刷新上一页标识
    BOOL isUpdatePreviousMark   = NO;
    //是否刷新下一页标识
    BOOL isUpdateNextMark       = NO;
    
    if (self.isCycle) {
        //循环滑动下
        
        if (self.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            
            isUpdatePreviousMark    = (offset.x <= 0);
            isUpdateNextMark        = (offset.x >= (scrollView.width + self.subviewSpace) * 2);
        }else {
            
            isUpdatePreviousMark    = (offset.y <= 0);
            isUpdateNextMark        = (offset.y >= (scrollView.height + self.subviewSpace) * 2);
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
            isShouldUpdateNextView  = (_currentView.xOrigin == 0 && offset.x >= (scrollView.width + self.subviewSpace));
            
            isUpdatePreviousMark    = (offset.x <= 0) && !isMinIndex;
            
            isUpdateNextMark        = (((offset.x >= (scrollView.width * 2 + self.subviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
        }else {
            
            //当当前视图y坐标为0，但滑动视图偏移量为一个视图高度时执行刷新 （YES 刷新）
            isShouldUpdateNextView  = (_currentView.yOrigin == 0 && offset.y >= (scrollView.height + self.subviewSpace));
            
            isUpdatePreviousMark    = (offset.y <= 0) && !isMinIndex;
            
            isUpdateNextMark        = (((offset.y >= (scrollView.height * 2 + self.subviewSpace)) && !isMaxIndex) || isShouldUpdateNextView);
        }
        
    }
    
    {
        //与是否循环滑动无关的条件
        //是否可以刷新
        BOOL isShouldUpdate = ((isUpdateContentMark && self.pagingEnabled) || !self.pagingEnabled);
        
        /**
         *  当应该刷新时，但因为目标滑动问题而停止刷新时，增加辅助视图，来改善页面的显示问题
         *  具体原因看声明isDraggerScrollSubviewMark变量的说明
         */
        
        if (scrollView.decelerating) {
            
            _CGCycleSubviewType type = _CGCycleSubviewTypeCurrentIndex;
            if (isUpdatePreviousMark && !isShouldUpdate) {
                type = _CGCycleSubviewTypePreviousIndex;
            }
            if (isUpdateNextMark && !isShouldUpdate) {
                type = _CGCycleSubviewTypeNextIndex;
            }
            if (type != _CGCycleSubviewTypeCurrentIndex) {
                [self addAideViewToCycleScrollViewWithType:type];
            }
        }
        
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
        }
    }
}

- (UIScrollView *)cycleScrollView
{
    if (_cycleScrollView) {
        return _cycleScrollView;
    }
    
    _cycleScrollView = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:NO];
    _cycleScrollView.delegate = self;
    return _cycleScrollView;
}

- (NSInteger)totalViewNumber
{
    return _totalViews;
}
@end

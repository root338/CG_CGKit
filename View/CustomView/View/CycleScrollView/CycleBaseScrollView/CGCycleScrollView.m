//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

#import "CGScrollView.h"
/** CGCycleContentView的子类 */
#import "CGCycleContentView.h"

//创建视图
#import "UIScrollView+CGCreate.h"

//设置属性
#import "NSTimer+ChangeTimerStatus.h"
#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIView+CGCreate.h"
#import "UIView+CGSearchView.h"

#import "CGPrintLogHeader.h"
#import "NSArray+CGArray.h"

//功能相关扩展
#import "CGCycleScrollView+CGBuildView.h"
#import "CGCycleScrollView+CGScrollAnimation.h"

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///是否刷新过视图
    BOOL didReloadData;
    
    ///当前总的加载数
    NSInteger _totalViews;
    
    CGCycleContentView *_previousView;
    CGCycleContentView *_currentView;
    CGCycleContentView *_nextView;
    
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

/** 滑动视图添加的视图集 */
//@property (nonatomic, strong) NSMutableDictionary *cycleContentViews;

///加载的滑动视图
@property (nonatomic, strong, readwrite) UIScrollView *cycleScrollView;

/** 被缓存的视图 */
@property (strong, nonatomic, readwrite) NSMutableDictionary *cacheViews;

/** 分页视图的容器 */
@property (strong, nonatomic) UIView *pageContentView;

@property (nonatomic, assign, readwrite) NSInteger currentIndex;
@end

@implementation CGCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame delayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (delayTimeInterval > 0) {
            
            _delayTimeInterval  = delayTimeInterval;
            _isAutoScrollView   = YES;
            _scrollEnabled      = YES;
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
    if (contentOffset.x + CGRectGetWidth(self.cycleScrollView.frame) > self.cycleScrollView.contentSize.width) {
        // 防止超出滑动区域
        return;
    }
    [self.cycleScrollView setContentOffset:contentOffset animated:YES];
}

#pragma mark
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    [self setupTimerWithWindows:newWindow];
    if (didReloadData == NO && self.dataSource) {
        [self reloadAllView];
    }
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
    
    didReloadData   = YES;
    [self setupTotalNumberWithForced:YES];
    [self removeAllCacheViews];
    [self setupScrollContentView];
    [self reloadPageView];
    
    [self cg_scrollWithScrollView:self.cycleScrollView animationStyle:self.animationStyle];
    if (!_isCycle && self.cycleScrollView.contentOffset.x + self.cycleScrollView.width > self.cycleScrollView.contentSize.width) {
        [self.cycleScrollView setContentOffset:CGPointZero animated:NO];
    }
    if ([self.delegate respondsToSelector:@selector(reloadDataDidFinishWithCycleScrollView:)]) {
        [self.delegate reloadDataDidFinishWithCycleScrollView:self];
    }
    
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

#pragma mark - 系统视图设置
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    //将分页视图提取到最前面
    if (_pageContentView.superview && [self.subviews lastObject] != _pageContentView) {
        [self bringSubviewToFront:_pageContentView];
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
                
                __block NSInteger removeViewIndex   = 0;
                if (self.cacheViews.count > 3) {
                    //当缓存的视图数大于显示的视图数
                    NSArray *indexsArr = self.cacheViews.allValues;
                    [indexsArr enumerateObjectsUsingBlock:^(CGCycleContentView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj isKindOfClass:[CGCycleContentView class]]) {
                            
                            NSInteger viewIndex = obj.viewIndex;
                            if (viewIndex != self->_previousView.viewIndex && viewIndex != self->_currentView.viewIndex && viewIndex != self->_nextView.viewIndex) {
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
    
    NSMutableArray *didUseViewArr = [NSMutableArray arrayWithCapacity:5];
    [didUseViewArr cg_addObject:_currentView];
    [didUseViewArr cg_addObject:_previousView];
    
    __block BOOL  isDidUseViewMark = NO;
    [didUseViewArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == contentView) {
            //当视图被使用时，添加标识
            isDidUseViewMark = YES;
            *stop   = YES;
        }
    }];
    if (isDidUseViewMark) {
        //视图无法复制，那就重新创建个
        contentView = nil;
    }
    
    if (!contentView) {
        
        UIView *view = [self.dataSource cycleScrollView:self viewAtIndex:index];
        
        CGDebugAssert(view, @"显示的视图为nil，允许的话就注释这句代码吧-_-");
        
        contentView = [CGCycleContentView cg_createCycleContentViewWithContentView:view index:index marginEdgeInsets:self.marginEdgeInsetForSubviews];
        [self saveCycleContentView:contentView];
    }else {
        
        //复制视图暂没有实现
//        
//        CGCycleContentView *newContentView;
//        if (contentView == _currentView || contentView == _previousView || contentView == _aideView) {
//            
//        }
//        //因为_nextView是最后赋值的，所以新视图不会与其相等
//        
//        CGInfoLog(@"复制视图：%@，视图索引：%li  --> 复制后视图：%@", contentView, contentView.viewIndex, newContentView);
//        contentView = newContentView;
    }
    
    return contentView;
}

/** 获取将要将要显示的内容视图 */
- (CGCycleContentView *)getWillShowCycleContentViewWithType:(_CGCycleSubviewType)type
{
    CGCycleContentView *willCurrentCycleContentView = nil;
    if (type == _CGCycleSubviewTypePreviousIndex) {
        
        willCurrentCycleContentView = _previousView;
    }else {
        
        willCurrentCycleContentView = _nextView;
    }
    return willCurrentCycleContentView;
}

- (UIView *)cycleScrollViewCellWithIndex:(NSInteger)index
{
    CGCycleContentView *cell    = nil;
    if (index == _currentView.viewIndex) {
        cell    = _currentView;
    }else if (index == _previousView.viewIndex) {
        cell    = _previousView;
    }else if (index == _nextView.viewIndex) {
        cell    = _nextView;
    }else {
        cell    = [self createCycleContentViewAtIndex:index];
    }
    return cell.contentView;
}

- (NSInteger)indexAtCellSubview:(UIView *)cellSubview {
    CGCycleContentView *cell = [cellSubview searchSuperViewWithClass:[CGCycleContentView class]];
    if (cell == nil) {
        return -1;
    }
    return cell.viewIndex;
}

- (void)scrollToIndex:(NSInteger)index
{
    if (_currentView.viewIndex == index) {
        return;
    }
    
    self.currentIndex   = index;
    [self reloadAllView];
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
            if (self->_previousView != obj && self->_currentView != obj && self->_nextView != obj) {
                //当显示的视图不是CGCycleContentView类型且不等显示的视图时判定为多余视图，移除!!!
                [obj removeFromSuperview];
            }
        }
    }];
    
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
    self.cycleScrollView.frame  = CG_CGRectWithMargin(self.bounds, self.marginEdgeInsetForScrollView);
    _pageContentView.frame      = self.bounds;
    
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
    
    NSNumber * currentIndex     = [self getViewIndexWithCurrentIndex:self.currentIndex type:_CGCycleSubviewTypeCurrentIndex];
    self.currentIndex           = currentIndex.integerValue;
    NSNumber * previousIndex    = [self getViewIndexWithCurrentIndex:self.currentIndex type:_CGCycleSubviewTypePreviousIndex];
    NSNumber * nextIndex        = [self getViewIndexWithCurrentIndex:self.currentIndex type:_CGCycleSubviewTypeNextIndex];
    
    //重置视图
    _previousView   = nil;
    _currentView    = nil;
    _nextView       = nil;
    
    if (previousIndex) {
        //当不满足不循环滑动且上一视图的索引比当前视图索引不小于时执行
        _previousView   = [self createCycleContentViewAtIndex:previousIndex.integerValue];
    }
    
    _currentView        = [self createCycleContentViewAtIndex:currentIndex.integerValue];
    
    if (nextIndex) {
        //当不满足不循环滑动且下一视图的索引比当前视图索引不大于时执行
        _nextView       = [self createCycleContentViewAtIndex:nextIndex.integerValue];
    }
    
    [self updateCycleScrollViewLayoutSubviews];
    
    if (self.didUpdateScrollContentViewBlock) {
        self.didUpdateScrollContentViewBlock();
    }
}

///滑动到下一视图
- (void)scrollToNextView
{
    NSNumber *nextIndex = [self getViewIndexWithCurrentIndex:self.currentIndex + 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //下一个当前索引是否存在
    if (nextIndex) {
        
        self.currentIndex = nextIndex.integerValue;
        [self setupScrollContentView];
    }
    
}

//滑动到上一视图
- (void)scrollToPreviousView
{
    NSNumber *previousIndex = [self getViewIndexWithCurrentIndex:self.currentIndex - 1 type:_CGCycleSubviewTypeCurrentIndex];
    
    //上一个当前索引是否存在
    if (previousIndex) {
        
        self.currentIndex = previousIndex.integerValue;
        [self setupScrollContentView];
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
    }else {
        
        [self stopAutoScroll];
    }
}

#pragma mark - 属性设置
- (void)setDataSource:(id<CGCycleScrollViewDataSource>)dataSource
{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        [self performSelector:@selector(reloadAllView) withObject:nil afterDelay:0 inModes:@[NSRunLoopCommonModes, NSDefaultRunLoopMode]];
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
        
        [self setupAutoScrollTimer];
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
    
    _cycleScrollView = [CGScrollView cg_createWithScrollViewWithShowScrollIndicator:NO pagingEnabled:YES];
    _cycleScrollView.delegate = self;
    return _cycleScrollView;
}

- (UIView *)pageContentView
{
    if (_pageContentView) {
        return _pageContentView;
    }
    
    _pageContentView = [UIView cg_createView];
    return _pageContentView;
}

- (void)setClipsToBounds:(BOOL)clipsToBounds
{
    [super setClipsToBounds:clipsToBounds];
    self.cycleScrollView.clipsToBounds  = clipsToBounds;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled  = scrollEnabled;
    self.cycleScrollView.scrollEnabled  = scrollEnabled;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.cycleScrollView.frame  = CG_CGRectWithMargin(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), self.marginEdgeInsetForScrollView);
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

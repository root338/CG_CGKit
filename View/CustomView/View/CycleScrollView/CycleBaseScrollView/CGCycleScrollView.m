//
//  CGCycleScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

#import "CGCycleScrollCotentView.h"

#import "UIView+CGSetupFrame.h"
#import "UIScrollView+CGCreate.h"
#import "UIView+CGAddConstraints.h"

#import "CGCycleCellConfigModel.h"
#import "CGCycleScrollAppearance.h"


#import "CGPrintLogHeader.h"

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    NSInteger   _totalCount;
    
    //开始加载的cell标识
    NSInteger   _currentIndex;
    CGCycleCellPosition _currentIndexPosition;
    
    UIScrollView *_scrollView;
    CGCycleScrollCotentView *_scrollContentView;
}

/** 滑动区域的大小 */
@property (nonatomic, assign, readonly) CGSize contentSize;
/** cell的配置集合 */
@property (nonatomic, strong) NSMutableArray<CGCycleCellConfigModel *> *contentCellConfigSet;
@end

@implementation CGCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self    = [super initWithFrame:frame];
    if (self) {
        _scrollView = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO];
        [self addSubview:_scrollView];
        
        _scrollContentView  = [[CGCycleScrollCotentView alloc] init];
        [_scrollView addSubview:_scrollContentView];
        
        [_scrollView cg_autoEdgesInsetsZeroToSuperview];
        [_scrollContentView cg_autoEdgesInsetsZeroToSuperview];
    }
    return self;
}

- (void)setupIndex:(NSInteger)index position:(CGCycleCellPosition)position
{
    _currentIndex           = index;
    _currentIndexPosition   = position;
    
    [self setupLoadCellIndexSet];
}

/** 设置加载的cell的索引集合 */
- (void)setupLoadCellIndexSet
{
    if (CGSizeEqualToSize(CGSizeZero, _scrollView.size)) {
        CGErrorLog(@"滑动视图大小不应为空");
        return;
    }
    
    if (!self.contentCellConfigSet) {
        self.contentCellConfigSet   = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    _totalCount                 = [self.dataSource numberCycleScrollView:self];
    CGSize currentIndexCellSize = [self getCellSizeWithIndex:_currentIndex];
    CGSize contentSize          = [self contentSize];
    NSInteger startIndex        = _currentIndex;
    
    //设置标示
    for (;;) {
        
    }
}

//获取下一个索引
- (NSInteger)getNextCellIndexWithIndex:(NSInteger)index
{
    NSInteger nextIndex = index + 1;
    if (self.appearance.isCycle) {
        if (nextIndex >= _totalCount) {
            nextIndex = 0;
        }
    }
    return nextIndex;
}

//获取上一个索引
- (NSInteger)getPreviousCellIndexWithIndex:(NSInteger)index
{
    NSInteger previousIndex = index - 1;
    if (self.appearance.isCycle) {
        if (previousIndex < 0) {
            previousIndex   = _totalCount - 1;
        }
    }
    return previousIndex;
}

//获取指定索引的cell大小
- (CGSize)getCellSizeWithIndex:(NSInteger)index
{
    CGSize cellSize;
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:cellSizeAtIndex:)]) {
        cellSize    = [self.delegate cycleScrollView:self cellSizeAtIndex:_currentIndex];
    }else if (!CGSizeEqualToSize(self.appearance.cellSize, CGSizeZero)) {
        
        cellSize    = self.appearance.cellSize;
    }else {
        
        cellSize    = _scrollView.size;
    }
    return cellSize;
}

//设置指定索引的显示区域
- (CGRect)getMakeCellFrameWithSize:(CGSize)size position:(CGCycleCellPosition)position
{
    CGPoint center;
    CGPoint makeCellOrigin  = CGPointZero;
    if (self.scrollDirection == CGCycleViewScrollDirectionVertical) {
        
        center  = CGPointMake(0, _scrollView.height);
    }else {
        
        center  = CGPointMake(_scrollView.width, 0);
    }
    
    if (position == CGCycleCellPositionNone) {
        position    = CGCycleCellPositionCenteredVertically | CGCycleCellPositionCenteredHorizontally;
    }
    
    if (position & CGCycleCellPositionTop) {
        makeCellOrigin.y    = center.y;
    }else if (position & CGCycleCellPositionCenteredVertically) {
        makeCellOrigin.y    = center.y + (_scrollView.height - size.height) / 2.0;
    }else if (position & CGCycleCellPositionBottom) {
        makeCellOrigin.y    = center.y + (_scrollView.height - size.height);
    }
    
    if (position & CGCycleCellPositionLeft) {
        makeCellOrigin.x    = center.x;
    }else if (position & CGCycleCellPositionCenteredHorizontally) {
        makeCellOrigin.x    = center.x + (_scrollView.width - size.width) / 2.0;
    }else if (position & CGCycleCellPositionRight) {
        makeCellOrigin.x    = center.x + (_scrollView.width - size.width);
    }
    
    return (CGRect){makeCellOrigin, size};
}

///更新视图
- (void)reloadAllView
{
    
}

#pragma mark - 设置属性 
- (CGSize)contentSize
{
    CGSize contentSize;
    if (self.scrollDirection == CGCycleViewScrollDirectionVertical) {
        contentSize = CGSizeMake(_scrollView.width, _scrollView.height * 3);
    }else {
        contentSize = CGSizeMake(_scrollView.width * 3, _scrollView.height);
    }
    return contentSize;
}

- (CGCycleScrollAppearance *)appearance
{
    if (_appearance) {
        return _appearance;
    }
    
    _appearance = [CGCycleScrollAppearance defaultAppearance];
    
    return _appearance;
}

@end

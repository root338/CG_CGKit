//
//  CGCycleScrollViewBuildLayout.m
//  TestCG_CGKit
//
//  Created by DY on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCycleScrollViewBuildLayout.h"
#import "CGCycleCellConfigModel.h"

#import "CGCycleScrollView.h"

#import "UIView+CGSetupFrame.h"

#import "NSArray+CGArray.h"

#import "CGPrintLogHeader.h"

@interface CGCycleScrollViewBuildLayout ()
{
    /** 总共需要加载的个数 */
    NSInteger _totalNumber;
}
@property (nonatomic, strong) NSMutableArray<CGCycleCellConfigModel *> *cellsConfigArray;

@property (nullable, nonatomic, strong, readwrite) CGCycleCellConfigModel *firstCellConfig;
@property (nullable, nonatomic, strong, readwrite) CGCycleCellConfigModel *lastCellConfig;

@property (nullable, nonatomic, strong, readwrite) NSArray<CGCycleCellConfigModel *> *allCellsConfigArray;
@end

@implementation CGCycleScrollViewBuildLayout

- (CGPoint)setupScrollViewDidReloadContentOffset
{
    
    CGPoint contentOffset   = CGPointZero;
    if (!self.firstCellConfig) {
        return contentOffset;
    }
    
    CGPoint scrollViewContentOffset = self.scrollView.contentOffset;
    if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        contentOffset   = CGPointMake(CGRectGetMaxX(self.firstCellConfig.frame), scrollViewContentOffset.y);
    }else if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionVertical) {
        contentOffset   = CGPointMake(scrollViewContentOffset.x, CGRectGetMaxY(self.firstCellConfig.frame));
    }
    return contentOffset;
}

- (CGSize)setupScrollViewDidReloadContentSize
{
    
    CGCycleCellConfigModel *lastCellConfig  = [self.allCellsConfigArray lastObject];
    
    CGSize contentSize  = CGSizeZero;
    if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        contentSize = CGSizeMake(CGRectGetMaxX(lastCellConfig.frame), 0);
    }else if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionVertical) {
        contentSize = CGSizeMake(0, CGRectGetMaxY(lastCellConfig.frame));
    }
    
    return contentSize;
}

- (NSArray<CGCycleCellConfigModel *> *)setupBuildLayoutCells
{
    if (self.scrollView.width < 0.0001 || self.scrollView.height < 0.0001) {
        return nil;
    }
    
    _totalNumber = [self.cycleScrollView.dataSource numberCycleScrollView:self.cycleScrollView];
    if (_totalNumber < 1) {
        return nil;
    }
    
    CGPoint cellOrigin          = CGPointZero;
    self.firstCellConfig        = [self cellConfigWithIndex:[self previousWithTargetIndex:self.currentIndex] position:&cellOrigin];
    
    CGRect scrollVisibleRect    = self.scrollView.bounds;
    scrollVisibleRect.origin    = cellOrigin;
    
    NSInteger   index           = self.currentIndex;
    //防止所设置的大小全为0，且是循环滑动，造成的死循环
    NSInteger   i               = 0;
    BOOL        isSizeZero      = YES;
    
    if (!self.cellsConfigArray) {
        self.cellsConfigArray   = [NSMutableArray array];
    }else {
        [self.cellsConfigArray removeAllObjects];
    }
    
    while (1) {
        
        CGCycleCellConfigModel *config  = [self cellConfigWithIndex:index position:&cellOrigin];
        if (config) {
            
            [self.cellsConfigArray addObject:config];
            index   = [self nextWithTargetIndex:index];
            if (!CGRectContainsPoint(scrollVisibleRect, <#CGPoint point#>)) {
                break;
            }
            
            isSizeZero  = NO;
        }
        
        if (i == _totalNumber) {
            if (isSizeZero) {
                CGDebugAssert(nil, @"滑动子视图不能为空");
                break;
            }
        }
        
        i++;
    }
    
    self.lastCellConfig = [self cellConfigWithIndex:index position:&cellOrigin];
    
    NSMutableArray *allCellsConfig   = [NSMutableArray arrayWithArray:self.cellsConfigArray];
    [allCellsConfig cg_insertObject:self.firstCellConfig atIndex:0];
    [allCellsConfig cg_addObject:self.lastCellConfig];
    
    self.allCellsConfigArray    = allCellsConfig;
    
    return allCellsConfig;
}

- (nullable CGCycleCellConfigModel *)cellConfigWithIndex:(NSInteger)index position:(CGPoint *)position
{
    if (index < 0 || index >= _totalNumber) {
        return nil;
    }
    
    CGSize cellSize                     = [self cellSizeWithIndex:index];
    CGCycleCellConfigModel *cellConfig  = nil;
    
    if (!CGSizeEqualToSize(cellSize, CGSizeZero)) {
        
        CGPoint cellPoint                   = *position;
        
        cellConfig  = [[CGCycleCellConfigModel alloc] initWithIndex:index];
        
        cellConfig.frame                    = (CGRect){cellPoint, cellSize};
        
        if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
            cellPoint.x += cellSize.width;
        }else if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionVertical) {
            cellPoint.y += cellSize.height;
        }
        *position   = cellPoint;
    }
    
    return cellConfig;
}

/** 设置指定索引cell的大小 */
- (CGSize)cellSizeWithIndex:(NSInteger)index
{
    CGSize  size    = CGSizeZero;
    CGFloat length  = 0.0;
    
    id<CGCycleScrollViewDelegate> delegate  = self.cycleScrollView.delegate;
    CGCycleScrollView *cycleScrollView      = self.cycleScrollView;
    
    if ([delegate respondsToSelector:@selector(cycleScrollView:lenghtAtIndex:)]) {
        
        length  = [delegate cycleScrollView:cycleScrollView lenghtAtIndex:index];
    }else {
        
        length  = cycleScrollView.cellLength;
    }
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        
        if (length > 0) {
            if (cycleScrollView.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
                
                size    = CGSizeMake(length, self.scrollView.height);
            }else if (cycleScrollView.scrollDirection == CGCycleViewScrollDirectionVertical) {
                
                size    = CGSizeMake(self.scrollView.width, length);
            }
        }else {
            
            //当size为{0,0}时，设置cell大小等于循环视图大小
            size    = self.scrollView.size;
        }
    }
    
    return size;
}

/** 获取指定索引的上一个索引 */
- (NSInteger)previousWithTargetIndex:(NSInteger)targetIndex
{
    NSInteger previousIndex = targetIndex - 1;
    
    if (previousIndex < 0) {
        if (self.cycleScrollView.isCycle) {
            
            previousIndex   = _totalNumber - 1;
        }else {
            previousIndex   = -1;
        }
    }
    
    return previousIndex;
}

/** 获取指定索引的下一个索引 */
- (NSInteger)nextWithTargetIndex:(NSInteger)targetIndex
{
    NSInteger nextIndex = targetIndex + 1;
    
    if (nextIndex >= _totalNumber) {
        if (self.cycleScrollView.isCycle) {
            
            nextIndex   = 0;
        }else {
            
            nextIndex   = _totalNumber;
        }
    }
    return nextIndex;
}

@end

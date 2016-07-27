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

@interface CGCycleScrollViewBuildLayout ()
{
    /** 总共需要加载的个数 */
    NSInteger _totalNumber;
}
@property (nonatomic, strong) NSMutableArray<CGCycleCellConfigModel *> *cellsConfigArray;

@end

@implementation CGCycleScrollViewBuildLayout

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
    self.firstCellConfig        = [self cellConfigWithIndex:self.currentIndex - 1 position:&cellOrigin];
    
    CGRect scrollVisibleRect    = self.scrollView.bounds;
    scrollVisibleRect.origin    = cellOrigin;
    
    NSInteger   i               = 0;
    NSInteger   index           = self.currentIndex;
    
    NSInteger   tempIndex       = self.currentIndex;
    
    if (!self.cellsConfigArray) {
        self.cellsConfigArray   = [NSMutableArray array];
    }
    while (1) {
        
        
    }
    
    return self.cellsConfigArray;
}

- (nullable CGCycleCellConfigModel *)cellConfigWithIndex:(NSInteger)index position:(CGPoint *)position
{
    if (index < 0 || index >= _totalNumber) {
        return nil;
    }
    
    CGPoint cellPoint                   = *position;
    
    CGCycleCellConfigModel *cellConfig  = [[CGCycleCellConfigModel alloc] initWithIndex:index];
    
    CGSize cellSize                     = [self cellSizeWithIndex:index];
    cellConfig.frame                    = (CGRect){cellPoint, cellSize};
    
    if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionHorizontal) {
        cellPoint.x += cellSize.width;
    }else if (self.cycleScrollView.scrollDirection == CGCycleViewScrollDirectionVertical) {
        cellPoint.y += cellSize.height;
    }
    *position   = cellPoint;
    
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
    if (self.cycleScrollView.isCycle) {
        if (previousIndex < 0) {
            previousIndex = _totalNumber - 1;
        }
    }
    return previousIndex;
}

/** 获取指定索引的下一个索引 */
- (NSInteger)nextWithTargetIndex:(NSInteger)targetIndex
{
    NSInteger nextIndex = targetIndex + 1;
    if (self.cycleScrollView.isCycle) {
        if (nextIndex >= _totalNumber) {
            nextIndex   = 0;
        }
    }
    return nextIndex;
}

@end

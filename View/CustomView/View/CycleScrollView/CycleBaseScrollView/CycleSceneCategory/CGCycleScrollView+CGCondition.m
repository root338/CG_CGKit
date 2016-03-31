//
//  CGCycleScrollView+CGCondition.m
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGCycleScrollView+CGCondition.h"


#import "CGPrintLogHeader.h"

@implementation CGCycleScrollView (CGCondition)

/**
 *  判断给定的索引和给定的当前索引是否满足条件
 *
 *  @param index             需要判断的上下页索引
 *  @param paramCurrentIndex 将要成为当前索引
 *  @param type              判断的类型
 *
 *  @return 返回给定的当前索引是否存在给定索引，_CGCycleSubviewTypeCurrentIndex只与自身对比
 */
- (BOOL)isShouldCreateViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)type
{
    BOOL isResult = NO;
    if (paramCurrentIndex >= 0 && paramCurrentIndex < self.totalViewNumber && ((type != _CGCycleSubviewTypeCurrentIndex && index >= 0 && index < self.totalViewNumber) || type == _CGCycleSubviewTypeCurrentIndex)) {
        
        switch (type) {
            case _CGCycleSubviewTypePreviousAideView:
            case _CGCycleSubviewTypePreviousIndex:
                isResult = !(!self.isCycle && index >= paramCurrentIndex);
                break;
            case _CGCycleSubviewTypeCurrentIndex:
                isResult = YES;
                break;
            case _CGCycleSubviewTypeNextIndex:
            case _CGCycleSubviewTypeNextAideView:
                isResult = !(!self.isCycle && index <= paramCurrentIndex);
                break;
            default:
                CGErrorLog(@"指定的判断类型不存在");
                break;
        }
        
    }else {
        
        CGErrorLog(@"指定的当前索引(%li)超出索引范围(0 ~ %li)", (long)paramCurrentIndex, (long)self.totalViewNumber);
    }
    return isResult;
}

/** 判读给定上一页 */
- (BOOL)isShouldCreatePrevioursViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex
{
    return [self isShouldCreateViewWithIndex:index currentIndex:paramCurrentIndex type:_CGCycleSubviewTypePreviousIndex];
}

/** 判断给定下一页 */
- (BOOL)isShouldCreateNextViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex
{
    return [self isShouldCreateViewWithIndex:index currentIndex:paramCurrentIndex type:_CGCycleSubviewTypeNextIndex];
}

/** 判断当前页 */
- (BOOL)isShourldCreateCurrentViewWithCurrentIndex:(NSInteger)paramCurrentIndex
{
    return [self isShouldCreateViewWithIndex:0 currentIndex:paramCurrentIndex type:_CGCycleSubviewTypeCurrentIndex];
}

@end

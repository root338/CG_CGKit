//
//  CGCycleScrollView+CGCondition.h
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGCycleScrollView.h"
#import "CGCycleViewPrivateHeader.h"

/** 一些判断方法 */
@interface CGCycleScrollView (CGCondition)

/**
 *  判断给定的索引和给定的当前索引是否满足条件
 *
 *  @param index             需要判断的上下页索引
 *  @param paramCurrentIndex 将要成为当前索引
 *  @param type              判断的类型
 *
 *  @return 返回给定的当前索引是否存在给定索引，_CGCycleSubviewTypeCurrentIndex只与自身对比
 */
- (BOOL)isShouldCreateViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)type;
/** 判读给定上一页 */
- (BOOL)isShouldCreatePrevioursViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex;
/** 判断给定下一页 */
- (BOOL)isShouldCreateNextViewWithIndex:(NSInteger)index currentIndex:(NSInteger)paramCurrentIndex;
/** 判断当前页 */
- (BOOL)isShourldCreateCurrentViewWithCurrentIndex:(NSInteger)paramCurrentIndex;

@end

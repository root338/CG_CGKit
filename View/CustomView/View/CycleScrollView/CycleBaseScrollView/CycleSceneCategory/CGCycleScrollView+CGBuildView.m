//
//  CGCycleScrollView+CGBuildView.m
//  TestProject
//
//  Created by DY on 15/11/25.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGCycleScrollView+CGBuildView.h"
#import "CGCycleScrollView+CGCondition.h"
#import "CGPrintLogHeader.h"

@implementation CGCycleScrollView (CGBuildView)

- (NSNumber *)getViewIndexForType:(_CGCycleSubviewType)subviewType
{
    __block NSNumber *result = nil;
    [self getViewIndexWithCurrentIndex:self.currentIndex type:subviewType autoChangeCurrentIndex:YES completion:^(BOOL isSuccess, NSInteger changedCurrentIndex, NSInteger viewIndex) {
        if (isSuccess) {
            result = @(viewIndex);
        }
    }];
    
    return result;
}

- (NSNumber *)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType
{
    return [self getViewIndexWithCurrentIndex:paramCurrentIndex type:subviewType isAutoChangeCurrentIndex:NO];
}

- (NSNumber *)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType isAutoChangeCurrentIndex:(BOOL)isAutoChange
{
    __block NSNumber *result = nil;
    [self getViewIndexWithCurrentIndex:paramCurrentIndex type:subviewType autoChangeCurrentIndex:isAutoChange completion:^(BOOL isSuccess, NSInteger changedCurrentIndex, NSInteger viewIndex) {
        if (isSuccess) {
            result = @(viewIndex);
        }
    }];
    return result;
}

- (void)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType autoChangeCurrentIndex:(BOOL)isAutoChange completion:(void (^)(BOOL, NSInteger, NSInteger))completion
{
    
    void (^completionBlock)(BOOL, NSInteger, NSInteger) = ^(BOOL isSuccess, NSInteger paramCurrentIndex, NSInteger viewIndex){
        
        if (completion) {
            completion(isSuccess, paramCurrentIndex, viewIndex);
        }
    };
    
    //更新当前显示索引
    if (paramCurrentIndex >= self.totalViewNumber || paramCurrentIndex < 0) {
        
        if (!isAutoChange && !self.isCycle) {
            
            CGErrorLog(@"不能自动更新指定索引，且指定当前索引不合法");
            completionBlock(NO, paramCurrentIndex, 0);
            return;
        }
        
        NSInteger maxIndex = self.totalViewNumber - 1;
        NSInteger minIndex = 0;
        
        NSInteger currentIndex;
        
        if (paramCurrentIndex >= self.totalViewNumber) {
            
            if (self.isCycle) {
                
                currentIndex = minIndex;
            }else {
                
                CGLog(@"加载的视图索引大于最大索引数(%li)，你设置为(%li)，自动重置为 %li", (long)maxIndex, (long)paramCurrentIndex, (long)maxIndex);
                currentIndex = maxIndex;
            }
        }else  {
            
            if (self.isCycle) {
                
                currentIndex = maxIndex;
            }else {
                
                CGLog(@"初始加载的视图索引小于最小索引数(%li)，你设置为(%li)，自动重置为 %li", (long)minIndex, (long)paramCurrentIndex, (long)minIndex);
                currentIndex = minIndex;
            }
        }
        
        paramCurrentIndex = currentIndex;
    }
    
    //更新当前显示索引前后索引
    NSInteger viewIndex = paramCurrentIndex + subviewType;
    
    viewIndex   = [self cg_getViewIndexWithIndex:viewIndex];
    
    BOOL issuccess = [self isShouldCreateViewWithIndex:viewIndex currentIndex:paramCurrentIndex type:subviewType];
    if (!issuccess && self.isCycle) {
        
        //不循环滑动，在边缘时，会过滤掉
        CGErrorLog(@"设置的索引不可用");
    }
    
    completionBlock(issuccess, paramCurrentIndex, viewIndex);
}

- (NSInteger)cg_getViewIndexWithIndex:(NSInteger)paramViewIndex
{
    if (self.totalViewNumber <= 0) {
        return 0;
    }
    if (paramViewIndex >= 0 && paramViewIndex < self.totalViewNumber) {
        return paramViewIndex;
    }
    
    if (paramViewIndex < 0) {
        paramViewIndex = self.totalViewNumber + paramViewIndex;
    }
    
    if (paramViewIndex >= self.totalViewNumber) {
        paramViewIndex = paramViewIndex - self.totalViewNumber;
    }
    
    if (paramViewIndex < 0 || paramViewIndex >= self.totalViewNumber) {
        return [self cg_getViewIndexWithIndex:paramViewIndex];
    }
    
    return paramViewIndex;
}

@end

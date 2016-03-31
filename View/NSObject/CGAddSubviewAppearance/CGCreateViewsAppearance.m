//
//  CGCreateViewsAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCreateViewsAppearance.h"

#import "CGPrintLogHeader.h"

@implementation CGCreateViewsAppearance

#pragma mark - 只读判断属性
- (BOOL)shouldPrivatePropertyValue
{
    BOOL isResult   = NO;
    CGErrorConditionLog(self.subviewsTotal == 0, @"需要添加的子视图数量不能为0");
    CGErrorConditionLog(self.count == 0, @"横向添加的子视图数不能为0");
    isResult    = self.subviewsTotal && self.count;
    return isResult;
}

- (BOOL)shouldAutoSetupViewSize
{
//    if (!self.shouldPrivatePropertyValue) {
//        return NO;
//    }
    
    BOOL isResult   = NO;
    if (self.isAutoSetupViewSize) {
        
        
        isResult    = !CGSizeEqualToSize(self.itemSize, CGSizeZero);
        CGErrorConditionLog(!isResult, @"请设置itemSize");
    }else {
        CGErrorLog(@"请设置isAutoSetupViewSize属性为YES，开启自动设置视图大小功能");
    }
    return isResult;
}

#pragma mark - 只读属性的计算
- (CGSize)viewSize
{
    CGFloat width           = self.marginEdgeInset.left + self.marginEdgeInset.right + self.itemSize.width * self.count + self.horizontalSpace * (self.count - 1);
    
    CGFloat verticalCount   = ceil(self.subviewsTotal / MAX(1, self.count));
    CGFloat height          = self.marginEdgeInset.top + self.marginEdgeInset.bottom + self.itemSize.height * verticalCount + self.verticalSpace * (verticalCount - 1);
    CGSize size             = CGSizeMake(width, height);
    return size;
}

@end

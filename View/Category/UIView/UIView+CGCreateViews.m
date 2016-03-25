//
//  UIView+CGCreateViews.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIView+CGCreateViews.h"

#import "CGCreateViewsAppearance.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "CGPrintLogHeader.h"

@implementation UIView (CGCreateViews)

- (void)cg_createViewsWithRule:(CGCreateViewsAppearance *)viewsRule subview:(nonnull __kindof UIView * _Nonnull (^)(NSInteger))setupSubview
{
    if (!viewsRule.shouldPrivatePropertyValue) {
        //不满足添加子视图
        return;
    }
    if (!(viewsRule.isAutoSetupViewSize && viewsRule.shouldAutoSetupViewSize)) {
        //不满足自动设置视图
        return;
    }
    
    if (viewsRule.isAutoSetupViewSize) {
        
        self.size       = viewsRule.viewSize;
    }
    
    //获取内容视图的大小
    CGFloat contentWidth    = MAX(CG_CGWidthWithMaxWidth(self.width, viewsRule.marginEdgeInset), 0);
    CGFloat contentHeight   = MAX(CG_CGHeightWithMaxHeight(self.height, viewsRule.marginEdgeInset), 0);
    
    if (contentWidth == 0 || contentHeight == 0) {
        CGErrorLog(@"添加的视图大小不能为CGSizeZero");
        return;
    }
    
    CGFloat itemWidth   = 0;
    CGFloat itemHeight  = 0;
    if (viewsRule.shouldAutoSetupViewSize) {
        itemWidth   = viewsRule.itemSize.width;
        itemHeight  = viewsRule.itemSize.height;
    }else {
        itemWidth   = (contentWidth - (viewsRule.count - 1) * viewsRule.horizontalSpace) / viewsRule.count;
        itemHeight  = (contentHeight - (viewsRule.count - 1) * viewsRule.verticalSpace) / viewsRule.count;
    }
    
    for (NSInteger index = 0; index < viewsRule.subviewsTotal; index++) {
        
        UIView *subview = setupSubview(index);
        
        subview.frame   = CGRectMake(viewsRule.marginEdgeInset.left + (index % viewsRule.count) * (itemWidth + viewsRule.horizontalSpace), viewsRule.marginEdgeInset.top + (index / viewsRule.count) * (itemHeight + viewsRule.verticalSpace), itemWidth, itemHeight);
        [self addSubview:subview];
    }
}

@end

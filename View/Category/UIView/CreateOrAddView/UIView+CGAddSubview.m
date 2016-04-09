//
//  UIView+CGAddSubview.m
//  QuickAskCommunity
//
//  Created by DY on 16/2/22.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIView+CGAddSubview.h"

@implementation UIView (CGAddSubview)

- (void)cg_addSubviews:(NSArray<UIView *> *)subviews
{
    [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
}

- (BOOL)cg_addSubview:(UIView *)view
{
    BOOL isShouldView;
    if ( (isShouldView = !CGRectEqualToRect(view.bounds, CGRectZero)) ) {
        if (!view.superview) {
            [self addSubview:view];
        }
    }else {
        !view.superview ?: [view removeFromSuperview];
    }
    return isShouldView;
}

@end

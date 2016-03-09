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

@end

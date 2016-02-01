//
//  UIView+CGAddView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGAddView.h"

@implementation UIView (CGAddView)

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

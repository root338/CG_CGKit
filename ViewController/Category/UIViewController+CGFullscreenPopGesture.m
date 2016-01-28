//
//  UIViewController+CGFullscreenPopGesture.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGFullscreenPopGesture.h"
#import <objc/runtime.h>

@implementation UIViewController (CGFullscreenPopGesture)

- (void)setCg_interactivePopDisabled:(BOOL)interactivePopDisabled
{
    objc_setAssociatedObject(self, @selector(cg_interactivePopDisabled), @(interactivePopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cg_interactivePopDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCg_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance
{
    objc_setAssociatedObject(self, @selector(cg_interactivePopMaxAllowedInitialDistanceToLeftEdge), @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cg_interactivePopMaxAllowedInitialDistanceToLeftEdge
{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

@end

//
//  UIView+CGConstraintsManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGConstraintsManager.h"

#import <objc/runtime.h>

@implementation UIView (CGConstraintsManager)

#pragma mark - 设置属性

- (void)setLayoutManager:(CGLayoutManager *)manager
{
    objc_setAssociatedObject(self, @selector(layoutManager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGLayoutManager *)layoutManager
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

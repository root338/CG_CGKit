//
//  UITableView+SetupBackgroundView.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/22.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+SetupBackgroundView.h"
#import <objc/runtime.h>

@implementation UITableView (SetupBackgroundView)

@dynamic bgCustomView;

#pragma mark - 设置属性

- (void)setBgCustomView:(UIView *)backgroundView
{
    !self.bgCustomView.superview ?: [self.bgCustomView removeFromSuperview];
    
    if (backgroundView) {
        
        CGRect frame    = self.bounds;
        frame.origin.y  += self.backgroundViewStartOriginY;
        backgroundView.frame    = frame;
        
        [self addSubview:backgroundView];
        
        [self willChangeValueForKey:@"bgCustomView"];
        objc_setAssociatedObject(self, @selector(bgCustomView), backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"bgCustomView"];
    }
}

- (UIView *)bgCustomView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBackgroundViewStartOriginY:(CGFloat)y
{
    objc_setAssociatedObject(self, @selector(backgroundViewStartOriginY), @(y), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)backgroundViewStartOriginY
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end

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
        backgroundView.frame = self.bounds;
        CGPoint center = self.center;
        center.y -= self.frame.origin.y;
        center.x -= self.frame.origin.x;
        backgroundView.center = center;
        [self addSubview:backgroundView];
        
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self willChangeValueForKey:@"bgCustomView"];
        objc_setAssociatedObject(self, @selector(bgCustomView), backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"bgCustomView"];
    }
}

- (UIView *)bgCustomView
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

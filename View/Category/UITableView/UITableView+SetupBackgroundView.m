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
static char CGBgCustomViewKey;
- (void)setBgCustomView:(UIView *)bgCustomView
{
    !self.bgCustomView ?: [self.bgCustomView removeFromSuperview];
    
    if (bgCustomView) {
        bgCustomView.frame = self.bounds;
        CGPoint center = self.center;
        center.y -= self.frame.origin.y;
        center.x -= self.frame.origin.x;
        bgCustomView.center = center;
        [self addSubview:bgCustomView];
        
        bgCustomView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self willChangeValueForKey:@"bgCustomView"];
        objc_setAssociatedObject(self, &CGBgCustomViewKey, bgCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"bgCustomView"];
    }
}

- (UIView *)bgCustomView
{
    return objc_getAssociatedObject(self, &CGBgCustomViewKey);
}

@end

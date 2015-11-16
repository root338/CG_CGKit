//
//  UIView+CGSearchView.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGSearchView.h"

@implementation UIView (CGSearchView)

- (id)searchSuperViewWithClass:(Class)className
{
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:className]) {
        return self.superview;
    }else {
        return [self.superview searchSuperViewWithClass:className];
    }
}
@end

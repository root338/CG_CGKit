//
//  UIScrollView+CGProperty.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/14.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIScrollView+CGProperty.h"

@implementation UIScrollView (CGProperty)

- (CGRect)scrollVisibleRect
{
    return (CGRect){self.contentOffset, self.bounds.size};
}
@end

//
//  NSObject+CGDelaySelector.m
//  TestProject
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 -. All rights reserved.
//

#import "NSObject+CGDelaySelector.h"

@implementation NSObject (CGDelaySelector)

- (void)cg_performAfterZeroDelaySelector:(SEL)aSelector
{
    [self performSelector:aSelector withObject:nil afterDelay:0];
}

@end

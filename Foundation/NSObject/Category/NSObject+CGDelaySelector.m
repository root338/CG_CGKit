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

- (void)cg_preformWithAfterDelay:(NSTimeInterval)afterDelay block:(void (^)(void))block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !block ?: block();
    });
}

@end

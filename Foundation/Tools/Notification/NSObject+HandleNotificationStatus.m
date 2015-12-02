//
//  NSObject+HandleNotificationStatus.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+HandleNotificationStatus.h"

@implementation NSObject (HandleNotificationStatus)

- (void)notificationWithNames:(NSArray *)names isRemove:(BOOL)isRemove observer:(id)target selector:(SEL)selector object:(id)object
{
    [self notificationWithNames:names isRemove:isRemove observer:^id(NSString *notificationName, NSInteger index) {
        return target;
    } selectorblock:^SEL(NSString *notificationName, NSInteger index) {
        return selector;
    } objectBlock:^id(NSString *notificationName, NSInteger index) {
        return object;
    }];
}

- (void)notificationWithNames:(NSArray *)names isRemove:(BOOL)isRemove observer:(ObjectBlock)targetBlock selectorblock:(SelectorBlock)selectorBlock objectBlock:(ObjectBlock)objectBlock
{
    [names enumerateObjectsUsingBlock:^(id  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            
        id target       = targetBlock(name, idx);
        SEL selector    = selectorBlock(name, idx);
        id objec        = objectBlock(name, idx);
        
        if (target) {
            if (isRemove) {
                [[NSNotificationCenter defaultCenter] removeObserver:target
                                                                name:name
                                                              object:objec];
            }else {
                if (selector) {
                    [[NSNotificationCenter defaultCenter] addObserver:target
                                                             selector:selector
                                                                 name:name
                                                               object:objec];
                }
            }
        }
    }];
}
@end

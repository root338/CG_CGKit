//
//  NSUserDefaults+SaveData.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/14.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSUserDefaults+SaveData.h"

@implementation NSUserDefaults (SaveData)

+ (void)cg_saveWithObject:(id)object forKey:(NSString *)key
{
    if (object && key) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:object forKey:key];
    }
}

+ (id)cg_getObjectForKey:(NSString *)key
{
    if (key) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:key]) {
            return [userDefaults objectForKey:key];
        }
    }
    return nil;
}

+ (void)cg_saveWithBool:(BOOL)boolValue forKey:(NSString *)key
{
    [self cg_saveWithObject:@(boolValue) forKey:key];
}

+ (BOOL)cg_getBoolForKey:(NSString *)key
{
    return [[self cg_getObjectForKey:key] boolValue];
}

+ (void)cg_saveChangeData
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

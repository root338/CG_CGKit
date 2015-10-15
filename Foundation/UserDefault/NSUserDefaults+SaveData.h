//
//  NSUserDefaults+SaveData.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/14.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (SaveData)

+ (void)cg_saveWithObject:(id)object forKey:(NSString *)key;
+ (id)cg_getObjectForKey:(NSString *)key;

+ (void)cg_saveWithBool:(BOOL)boolValue forKey:(NSString *)key;
+ (BOOL)cg_getBoolForKey:(NSString *)key;

+ (void)cg_saveChangeData;

@end

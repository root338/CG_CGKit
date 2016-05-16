//
//  NSUserDefaults+CGMethodSave.h
//  QuickAskCommunity
//
//  Created by DY on 16/5/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (CGMethodSave)

+ (void)cg_addMethodNameWithChar:(const char *)methodName;

+ (void)cg_addMethodNameWithString:(NSString *)methodName;

+ (NSArray *)cg_getMethodNamesArray;

+ (void)removeAllSaveMethodNamesArray;
@end

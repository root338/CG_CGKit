//
//  NSError+CGCreateError.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/19.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (CGCreateError)

+ (NSError *)cg_CreateWithCode:(NSInteger)code errorMessage:(NSString *)errorMessage;

@end

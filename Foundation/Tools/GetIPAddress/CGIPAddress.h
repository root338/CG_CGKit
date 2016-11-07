//
//  CGIPAddress.h
//  QuickAskCommunity
//
//  Created by DY on 2016/11/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGIPAddress : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;

@end

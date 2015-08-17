//
//  NSString+CGObject.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/14.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSString+CGObject.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (CGObject)

//! via: http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c
+ (NSString *)MD5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    
}

+ (NSString *)MD5Stringlower:(NSString *)string
{
    return [[self MD5String:string] lowercaseString];
}
@end

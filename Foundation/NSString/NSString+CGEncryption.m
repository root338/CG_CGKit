//
//  NSString+Encryption.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/19.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSString+CGEncryption.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (CGEncryption)

- (NSString *)SHA1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


//! via: http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c
- (NSString *)MD5String
{
    if (self == nil) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

- (NSString *)MD5StringLowercase
{
    return [[self MD5String] lowercaseString];
}
@end

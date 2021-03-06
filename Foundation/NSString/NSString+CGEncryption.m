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

//#import <CommonCrypto/CommonDigest.h>
//#include <ifaddrs.h>
//#include <arpa/inet.h>
//#include <net/if.h>
//
//#define IOS_CELLULAR    @"pdp_ip0"
//#define IOS_WIFI        @"en0"
//#define IP_ADDR_IPv4    @"ipv4"
//#define IP_ADDR_IPv6    @"ipv6"
//
//@implementation CommonUtil
//
//+ (NSString *)md5:(NSString *)input
//{
//    const char *cStr = [input UTF8String];
//    unsigned char digest[16];
//    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return  output;
//}
//
//+ (NSString *)sha1:(NSString *)input
//{
//    const char *ptr = [input UTF8String];
//    
//    int i =0;
//    int len = (int)strlen(ptr);
//    Byte byteArray[len];
//    while (i!=len)
//    {
//        unsigned eachChar = *(ptr + i);
//        unsigned low8Bits = eachChar & 0xFF;
//        
//        byteArray[i] = low8Bits;
//        i++;
//    }
//    
//    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(byteArray, len, digest);
//    
//    NSMutableString *hex = [NSMutableString string];
//    for (int i=0; i<20; i++)
//        [hex appendFormat:@"%02x", digest[i]];
//    
//    NSString *immutableHex = [NSString stringWithString:hex];
//    
//    return immutableHex;
//}
//
//+ (NSString *)getIPAddress:(BOOL)preferIPv4
//{
//    NSArray *searchArray = preferIPv4 ?
//    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
//    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
//    
//    NSDictionary *addresses = [self getIPAddresses];
//    //NSLog(@"addresses: %@", addresses);
//    
//    __block NSString *address;
//    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
//     {
//         address = addresses[key];
//         if(address) *stop = YES;
//     } ];
//    return address ? address : @"0.0.0.0";
//}
//
//+ (NSDictionary *)getIPAddresses
//{
//    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
//    
//    // retrieve the current interfaces - returns 0 on success
//    struct ifaddrs *interfaces;
//    if(!getifaddrs(&interfaces)) {
//        // Loop through linked list of interfaces
//        struct ifaddrs *interface;
//        for(interface=interfaces; interface; interface=interface->ifa_next) {
//            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
//                continue; // deeply nested code harder to read
//            }
//            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
//            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
//                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
//                char addrBuf[INET6_ADDRSTRLEN];
//                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
//                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
//                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
//                }
//            }
//        }
//        // Free memory
//        freeifaddrs(interfaces);
//    }
//    
//    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
//    return [addresses count] ? addresses : nil;
//}
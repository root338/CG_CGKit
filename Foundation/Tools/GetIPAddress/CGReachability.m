//
//  CGReachability.m
//  TestCG_CGKit
//
//  Created by DY on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CGReachability.h"

#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>

#import <SystemConfiguration/SystemConfiguration.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NSString *kCGReachabilityChangeNotification   = @"com.cg.kCGReachabilityChangeNotification";

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject *)info isKindOfClass:[CGReachability class]], @"info was wrong class in ReachabilityCallback");
    
    CGReachability *noteObject  = (__bridge CGReachability *)info;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCGReachabilityChangeNotification object:noteObject];
    if (noteObject.reachabilityDidChangeCallback) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            noteObject.reachabilityDidChangeCallback(noteObject);
        });
        
    }
}

@interface CGReachability ()
{
    SCNetworkReachabilityRef _reachabilityRef;
    CTTelephonyNetworkInfo *_telephonyNetworkInfo;
}

@end

@implementation CGReachability


+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    CGReachability *returnValue             = nil;
    SCNetworkReachabilityRef reachability   = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    
    if (reachability != NULL) {
        
        returnValue = [[self alloc] init];
        if (returnValue != nil) {
            returnValue->_reachabilityRef   = reachability;
        }else {
            CFRelease(reachability);
        }
    }
    
    return returnValue;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
    CGReachability *returnValue             = nil;
    SCNetworkReachabilityRef reachability   = SCNetworkReachabilityCreateWithAddress(NULL, hostAddress);
    if (reachability != nil) {
        
        returnValue = [[self alloc] init];
        if (returnValue != nil) {
            returnValue->_reachabilityRef   = reachability;
        }else {
            CFRelease(reachability);
        }
    }
    
    return returnValue;
}

+ (instancetype)reachabilityWithInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family  = AF_INET;
    
    return [self reachabilityWithAddress: (const struct sockaddr *) &zeroAddress];
}

- (BOOL)startNotifier
{
    BOOL returnValue    = NO;
    
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context)) {
        
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)) {
            returnValue = YES;
        }
    }
    return returnValue;
}

- (void)stopNotifier
{
    if (_reachabilityRef != NULL) {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}

- (void)dealloc
{
    [self stopNotifier];
    if (_reachabilityRef != NULL) {
        CFRelease(_reachabilityRef);
    }
}

#pragma mark - Network Flag Handling 

- (CGReachabilityStatus)reachabilityStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        
        return CGReachabilityStatusNone;
    }
    
    CGReachabilityStatus returnValue    = CGReachabilityStatusNone;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
        returnValue = CGReachabilityStatusWiFi;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0 || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0) {
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
            returnValue = CGReachabilityStatusWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        
        returnValue = CGReachabilityStatusWWAN;
    }
    
    return returnValue;
}

- (CGReachabilityStatus)currentReachabilityStatus
{
    CGReachabilityStatus returnValue    = CGReachabilityStatusNone;
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags)) {
        returnValue = [self reachabilityStatusForFlags:flags];
    }
    return returnValue;
}

- (CGReachabilityWWANStatus)currentReachabilityWWANStatus
{
    if (self.currentReachabilityStatus != CGReachabilityStatusWWAN) {
        return CGReachabilityWWANStatusNone;
    }
    
    CGReachabilityWWANStatus returnValue    = CGReachabilityWWANStatusNone;
    if (_telephonyNetworkInfo == nil) {
        _telephonyNetworkInfo   = [[CTTelephonyNetworkInfo alloc] init];
    }
    
    NSString *status = _telephonyNetworkInfo.currentRadioAccessTechnology;
    
    static NSDictionary *wwanStatusDic  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSNumber *wwanStatus2G  = @(CGReachabilityWWANStatus2G);
        NSNumber *wwanStatus3G  = @(CGReachabilityWWANStatus3G);
        NSNumber *wwanStatus4G  = @(CGReachabilityWWANStatus4G);
        
        wwanStatusDic   = @{
                            CTRadioAccessTechnologyGPRS : wwanStatus2G,     // 2.5G 171Kbps
                            CTRadioAccessTechnologyEdge : wwanStatus2G,     // 2.75G 384Kbps
                            CTRadioAccessTechnologyWCDMA    : wwanStatus3G, // 3G 3.6Mbps/384Kbps
                            CTRadioAccessTechnologyHSDPA    : wwanStatus3G, // 3.5G 14.4Mbps/384Kbps
                            CTRadioAccessTechnologyHSUPA    : wwanStatus3G, // 3.75G 14.4Mbps/5.76Mbps
                            CTRadioAccessTechnologyCDMA1x   : wwanStatus3G, // 2.5G
                            CTRadioAccessTechnologyCDMAEVDORev0 : wwanStatus3G,
                            CTRadioAccessTechnologyCDMAEVDORevA : wwanStatus3G,
                            CTRadioAccessTechnologyCDMAEVDORevB : wwanStatus3G,
                            CTRadioAccessTechnologyeHRPD    : wwanStatus3G,
                            CTRadioAccessTechnologyLTE      : wwanStatus4G, // LTE:3.9G 150M/75M LTE-Advanced:4G 300M/150M
                            };
    });
    
    NSNumber *currentWWANStatusNumber   = wwanStatusDic[status];
    if (currentWWANStatusNumber) {
        returnValue = currentWWANStatusNumber.integerValue;
    }
    
    return returnValue;
}

@end

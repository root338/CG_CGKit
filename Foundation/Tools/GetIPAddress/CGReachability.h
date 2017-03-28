//
//  CGReachability.h
//  TestCG_CGKit
//
//  Created by DY on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <netinet/in.h>

/** 参考demo: https://developer.apple.com/library/content/samplecode/Reachability/Introduction/Intro.html#//apple_ref/doc/uid/DTS40007324-Intro-DontLinkElementID_2 */

NS_ASSUME_NONNULL_BEGIN

@class CGReachability;

typedef NS_ENUM(NSInteger, CGReachabilityStatus) {
    
    CGReachabilityStatusNone,
    CGReachabilityStatusWiFi,
    CGReachabilityStatusWWAN,
};

typedef NS_ENUM(NSInteger, CGReachabilityWWANStatus) {
    
    CGReachabilityWWANStatusNone,
    CGReachabilityWWANStatus2G,
    CGReachabilityWWANStatus3G,
    CGReachabilityWWANStatus4G,
};

extern NSString *kCGReachabilityChangeNotification;

typedef void (^CGReachabilityDidChangeCallback) (CGReachability *reachability);

@interface CGReachability : NSObject

@property (nonatomic, assign, readonly) CGReachabilityStatus currentReachabilityStatus;

@property (nonatomic, assign, readonly) CGReachabilityWWANStatus currentReachabilityWWANStatus;

@property (nullable, nonatomic, copy) CGReachabilityDidChangeCallback reachabilityDidChangeCallback;

+ (nullable instancetype)reachabilityWithHostName:(NSString *)hostName;

+ (nullable instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/** 判断本地网络状态 */
+ (instancetype)reachabilityWithInternetConnection;

- (BOOL)startNotifier;
- (void)stopNotifier;



@end

NS_ASSUME_NONNULL_END

//
//  CTTelephonyNetworkInfo+CGGetIMSI.m
//  QuickAskCommunity
//
//  Created by DY on 2016/12/16.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CTTelephonyNetworkInfo+CGGetIMSI.h"

@implementation CTTelephonyNetworkInfo (CGGetIMSI)

+ (NSString *)getIMSI
{
    CTTelephonyNetworkInfo *telephoyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier  = [telephoyNetworkInfo subscriberCellularProvider];
    
    NSString *mobileCountryCode     = carrier.mobileCountryCode;
    NSString *mobileNetworkCode     = carrier.mobileNetworkCode;
    
    if (mobileNetworkCode == nil && mobileCountryCode == nil) {
        return nil;
    }
    
    NSMutableString *mobileIMSI     = [NSMutableString string];
    if (mobileCountryCode) {
        [mobileIMSI appendString:mobileCountryCode];
    }
    if (mobileNetworkCode) {
        [mobileIMSI appendString:mobileNetworkCode];
    }
    
    if (mobileIMSI.length == 0) {
        return nil;
    }
    
    return mobileIMSI;
}

@end

//
//  CTTelephonyNetworkInfo+CGGetIMSI.h
//  QuickAskCommunity
//
//  Created by DY on 2016/12/16.
//  Copyright © 2016年 ym. All rights reserved.
//

#if __has_include(<CoreTelephony/CTTelephonyNetworkInfo.h>)
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 
 获取手机IMSI 信息
 
 IMSI：International Mobile Subscriber Identification Number 国际移动用户识别码
 
 IMSI = MCC + MNC + MSIN
 
 一部分叫MCC(Mobile Country Code 移动国家码)，MCC的资源由国际电联(ITU)统一分配，唯一识别移动用户所属的国家，MCC共3位，中国地区的MCC为460
 
 另一部分叫MNC(Mobile Network Code 移动网络号码)，用于识别移动客户所属的移动网络运营商。MNC由二到三个十进制数组成，例如中国移动MNC为00、02、07，中国联通的MNC为01、06、09，中国电信的MNC为03、05、11
 
 MSIN:Mobile Subscriber Identification Number ，移动客户识别号，唯一识别码共有10位。
 
 对应的 CTCarrier 类中的属性
    
    MCC     mobileCountryCode
 
    MNC     mobileNetworkCode
 
    MSIN    系统没有提供
 */
@interface CTTelephonyNetworkInfo (CGGetIMSI)

/** MCC+MNC @warning 获取的IMSI的信息不完整，MSIN获取不到 */
+ (nullable NSString *)getIMSI;

@end

NS_ASSUME_NONNULL_END

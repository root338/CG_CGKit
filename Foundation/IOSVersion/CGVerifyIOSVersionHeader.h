//
//  CGVerifyIOSVersionHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#ifndef CGVerifyIOSVersionHeader_h
#define CGVerifyIOSVersionHeader_h

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/** 当前系统版本 */
#define _CG_IOS_CURRENTVERIOS   [UIDevice currentDevice].systemVersion.floatValue



/** 当前版本是否是7.0之后的版本 */
#define _CG_IOS_7_0_AFTER       _CG_IOS_CURRENTVERIOS >= 7.0

/** 当前版本是否是8.0之前的版本 */
#define _CG_IOS_8_0_BEFORE      _CG_IOS_CURRENTVERIOS < 8.0

/** 当前版本是否是8.0之后的版本 */
#define _CG_IOS_8_0_AFTER       _CG_IOS_CURRENTVERIOS >= 8.0



/** 当前版本是否是9.0之后的版本 */
#define _CG_IOS_9_0_AFTER       _CG_IOS_CURRENTVERIOS >= 9.0

#endif /* CGVerifyIOSVersionHeader_h */

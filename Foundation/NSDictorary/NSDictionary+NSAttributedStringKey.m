//
//  NSDictionary+NSAttributedStringKey.m
//  TestCG_CGKit
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSDictionary+NSAttributedStringKey.h"

@implementation NSDictionary (NSAttributedStringKey)

+ (NSDictionary *)ml_attDictWithFont:(UIFont *)font color:(UIColor *)color
{
    return @{
             NSFontAttributeName : font,
             NSForegroundColorAttributeName : color,
             };
}

@end

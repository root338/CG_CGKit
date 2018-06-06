//
//  NSDictionary+NSAttributedStringKey.h
//  TestCG_CGKit
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NSAttributedStringKey)

+ (NSDictionary *)ml_attDictWithFont:(UIFont *)font color:(UIColor *)color;

@end

@interface NSMutableDictionary (NSAttributedStringKey)

@property (nonatomic, readonly) NSMutableDictionary * (^setAttFont) (UIFont *);
@property (nonatomic, readonly) NSMutableDictionary * (^setAttForegroundColor) (UIColor *);

@end

NS_ASSUME_NONNULL_END

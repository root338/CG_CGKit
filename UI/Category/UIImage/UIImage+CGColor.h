//
//  UIImage+CGColor.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (CGColor)

+ (nullable UIImage *)imageWithTintColor:(nullable UIColor *)tintColor;

+ (nullable UIImage *)imageWithTintColor:(nullable UIColor *)tintColor size:(CGSize)size;

+ (nullable UIImage *)imageWithTintColor:(nullable UIColor *)tintColor size:(CGSize)size capInset:(UIEdgeInsets)capInset;
@end
NS_ASSUME_NONNULL_END
//
//  UIImage+CGDrawIcon.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGArrowIconConfig, CGCloseIconConfig, CGRefreshIconConfig;
@interface UIImage (CGDrawIcon)

+ (UIImage *)drawArrowWithConfig:(CGArrowIconConfig *)arrowIconConfig;

+ (UIImage *)drawCloseWithConfig:(CGCloseIconConfig *)closeIconConfig;

+ (UIImage *)drawRefreshImageWithConfig:(CGRefreshIconConfig *)refreshImageConfig;
@end

NS_ASSUME_NONNULL_END

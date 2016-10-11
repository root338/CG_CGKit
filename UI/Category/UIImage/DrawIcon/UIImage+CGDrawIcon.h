//
//  UIImage+CGDrawIcon.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGArrowIconConfig, CGCloseIconConfig;
@interface UIImage (CGDrawIcon)

+ (UIImage *)drawArrowWithConfig:(CGArrowIconConfig *)arrowConfig;

+ (UIImage *)drawCloseWithConfig:(CGCloseIconConfig *)closeConfig;
@end

NS_ASSUME_NONNULL_END

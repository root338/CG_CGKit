//
//  UIBarButtonItem+CGCreate.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (CGCreate)

+ (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(nullable UIImage *)landscapeImage target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END

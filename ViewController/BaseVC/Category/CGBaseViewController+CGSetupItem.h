//
//  CGBaseViewController+CGSetupItem.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGBaseViewController (CGSetupItem)

- (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(nullable UIImage *)landscapeImage;
- (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(nullable UIImage *)landscapeImage target:(id)target action:(SEL)action;

@end
NS_ASSUME_NONNULL_END
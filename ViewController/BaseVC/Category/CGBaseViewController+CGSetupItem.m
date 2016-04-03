//
//  CGBaseViewController+CGSetupItem.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController+CGSetupItem.h"

@implementation CGBaseViewController (CGSetupItem)

- (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title
{
    return [self cg_createItemWithTitle:title target:self action:@selector(handleRightItemAction:)];
}

- (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

- (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage
{
    return [self cg_createItemWithImage:image landscapeImage:landscapeImage target:self action:@selector(handleLeftItemAction:)];
}

- (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithImage:image landscapeImagePhone:landscapeImage ? landscapeImage : image style:UIBarButtonItemStylePlain target:target action:action];
}

@end

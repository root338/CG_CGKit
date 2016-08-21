//
//  CGBaseViewController+CGSetupItem.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController+CGSetupItem.h"

#import "UIBarButtonItem+CGCreate.h"

@implementation CGBaseViewController (CGSetupItem)

- (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title
{
    return [UIBarButtonItem cg_createItemWithTitle:title target:self action:@selector(handleRightItemAction:)];
}

- (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage
{
    return [UIBarButtonItem cg_createItemWithImage:image landscapeImage:landscapeImage target:self action:@selector(handleLeftItemAction:)];
}

@end

//
//  UIBarButtonItem+CGCreate.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIBarButtonItem+CGCreate.h"

@implementation UIBarButtonItem (CGCreate)

+ (UIBarButtonItem *)cg_createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

+ (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    return [self cg_createItemWithImage:image landscapeImage:nil target:target action:action];
}

+ (UIBarButtonItem *)cg_createItemWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage target:(id)target action:(SEL)action
{
    landscapeImage  = landscapeImage ? landscapeImage : image;
    return [[self alloc] initWithImage:image landscapeImagePhone:landscapeImage style:UIBarButtonItemStylePlain target:target action:action];
}

@end

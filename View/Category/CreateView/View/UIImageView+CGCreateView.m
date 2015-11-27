//
//  UIImageView+CGCreateView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIImageView+CGCreateView.h"

@implementation UIImageView (CGCreateView)

+ (instancetype)cg_createImageViewWithContentMode:(UIViewContentMode)contentMode
{
    UIImageView *imageView = [[self alloc] init];
    imageView.contentMode = contentMode;
    return imageView;
}

@end

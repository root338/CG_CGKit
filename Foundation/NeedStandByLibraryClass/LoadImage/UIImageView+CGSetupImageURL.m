//
//  UIImageView+CGSetupImageURL.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIImageView+CGSetupImageURL.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (CGSetupImageURL)

- (void)cg_setupImageWithPath:(NSString *)imagePath
{
    if (imagePath) {
        NSURL *imageUrl = [NSURL URLWithString:imagePath];
        [self sd_setImageWithURL:imageUrl];
    }
}

@end

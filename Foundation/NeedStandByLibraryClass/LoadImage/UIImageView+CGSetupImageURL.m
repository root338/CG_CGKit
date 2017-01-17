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
    [self cg_setupImageWithPath:imagePath completion:nil];
}

- (void)cg_setupImageWithPath:(NSString *)imagePath completion:(void (^)(void))completion
{
    if (imagePath) {
        NSURL *imageUrl = [NSURL URLWithString:imagePath];
        [self sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (completion) {
                completion();
            }
        }];
    }else {
        if (completion) {
            completion();
        }
    }
}

@end

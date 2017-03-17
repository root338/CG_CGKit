//
//  UIImageView+CGSetupImageURL.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIImageView+CGSetupImageURL.h"
#import "NSError+CGCreateError.h"

@implementation UIImageView (CGSetupImageURL)

- (void)cg_setupImageWithPath:(NSString *)imagePath
{
    [self cg_setupImageWithPath:imagePath completion:nil];
}

- (void)cg_setupImageWithPath:(NSString *)imagePath completion:(nullable SDWebImageCompletionBlock)completion
{
    [self cg_setupImageWithPath:imagePath progress:nil completion:completion];
}

- (void)cg_setupImageWithPath:(NSString *)imagePath progress:(nullable SDWebImageDownloaderProgressBlock)progress completion:(nullable SDWebImageCompletionBlock)completion
{
    [self cg_setupImageWithPath:imagePath options:0 progress:progress completion:completion];
}

- (void)cg_setupImageWithPath:(NSString *)imagePath options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progress completion:(SDWebImageCompletionBlock)completion
{
    NSURL * imageUrl = [NSURL URLWithString:imagePath];
    
    [self sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRetryFailed progress:progress completed:completion];
}

@end

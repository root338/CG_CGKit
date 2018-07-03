//
//  UIImageView+CGSetupImageURL.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#if __has_include(<UIImageView+WebCache.h>) && __has_include(<SDWebImageManager.h>)

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CGSetupImageURL)

- (void)cg_setupImageWithPath:(nullable NSString *)imagePath;
- (void)cg_setupImageWithPath:(nullable NSString *)imagePath completion:(nullable SDExternalCompletionBlock)completion;

- (void)cg_setupImageWithPath:(nullable NSString *)imagePath progress:(nullable SDWebImageDownloaderProgressBlock)progress completion:(nullable SDExternalCompletionBlock)completion;

- (void)cg_setupImageWithPath:(nullable NSString *)imagePath options:(SDWebImageOptions)options progress:(nullable SDWebImageDownloaderProgressBlock)progress completion:(nullable SDExternalCompletionBlock)completion;
@end

NS_ASSUME_NONNULL_END

#endif

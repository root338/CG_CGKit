//
//  UIImageView+CGSetupImageURL.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (CGSetupImageURL)

- (void)cg_setupImageWithPath:(NSString *)imagePath;
- (void)cg_setupImageWithPath:(NSString *)imagePath completion:(void (^ _Nullable) (void))completion;


@end

NS_ASSUME_NONNULL_END

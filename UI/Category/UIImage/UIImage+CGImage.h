//
//  UIImage+CGImage.h
//  QuickAskCommunity
//
//  Created by DY on 2017/2/27.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGImage)

+ (nullable instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

//+ (instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode

+ (nullable instancetype)imageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;



@end

NS_ASSUME_NONNULL_END

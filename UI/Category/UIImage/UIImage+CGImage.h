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

#pragma mark - 加载图片
+ (nullable instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

//+ (instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode

+ (nullable instancetype)imageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

+ (nullable UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize;
+ (nullable UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize scale:(CGFloat)scale;

+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^) (UIImage * _Nullable image))completion;
+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^) (UIImage * _Nullable image))completion scale:(CGFloat)scale;

- (UIImage *)scaleImageWithEstimatedSize: (CGSize) estimatedSize;
- (UIImage *)scaleImageWithEstimatedSize: (CGSize) estimatedSize scale:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END

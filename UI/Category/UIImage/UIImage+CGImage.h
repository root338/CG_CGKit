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

#pragma mark - UIImage size 

/** 获取图片为JPEG时的大小(KB) */
@property (nonatomic, assign, readonly) NSUInteger imageSizeForJPEG;
/** 获取图片为PNG时的大小(KB) */
@property (nonatomic, assign, readonly) NSUInteger imageSizeForPNG;
/** 获取指定压缩值之后的图片大小 [0,1] */
- (NSUInteger)imageSizeWithCompressionQuality:(CGFloat)compressionQuality;

#pragma mark - 加载图片
+ (nullable instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

//+ (instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode

+ (nullable instancetype)imageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

+ (nullable UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize;
+ (nullable UIImage *)loadImageWithFilePath:(NSString *)filePath twiceAsMuchEstimatedSize:(CGSize)estimatedSize;
+ (nullable UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize scale:(CGFloat)scale;

+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^) (UIImage * _Nullable image))completion;
+ (void)asyncLoadImageWithFilePath:(NSString *)filePath twiceAsMuchEstimatedSize:(CGSize)estimatedSize completion:(void (^) (UIImage * _Nullable image))completion;
+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^) (UIImage * _Nullable image))completion scale:(CGFloat)scale;

- (UIImage *)scaleImageWithEstimatedSize:(CGSize)estimatedSize;
- (UIImage *)scaleImageWithTwiceAsMuchEstimatedSize:(CGSize)estimatedSize;

- (UIImage *)scaleImageWithEstimatedSize:(CGSize)estimatedSize scale:(CGFloat)scale;

- (UIImage *)drawImageWithSize:(CGSize)size drawRect:(CGRect)rect;

#pragma mark - 计算显示区域

- (CGRect)imageFrameWithSize:(CGSize)size contentModel:(UIViewContentMode)contentModel;
- (CGRect)imageFrameWithFrame:(CGRect)frame contentModel:(UIViewContentMode)contentModel;
@end

NS_ASSUME_NONNULL_END

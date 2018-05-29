//
//  UIImage+CGImage.m
//  QuickAskCommunity
//
//  Created by DY on 2017/2/27.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIImage+CGImage.h"

#import "UIView+CG_CGAreaCalculate.h"

@implementation UIImage (CGImage)

@dynamic imageSizeForPNG;
@dynamic imageSizeForJPEG;

#pragma mark - UIImage size

- (NSUInteger)imageSizeForJPEG
{
    return [self imageSizeWithCompressionQuality:1.0];
}

- (NSUInteger)imageSizeForPNG
{
    NSData *data    = UIImagePNGRepresentation(self);
    return data.length / 1024;
}

- (NSUInteger)imageSizeWithCompressionQuality:(CGFloat)compressionQuality
{
    NSData *data    = UIImageJPEGRepresentation(self, compressionQuality);
    NSUInteger imageSize  = data.length / 1024;
    return imageSize;
}

#pragma mark - 加载图片

+ (instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode
{
    UIImage *image  = [UIImage imageNamed:imageName];
    if (image == nil) {
        return nil;
    }
    return [image imageWithRenderingMode:renderingMode];
}

+ (instancetype)imageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *image  = [UIImage imageNamed:imageName];
    if (image == nil) {
        return image;
    }
    return [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
}

+ (UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize
{
    return [self loadImageWithFilePath:filePath estimatedSize:estimatedSize scale:1];
}

+ (UIImage *)loadImageWithFilePath:(NSString *)filePath twiceAsMuchEstimatedSize:(CGSize)estimatedSize
{
    return [self loadImageWithFilePath:filePath estimatedSize:estimatedSize scale:2];
}

+ (UIImage *)loadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize scale:(CGFloat)scale
{
    if (filePath.length == 0) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data.length <= 0) {
        return nil;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    UIImage *targetImage    = [image scaleImageWithEstimatedSize:estimatedSize scale:scale];
    
    return targetImage;
}

+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^)(UIImage * _Nullable))completion
{
    [self asyncLoadImageWithFilePath:filePath estimatedSize:estimatedSize completion:completion scale:1];
}

+ (void)asyncLoadImageWithFilePath:(NSString *)filePath twiceAsMuchEstimatedSize:(CGSize)estimatedSize completion:(void (^)(UIImage * _Nullable))completion
{
    [self asyncLoadImageWithFilePath:filePath estimatedSize:estimatedSize completion:completion scale:2];
}

+ (void)asyncLoadImageWithFilePath:(NSString *)filePath estimatedSize:(CGSize)estimatedSize completion:(void (^)(UIImage * _Nullable))completion scale:(CGFloat)scale
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *targetImage = [UIImage loadImageWithFilePath:filePath estimatedSize:estimatedSize scale:scale];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(targetImage);
            }
        });
    });
}

- (UIImage *)scaleImageWithEstimatedSize: (CGSize) estimatedSize
{
    return [self scaleImageWithEstimatedSize:estimatedSize scale:1];
}

- (UIImage *)scaleImageWithTwiceAsMuchEstimatedSize:(CGSize)estimatedSize
{
    return [self scaleImageWithEstimatedSize:estimatedSize scale:2];
}

- (UIImage *)scaleImageWithEstimatedSize:(CGSize)estimatedSize scale:(CGFloat)paramScale
{
    CGSize size = self.size;
    
    if (paramScale > 1) {
        estimatedSize   = CGSizeMake(estimatedSize.width * paramScale, estimatedSize.height * paramScale);
    }
    
    CGFloat scalex = estimatedSize.width / size.width;
    CGFloat scaley = estimatedSize.height / size.height;
    CGFloat scale = MIN(scalex, scaley);
    
    UIGraphicsBeginImageContext(estimatedSize);
    
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    
    float dwidth = ((estimatedSize.width - width) / 2.0f);
    float dheight = ((estimatedSize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    [self drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

- (UIImage *)drawImageWithSize:(CGSize)size drawRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    [self drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

#pragma mark - 计算显示区域

- (CGRect)imageFrameWithFrame:(CGRect)frame contentModel:(UIViewContentMode)contentModel
{
    CGRect imageFrame = [self imageFrameWithSize:frame.size contentModel:contentModel];
    imageFrame.origin   = CGPointMake(CGRectGetMinX(imageFrame) + CGRectGetMinX(frame), CGRectGetMinY(imageFrame) + CGRectGetMinY(frame));
    return imageFrame;
}

- (CGRect)imageFrameWithSize:(CGSize)size contentModel:(UIViewContentMode)contentModel
{
    CGRect frame = CGRectZero;
    
    CGSize imageSize = self.size;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    switch (contentModel) {
        case UIViewContentModeTop:
            x = CG_CGCenterOriginX(imageSize.width, size.width);
            break;
        case UIViewContentModeTopRight:
            x = size.width - imageSize.width;
            break;
        case UIViewContentModeRight:
            x = size.width - imageSize.width;
            y = CG_CGCenterOriginY(imageSize.height, size.height);
            break;
        case UIViewContentModeBottomRight:
            x = size.width - imageSize.width;
            y = size.height - imageSize.height;
            break;
        case UIViewContentModeBottom:
            x = CG_CGCenterOriginX(imageSize.width, size.width);
            y = size.height - imageSize.height;
            break;
        case UIViewContentModeBottomLeft:
            y = size.height - imageSize.height;
            break;
        case UIViewContentModeLeft:
            y = CG_CGCenterOriginY(imageSize.height, size.height);
            break;
        case UIViewContentModeCenter:
            x = CG_CGCenterOriginX(imageSize.width, size.width);
            y = CG_CGCenterOriginY(imageSize.height, size.height);
            break;
        case UIViewContentModeScaleToFill:
            width = size.width;
            height = size.height;
            break;
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
        {
            
            CGFloat s1 = imageSize.width / size.width;
            CGFloat s2 = imageSize.height / size.height;
            if (s1 < s2) {
                if (UIViewContentModeScaleAspectFit == contentModel) {
                    width   = imageSize.width / s2;
                    height  = size.height;
                }else {
                    width   = size.width;
                    height  = imageSize.height / s1;
                }
            }else {
                if (UIViewContentModeScaleAspectFit == contentModel) {
                    width   = size.width;
                    height  = imageSize.height / s2;
                }else {
                    width   = imageSize.width / s1;
                    height  = size.height;
                }
            }
            
            x = CG_CGCenterOriginX(width, size.width);
            y = CG_CGCenterOriginY(height, size.height);
            break;
        }
        default:
            break;
    }
    
    frame = CGRectMake(x, y, width, height);
    
    return frame;
}

@end

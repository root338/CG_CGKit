//
//  UIImage+CGImage.m
//  QuickAskCommunity
//
//  Created by DY on 2017/2/27.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIImage+CGImage.h"

@implementation UIImage (CGImage)

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

@end

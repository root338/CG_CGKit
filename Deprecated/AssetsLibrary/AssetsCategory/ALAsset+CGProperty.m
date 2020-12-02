//
//  ALAsset+CGProperty.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ALAsset+CGProperty.h"
#import "CGPrintLogHeader.h"

@implementation ALAsset (CGProperty)

- (CGAssetType)assetType
{
    CGAssetType assetType;
    NSString *propertyType = [self valueForProperty:ALAssetPropertyType];
    if ([propertyType isEqualToString:ALAssetTypePhoto]) {
        assetType   = CGAssetTypePhoto;
    }else if ([propertyType isEqualToString:ALAssetTypeVideo]) {
        assetType   = CGAssetTypeVideo;
    }else {
        assetType   = CGAssetTypeUnknown;
    }
    return assetType;
}

- (NSString *)assetName
{
    ALAssetRepresentation *representation   = [self defaultRepresentation];
    return representation.filename;
}

- (UIImage *)cg_assetImageWithType:(CGAssetImageType)type
{
    CGConditionLog((type == CGAssetImageTypeFullResolutionImage || type == CGAssetImageTypeFullScreenImage), @"加载大图建议使用cg_assetImageWithType:completion:方法");
    return [self _cg_assetImageWithType:type];
}

- (void)cg_assetImageWithType:(CGAssetImageType)type completion:(void (^)(UIImage * _Nullable))completion
{
    CGConditionLog((type == CGAssetImageTypeSquareThumbnails || type == CGAssetImageTypeAspectRatioThumbnails), @"加载小图建议使用cg_assetImageWithType:方法");
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf    = self;
    dispatch_async(global, ^{
        
        __block UIImage *thumbnailsImage = nil;
        dispatch_sync(global, ^{
            
            thumbnailsImage = [weakSelf _cg_assetImageWithType:type];
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(thumbnailsImage);
            }
        });
    });
}

- (nullable UIImage *)_cg_assetImageWithType:(CGAssetImageType)type
{
    CGImageRef imageRef;
    switch (type) {
        case CGAssetImageTypeAspectRatioThumbnails:
            imageRef    = [self aspectRatioThumbnail];
            break;
        case CGAssetImageTypeSquareThumbnails:
            imageRef    = [self thumbnail];
            break;
        case CGAssetImageTypeFullResolutionImage:
            imageRef    = [self defaultRepresentation].fullResolutionImage;
            break;
        case CGAssetImageTypeFullScreenImage:
            imageRef    = [self defaultRepresentation].fullScreenImage;
            break;
        default:
            break;
    }
    
    UIImage *thumbnailsImage = nil;;
    if (imageRef) {
        thumbnailsImage = [UIImage imageWithCGImage:imageRef];
    }
    return thumbnailsImage;
}

@end

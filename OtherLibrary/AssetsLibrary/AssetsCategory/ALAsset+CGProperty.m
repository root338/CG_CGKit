//
//  ALAsset+CGProperty.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ALAsset+CGProperty.h"

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
    CGImageRef imageRef;
    switch (type) {
        case CGAssetImageTypeAspectRatioThumbnails:
            imageRef    = [self aspectRatioThumbnail];
            break;
        case CGAssetImageTypeSquareThumbnails:
            imageRef    = [self thumbnail];
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

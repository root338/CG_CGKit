//
//  CGAssetModel.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetModel.h"

@interface CGAssetModel ()

/** 名称 */
@property (nullable, nonatomic, strong, readwrite) NSString *assetsName;

/** 资源的类型 */
@property (nonatomic, assign, readwrite) CGAssetType assetType;

/** 缩略图 */
@property (nullable, nonatomic, strong, readwrite) UIImage *thumbnailsImage;

@end

@implementation CGAssetModel

+ (instancetype)createAssetModelWithAsset:(ALAsset *)asset thumbnailsType:(CGThumbnailsType)type
{
    if (!asset) {
        return nil;
    }
    
    CGAssetModel *assetModel    = [[self alloc] initWithAsset:asset thumbnailsType:type];
    return assetModel;
}

- (instancetype)initWithAsset:(ALAsset *)asset thumbnailsType:(CGThumbnailsType)type
{
    self = [super init];
    if (self && asset) {
        
        _assetsName         = [self fileNameWithAsset:asset];
        _assetType          = [self assetTypeWithAsset:asset];
        _thumbnailsImage    = [self thumbnailsImageWithAsset:asset thumbnailsType:type];
    }
    return self;
}

#pragma mark - 具体资源获取
/** 获取资源名 */
- (nullable NSString *)fileNameWithAsset:(ALAsset *)asset
{
    ALAssetRepresentation *representation   = [asset defaultRepresentation];
    return representation.filename;
}

/** 转化图片视频资源类型 */
- (CGAssetType)assetTypeWithAsset:(ALAsset *)asset
{
    CGAssetType assetType;
    NSString *propertyType = [asset valueForProperty:ALAssetPropertyType];
    if ([propertyType isEqualToString:ALAssetTypePhoto]) {
        assetType   = CGAssetTypePhoto;
    }else if ([propertyType isEqualToString:ALAssetTypeVideo]) {
        assetType   = CGAssetTypeVideo;
    }else {
        assetType   = CGAssetTypeUnknown;
    }
    return assetType;
}

/** 获取指定缩略图的图片 */
- (UIImage *)thumbnailsImageWithAsset:(ALAsset *)asset thumbnailsType:(CGThumbnailsType)type
{
    CGImageRef imageRef;
    switch (type) {
        case CGThumbnailsTypeAspectRatio:
            imageRef    = [asset aspectRatioThumbnail];
            break;
        case CGThumbnailsTypeSquare:
            imageRef    = [asset thumbnail];
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

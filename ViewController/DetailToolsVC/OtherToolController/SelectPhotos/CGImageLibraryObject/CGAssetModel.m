//
//  CGAssetModel.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetModel.h"

#import "CGVerifyIOSVersionHeader.h"

@import Photos;
#import "ALAsset+CGProperty.h"

@implementation CGAssetModel

- (UIImage *)cg_getImage:(void (^)(UIImage *))completion
{
    if (_CG_IOS_8_0_AFTER) {
        
        return [self cg_getPHAssetImage:completion info:nil];
    }else {
        return [self cg_getALAssetImage:completion];
    }
}

- (UIImage *)cg_getImage:(void (^)(UIImage *))image resultInfo:(void (^)(NSDictionary * _Nullable))resultImageInfo
{
    return [self cg_getPHAssetImage:image info:resultImageInfo];
}

- (UIImage *)cg_getALAssetImage:(void (^)(UIImage *))completion
{
    UIImage *thumbnails = [self.assetDetail cg_assetImageWithType:CGAssetImageTypeAspectRatioThumbnails];
    [self.assetDetail cg_assetImageWithType:CGAssetImageTypeFullScreenImage completion:completion];
    return thumbnails;
}

- (UIImage *)cg_getPHAssetImage:(void (^)(UIImage *))imageBlock info:(void (^) (NSDictionary *))infoBlock
{
    [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:self.targetSize contentMode:self.contentMode options:self.options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (imageBlock) {
            imageBlock(result);
        }
        if (infoBlock) {
            infoBlock(info);
        }
    }];
    return nil;
}

- (instancetype)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithAssetDetail:(ALAsset *)asset
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

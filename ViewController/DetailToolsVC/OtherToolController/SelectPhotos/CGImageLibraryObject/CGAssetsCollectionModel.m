//
//  CGAssetsCollectionModel.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetsCollectionModel.h"

@import Photos;

#import "ALAssetsGroup+CGProperty.h"
#import "PHAssetCollection+CGGetValue.h"

@interface CGAssetsCollectionModel ()

/** 相册图片 */
@property (nonatomic, strong) UIImage *posterAssetsCollectionImage;

/** 相册名称 */
@property (nonatomic, strong, readwrite) NSString *assetsCollectionName;

/** 相册的照片数 */
@property (nonatomic, assign, readwrite) NSInteger numberOfAssets;

@end

@implementation CGAssetsCollectionModel

+ (instancetype)cg_createAssetsCollectionWith:(PHAssetCollection *)assetsCollection
{
    return [[CGAssetsCollectionModel alloc] initWithAssetCollection:assetsCollection];
}

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection
{
    self = [super init];
    if (self) {
        
        _assetsCollectionName           = assetCollection.localizedTitle;
        _numberOfAssets                 = assetCollection.numberOfAssets;
    }
    return self;
}

+ (instancetype)cg_createAssetsGroupWith:(ALAssetsGroup *)assetsGroup
{
    return [[CGAssetsCollectionModel alloc] initWithAssetsGroup:assetsGroup];
}

- (instancetype)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    self = [super init];
    if (self) {
        _posterAssetsCollectionImage    = assetsGroup.posterAssetsGroupImage;
        _assetsCollectionName           = assetsGroup.assetsGroupName;
        _numberOfAssets                 = assetsGroup.numberOfAssets;
    }
    return self;
}

- (void)posterAssetsCollectionImage:(void (^)(UIImage * _Nonnull))completion
{
    if (self.posterAssetsCollectionImage) {
        if (completion) {
            completion(self.posterAssetsCollectionImage);
        }
        return;
    }
    
}
@end

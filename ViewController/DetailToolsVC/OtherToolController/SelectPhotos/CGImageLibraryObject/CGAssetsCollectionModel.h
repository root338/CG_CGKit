//
//  CGAssetsCollectionModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@class ALAssetsGroup;
@class PHAssetCollection;

/** 相册具体类 */
@interface CGAssetsCollectionModel : CGBaseObject

/** 相册名称 */
@property (nonatomic, strong, readonly) NSString *assetsCollectionName;

/** 相册的照片数 */
@property (nonatomic, assign, readonly) NSInteger numberOfAssets;

#pragma mark - ALAssetsGroup
@property (nullable, nonatomic, strong, readonly) ALAssetsGroup *assetsGroup NS_DEPRECATED_IOS(4_0, 8_0, "请使用 assetCollection 属性");
+ (instancetype)cg_createAssetsGroupWith:(ALAssetsGroup *)assetsGroup NS_DEPRECATED_IOS(4_0, 8_0, "请使用 cg_createAssetsCollectionWith: 方法");
- (instancetype)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup NS_DEPRECATED_IOS(4_0, 8_0, "请使用 initWithAssetCollection: 方法");

#pragma mark - PHAssetCollection
+ (instancetype)cg_createAssetsCollectionWith:(PHAssetCollection *)assetsCollection NS_AVAILABLE_IOS(8_0);
@property (nullable, nonatomic, strong, readonly) PHAssetCollection *assetCollection NS_AVAILABLE_IOS(8_0);
- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection NS_AVAILABLE_IOS(8_0);

/** 获取相册封面 */
- (void)posterAssetsCollectionImage:(void (^) (UIImage *posterAssetImage))completion;

@end

NS_ASSUME_NONNULL_END
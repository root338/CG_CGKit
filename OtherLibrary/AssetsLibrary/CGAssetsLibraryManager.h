//
//  CGAssetsLibraryManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "CGAssetsFilterTypeHeader.h"

@class CGAssetModel;
@class CGAssetsGroupModel;
@class CGAssetsFilterObject;


NS_ASSUME_NONNULL_BEGIN
/** 照片管理类 */
@interface CGAssetsLibraryManager : NSObject

+ (instancetype)sharedManager;

/** 获取的资源类型 */
@property (nonatomic, assign) CGAssetsFilterType assetsFilterType;

/** 获取单个资源的排序方式 */
@property (nonatomic, assign) CGAssetsSequenceType assetsSequenceType;

#pragma mark - 获取资源数组
/** 获取所有的图片视频数组(ALAssetsGroup) */
- (void)cg_assetsGroupsWithGroupsType:(ALAssetsGroupType)groupType assetsGroups:(void (^) ( NSArray<ALAssetsGroup *> * _Nullable paramAssetsGroup))assetsGroupsBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;
/** 获取所有的图片视频数组(CGAssetsGroupModel) */
- (void)cg_assetsGroupsModelListWithGroupsType:(ALAssetsGroupType)groupType assetsGroupsModelList:(void (^)(NSArray<CGAssetsGroupModel *> * _Nullable paramAssetsGroupModelList))assetsGroupsModelListBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

#pragma mark - 获取单个资源数组
/** 获取图片视频组下的指定资源数组(ALAsset) */
- (nullable NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType;
/** 获取图片视频组下的指定资源数组(CGAssetModel) */
- (nullable NSArray<CGAssetModel *> *)cg_assetModelListWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType;

/** 获取指定类型下的所有指定资源 */
- (void)cg_assetsListWithAssetsFilter:(CGAssetsFilterObject *)assetsFilter assetList:(void (^) (NSArray<ALAsset *> * _Nullable paramAssetList))assetListBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
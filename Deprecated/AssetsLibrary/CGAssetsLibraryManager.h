//
//  CGAssetsLibraryManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "CGAssetsFilterTypeHeader.h"

@class CGAssetsFilterObject;


NS_ASSUME_NONNULL_BEGIN
/** 照片管理类 */
@interface CGAssetsLibraryManager : CGBaseObject

//+ (instancetype)sharedManager;

/** 获取的资源类型 默认为CGAssetsFilterTypeAll */
@property (nonatomic, assign) CGAssetsFilterType assetsFilterType;

/** 获取单个资源的排序方式 默认为CGAssetsSequenceTypeDescending */
@property (nonatomic, assign) CGAssetsSequenceType assetsSequenceType;

/** 设置照片组的排序方式 默认为CGAssetsGroupFilterTypeValue1 */
@property (nonatomic, assign) CGAssetsGroupFilterType assetsGroupFilterType;

/** 是否添加数量为 0 的相册，默认为NO，不添加 */
@property (nonatomic, assign) BOOL isAddZeroNumberAssetsGroup;

#pragma mark - 获取资源数组
/** 获取所有的图片视频数组(ALAssetsGroup) */
- (void)cg_assetsGroupsWithGroupsType:(ALAssetsGroupType)groupType assetsGroups:(void (^) ( NSArray<ALAssetsGroup *> * _Nullable paramAssetsGroup))assetsGroupsBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

#pragma mark - 获取单个资源数组
/** 获取图片视频组下的指定资源数组(ALAsset) */
- (NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup;

/** 获取图片视频组下的指定资源数组(ALAsset) */
- (nullable NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType;

/** 
 *  获取指定类型下的所有指定资源
 */
- (void)cg_assetsListWithAssetsFilter:(CGAssetsFilterObject *)assetsFilter assetList:(void (^) (NSArray<ALAsset *> * _Nullable paramAssetList))assetListBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

/**
 *  获取指定类型下的所有指定资源
 */
- (void)cg_assetsListWithAssetsGroupType:(ALAssetsGroupType)assetsGroupType assetList:(void (^) (NSArray<ALAsset *> * _Nullable paramAssetList))assetListBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
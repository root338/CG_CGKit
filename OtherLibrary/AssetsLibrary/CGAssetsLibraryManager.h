//
//  CGAssetsLibraryManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

/**
 *  获取图片视频资源的类型
 */
typedef NS_ENUM(NSInteger, CGAssetsFilterType) {
    /**
     *  所有资源
     */
    CGAssetsFilterTypeAll,
    /**
     *  视频资源
     */
    CGAssetsFilterTypeAllVideos,
    /**
     *  图片资源
     */
    CGAssetsFilterTypeAllPhotos,
};

NS_ASSUME_NONNULL_BEGIN
/** 照片管理类 */
@interface CGAssetsLibraryManager : NSObject

+ (instancetype)sharedManager;

/** 获取的资源类型 */
@property (nonatomic, assign) CGAssetsFilterType assetsFilterType;

/** 获取所有的图片视频数组 */
- (NSArray<ALAssetsGroup *> *)cg_assetsGroupsWithGroupsType:(ALAssetsGroupType)groupType failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock;

/** 获取图片视频组下的图片视图数组 */
- (nullable NSArray<ALAsset *> *)cg_assetsWithGroup:(nullable ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType;
@end
NS_ASSUME_NONNULL_END
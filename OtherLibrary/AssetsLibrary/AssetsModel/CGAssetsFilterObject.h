//
//  CGAssetsFilterObject.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "CGAssetTypeHeader.h"
#import "CGAssetsFilterTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN
/** 图片筛选类 */
@interface CGAssetsFilterObject : NSObject

/** 获取资源组的类型 */
@property (nonatomic, assign) ALAssetsGroupType assetsGroupType;

/** 获取的图片资源类型 */
@property (nonatomic, assign) CGAssetsFilterType assetsFilterType;

/** 获取单个资源缩略图的类型 */
@property (nonatomic, assign) CGThumbnailsType assetThumbnailsType;

/** 图片排序方式 */
@property (nonatomic, assign) CGAssetsSequenceType assetsSequenceType;

@end

NS_ASSUME_NONNULL_END
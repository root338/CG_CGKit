//
//  CGAssetModel.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "CGAssetTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN
/** 单个资源简单信息类 */
@interface CGAssetModel : NSObject

/** 名称 */
@property (nullable, nonatomic, strong, readonly) NSString *assetsName;

/** 资源的类型 */
@property (nonatomic, assign, readonly) CGAssetType assetType;

/** 缩略图 */
@property (nullable, nonatomic, strong, readonly) UIImage *thumbnailsImage;

+ (instancetype)createAssetModelWithAsset:(ALAsset *)asset thumbnailsType:(CGThumbnailsType)type;

- (instancetype)initWithAsset:(ALAsset *)asset thumbnailsType:(CGThumbnailsType)type;
@end
NS_ASSUME_NONNULL_END
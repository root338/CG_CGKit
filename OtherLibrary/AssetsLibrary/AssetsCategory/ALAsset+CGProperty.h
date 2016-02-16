//
//  ALAsset+CGProperty.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import <UIKit/UIKit.h>

#import "CGAssetTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN
@interface ALAsset (CGProperty)

/** 资源类型 */
@property (nonatomic, assign, readonly) CGAssetType assetType;

/** 资源名称 */
@property (nullable, nonatomic, strong, readonly) NSString *assetName;

/** 获取指定类型图片 */
- (nullable UIImage *)cg_assetImageWithType:(CGAssetImageType)type;

@end
NS_ASSUME_NONNULL_END
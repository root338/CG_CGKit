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

/** 
 *  获取指定类型图片
 *  @param 适合CGAssetImageTypeSquareThumbnails, CGAssetImageTypeAspectRatioThumbnails类型的缩略图
 */
- (nullable UIImage *)cg_assetImageWithType:(CGAssetImageType)type;

/** 
 *  获取指定类型图片 
 *  @param  适合CGAssetImageTypeFullScreenImage, CGAssetImageTypeFullResolutionImage大尺寸图片
 */
- (void)cg_assetImageWithType:(CGAssetImageType)type completion:(void (^) (UIImage * _Nullable didLoadImage))completion;

@end
NS_ASSUME_NONNULL_END
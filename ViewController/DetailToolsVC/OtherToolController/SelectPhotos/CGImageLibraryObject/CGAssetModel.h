//
//  CGAssetModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import <Photos/PhotosTypes.h>

NS_ASSUME_NONNULL_BEGIN

@class ALAsset;
@class PHAsset;
@class PHImageRequestOptions;

/** 相片具体类 */
@interface CGAssetModel : CGBaseObject

/** 直接返回的是压缩图片，block回调的是大图 */
- (nullable UIImage *)cg_getImage:(void (^) (UIImage * _Nullable image))completion;
- (nullable UIImage *)cg_getImage:(void (^)(UIImage * _Nullable image))imageBlock resultInfo:(void (^ _Nullable) (NSDictionary * _Nullable info))imageInfoBlock NS_AVAILABLE_IOS(8_0);

@property (nullable, nonatomic, strong, readonly) ALAsset *assetDetail NS_DEPRECATED_IOS(4_0, 8_0, "请使用 asset 属性");
- (instancetype)initWithAssetDetail:(ALAsset *)asset NS_DEPRECATED_IOS(4_0, 8_0, "请使用 initWithAsset: 方法");

@property (nullable, nonatomic, strong, readonly) PHAsset *asset NS_AVAILABLE_IOS(8_0);
@property (nonatomic, assign) CGSize targetSize NS_AVAILABLE_IOS(8_0);
@property (nonatomic, assign) PHImageContentMode contentMode NS_AVAILABLE_IOS(8_0);
@property (nullable, nonatomic, strong) PHImageRequestOptions *options NS_AVAILABLE_IOS(8_0);

- (instancetype)initWithAsset:(PHAsset *)asset NS_AVAILABLE_IOS(8_0);
@end
NS_ASSUME_NONNULL_END
//
//  PHAssetCollection+CGGetValue.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
@interface PHAssetCollection (CGGetValue)

/** 相册的数量 */
@property (nonatomic, assign, readonly) NSInteger numberOfAssets;

/** 相册中的图片资源 */
@property (nullable, nonatomic, strong, readonly) PHFetchResult<PHAsset *> *fetchResultAsset;

/** 获取相册的封面 */
- (void)getPosterAssetsCollectionImage:(void (^) (UIImage *image))completion;
@end
NS_ASSUME_NONNULL_END
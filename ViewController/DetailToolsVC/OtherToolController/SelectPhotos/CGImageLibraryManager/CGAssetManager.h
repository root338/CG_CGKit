//
//  CGAssetManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGBlockHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGAssetModel;
@class CGAssetsCollectionModel;

typedef void (^CGAssetsBlock) (NSArray <CGAssetModel *> * _Nullable  assetsArray);

@interface CGAssetManager : CGBaseObject

/** 获取指定相册的图片列表 */
- (void)cg_getAssetsCollection:(CGAssetsCollectionModel *)assetsCollection completion:(CGAssetsBlock)completion failureBlock:(nullable CGErrorBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
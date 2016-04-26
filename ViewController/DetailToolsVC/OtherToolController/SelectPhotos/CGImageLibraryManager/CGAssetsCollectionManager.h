//
//  CGAssetsCollectionManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGBlockHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGAssetsLibraryManager;
@class CGAssetsCollectionModel;

typedef void (^CGAssetsCollectionBlock) (NSArray <CGAssetsCollectionModel *> * _Nullable  assetsCollectionArray);

/** 相册管理器 */
@interface CGAssetsCollectionManager : CGBaseObject

/** 图片资源管理类 */
@property (nonatomic, strong, readonly) CGAssetsLibraryManager *assetsLibraryManager NS_DEPRECATED_IOS(4_0, 8_0, "AssetsLibrary 的管理类，iOS 8以后应使用Phots库");

/** 获取相册列表 */
- (void)cg_getAssetsCollectionCompletion:(CGAssetsCollectionBlock)completion failureBlock:(nullable CGErrorBlock)failureBlock;


@end
NS_ASSUME_NONNULL_END
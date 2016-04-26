//
//  CGImageLibraryManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

#import "CGAssetsCollectionManager.h"

NS_ASSUME_NONNULL_BEGIN


@class CGAssetsCollectionModel;
/** 照片管理器 */
@interface CGImageLibraryManager : CGBaseObject

/** 相册管理类 */
@property (nonatomic, strong, readonly) CGAssetsCollectionManager *assetsCollectionManager;

@end
NS_ASSUME_NONNULL_END
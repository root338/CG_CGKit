//
//  CGPhotoListViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

@class CGAssetsCollectionModel;

NS_ASSUME_NONNULL_BEGIN
/** 照片浏览列表 */
@interface CGPhotoListViewController : CGBaseViewController

/** 图片组 */
@property (nullable, nonatomic, strong) CGAssetsCollectionModel *assetsCollection;

+ (instancetype)cg_createPhotoList;
@end
NS_ASSUME_NONNULL_END
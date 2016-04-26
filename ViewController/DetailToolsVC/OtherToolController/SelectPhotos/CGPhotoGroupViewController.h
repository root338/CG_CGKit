//
//  CGPhotoGroupViewController.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

@class CGAssetsCollectionModel;

NS_ASSUME_NONNULL_BEGIN
/** 相片组 */
@interface CGPhotoGroupViewController : CGBaseViewController

@property (nonatomic, strong) NSArray<CGAssetsCollectionModel *> * assetsCollection;

@end
NS_ASSUME_NONNULL_END
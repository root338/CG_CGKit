//
//  CGAssetsGroupModel.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN
/** 资源组信息类 */
@interface CGAssetsGroupModel : NSObject

/** 相册组名称 */
@property (nullable, nonatomic, strong, readonly) NSString *assetsGroupName;

/** 相册封面图片 */
@property (nullable, nonatomic, strong, readonly) UIImage *posterImage;

/** 相册数目 */
@property (nonatomic, assign, readonly) NSInteger numberOfAssets;

+ (instancetype)createAssetsGroupWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

- (instancetype)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

@end
NS_ASSUME_NONNULL_END
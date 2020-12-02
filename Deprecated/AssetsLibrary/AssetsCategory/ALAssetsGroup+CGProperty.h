//
//  ALAssetsGroup+CGProperty.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALAssetsGroup (CGProperty)

/** 相册组名称 */
@property (nullable, nonatomic, strong, readonly) NSString *assetsGroupName;

/** 相册封面图片 */
@property (nullable, nonatomic, strong, readonly) UIImage *posterAssetsGroupImage;

/** 相册的类型 */
@property (nonatomic, assign, readonly) ALAssetsGroupType assetsGroupType;
@end
NS_ASSUME_NONNULL_END
//
//  CGPhotoNavigationController.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@class CGAssetsLibraryManager;

@interface CGPhotoNavigationController : CGNavigationController

/** 选择照片的最大数 默认为 1 */
@property (nonatomic, assign) NSInteger selectedMaxNumber;

/** 选择照片的最小数 默认为 1 */
@property (nonatomic, assign) NSInteger selectedMinNumber;

/** 
 *  创建默认的图片浏览导航栏
 *  @param 自动加载相机胶卷相册视图
 */
+ (instancetype)cg_createDefalutNavigationController;

/** 图片资源管理类 */
@property (nonatomic, strong) CGAssetsLibraryManager *assetsLibraryManager;
@end
NS_ASSUME_NONNULL_END
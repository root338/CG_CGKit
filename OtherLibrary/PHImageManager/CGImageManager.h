//
//  CGImageManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import <Photos/PHPhotoLibrary.h>

NS_ASSUME_NONNULL_BEGIN
NS_CLASS_AVAILABLE_IOS(8_0) @interface CGImageManager : CGBaseObject

#pragma mark - 验证是否有获取相册的权限
/** 
 *  获取相册的权限 
 *  @param 直接获取当前相应的权限
 */
+ (void)cg_photoLibraryAuthorizationCompletion:(void (^) (PHAuthorizationStatus status))completion;

/**
 *  获取是否拥有访问相册的权限
 *  @param 没有标识，直接返回有无权限访问相册
 */
+ (void)cg_photoLibraryIsHasAuthorizationCompletion:(void (^)(BOOL isHasAuthorization))completion;


@end
NS_ASSUME_NONNULL_END
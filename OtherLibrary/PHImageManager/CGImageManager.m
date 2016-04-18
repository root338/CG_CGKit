//
//  CGImageManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGImageManager.h"

@implementation CGImageManager

#pragma mark - 验证是否有获取相册的权限
+ (void)cg_photoLibraryAuthorizationCompletion:(void (^)(PHAuthorizationStatus))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status != PHAuthorizationStatusNotDetermined) {
        if (completion) {
            completion(status);
        }
        return;
    }
    
    [PHPhotoLibrary requestAuthorization:completion];
}

+ (void)cg_photoLibraryIsHasAuthorizationCompletion:(void (^)(BOOL))completion
{
    [self cg_photoLibraryAuthorizationCompletion:^(PHAuthorizationStatus status) {
        
        BOOL isHasAuthorization = NO;
        if (status == PHAuthorizationStatusAuthorized) {
            isHasAuthorization  = YES;
        }
        if (completion) {
            completion(isHasAuthorization);
        }
    }];
}

@end

//
//  PHAssetCollection+CGGetValue.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PHAssetCollection+CGGetValue.h"

#import <objc/runtime.h>

@interface PHAssetCollection (_CGGetValue)

@property (nonatomic, assign) PHImageRequestID requestImageID;

@end

@implementation PHAssetCollection (_CGGetValue)

- (void)setRequestImageID:(PHImageRequestID)requestID
{
    objc_setAssociatedObject(self, @selector(requestImageID), @(requestID), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PHImageRequestID)requestImageID
{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

@end

@implementation PHAssetCollection (CGGetValue)

- (void)getPosterAssetsCollectionImage:(void (^)(UIImage * _Nonnull))completion
{
    
}

#pragma mark - 设置属性

- (NSInteger)numberOfAssets
{
    return self.fetchResultAsset.count;
}

- (PHFetchResult<PHAsset *> *)fetchResultAsset
{
    PHFetchResult<PHAsset *> *fetchResult       = objc_getAssociatedObject(self, _cmd);
    if (fetchResult == nil) {
        PHFetchResult<PHAsset *> *fetchResult   = [PHAsset fetchAssetsInAssetCollection:self options:nil];
        objc_setAssociatedObject(self, @selector(fetchResultAsset), fetchResult, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return fetchResult;
}

@end

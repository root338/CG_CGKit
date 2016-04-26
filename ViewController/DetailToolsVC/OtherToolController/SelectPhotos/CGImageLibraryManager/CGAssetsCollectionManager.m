//
//  CGAssetsCollectionManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetsCollectionManager.h"

@import Photos;

#import "CGAssetsLibraryManager.h"
#import "CGAssetsCollectionModel.h"

#import "CGVerifyIOSVersionHeader.h"

@interface CGAssetsCollectionManager ()

@property (nonatomic, strong) NSArray<CGAssetsCollectionManager *> *assetsCollectionDataSource;

/** 图片资源管理类 */
@property (nonatomic, strong, readwrite) CGAssetsLibraryManager *assetsLibraryManager;

@end

@implementation CGAssetsCollectionManager

- (void)cg_getAssetsCollectionCompletion:(CGAssetsCollectionBlock)completion failureBlock:(nullable CGErrorBlock)failureBlock
{
    if (_CG_IOS_8_0_AFTER) {
        
    }else {
        [self cg_getAssetsGroupCompletion:completion failureBlock:failureBlock];
    }
}

/** 使用 AssetsLibrary 库获取相册列表 */
- (void)cg_getAssetsGroupCompletion:(CGAssetsCollectionBlock)completion failureBlock:(nullable CGErrorBlock)failureBlock
{
    
    [self.assetsLibraryManager cg_assetsGroupsWithGroupsType:ALAssetsGroupAll assetsGroups:^(NSArray<ALAssetsGroup *> * _Nullable paramAssetsGroup) {
        
        __block NSMutableArray *assetsCollectionArray       = nil;
        if (paramAssetsGroup.count) {
            assetsCollectionArray   = [NSMutableArray arrayWithCapacity:paramAssetsGroup.count];
            [paramAssetsGroup enumerateObjectsUsingBlock:^(ALAssetsGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CGAssetsCollectionModel *model  = [CGAssetsCollectionModel cg_createAssetsGroupWith:obj];
                [assetsCollectionArray addObject:model];
            }];
        }
        if (completion) {
            completion(assetsCollectionArray);
        }
        
    } failureBlock:failureBlock];
}

/** 使用 PHAssetCollection 库获取相册列表 */
- (void)cg_getAssetCollectionCompletion:(CGAssetsCollectionBlock)completion
{
    
    PHFetchResult<PHAssetCollection *> *fetctResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    __block NSMutableArray<CGAssetsCollectionModel *> *assetCollectionArray = nil;
    if (fetctResult.count) {
        assetCollectionArray    = [NSMutableArray arrayWithCapacity:fetctResult.count];
        [fetctResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGAssetsCollectionModel *model  = [CGAssetsCollectionModel cg_createAssetsCollectionWith:obj];
            [assetCollectionArray addObject:model];
        }];
    }
    
    if (completion) {
        completion(assetCollectionArray);
    }
}

#pragma mark - 设置属性
- (CGAssetsLibraryManager *)assetsLibraryManager
{
    if (_assetsLibraryManager) {
        return _assetsLibraryManager;
    }
    
    _assetsLibraryManager = [[CGAssetsLibraryManager alloc] init];;
    
    return _assetsLibraryManager;
}


@end

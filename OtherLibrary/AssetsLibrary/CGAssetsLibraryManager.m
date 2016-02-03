//
//  CGAssetsLibraryManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetsLibraryManager.h"



@interface CGAssetsLibraryManager ()
{
    ALAssetsFilter *_assetsFilter;
}
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong, readonly) ALAssetsFilter *assetsFilter;
@end

@implementation CGAssetsLibraryManager

+ (instancetype)sharedManager
{
    static CGAssetsLibraryManager *libraryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libraryManager  = [[CGAssetsLibraryManager alloc] init];
    });
    return libraryManager;
}

- (void)cg_verify
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusAuthorized:   //有权限访问
            
            break;
        case ALAuthorizationStatusDenied:       //没有权限访问
            
            break;
        case ALAuthorizationStatusNotDetermined:    //用户还没有选择是否可以访问
            
            break;
        case ALAuthorizationStatusRestricted:       //家长控制，无法访问
            
            break;
        default:
            break;
    }
}

#pragma mark - 创建资源对象
- (ALAssetsFilter *)cg_assetsFilterWithType:(CGAssetsFilterType)type
{
    if (_assetsFilter) {
        return _assetsFilter;
    }
    switch (type) {
        case CGAssetsFilterTypeAll:
            _assetsFilter   = [ALAssetsFilter allAssets];
            break;
        case CGAssetsFilterTypeAllPhotos:
            _assetsFilter   = [ALAssetsFilter allPhotos];
            break;
        case CGAssetsFilterTypeAllVideos:
            _assetsFilter   = [ALAssetsFilter allVideos];
            break;
        default:
            break;
    }
    return _assetsFilter;
}

#pragma mark - 获取资源
- (NSArray<ALAssetsGroup *> *)cg_assetsGroupsWithGroupsType:(ALAssetsGroupType)groupType failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock
{
    NSMutableArray *assetsGroup = [NSMutableArray array];
    
    [self.assetsLibrary enumerateGroupsWithTypes:groupType usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [assetsGroup addObject:group];
    } failureBlock:failureBlock];
    
    return assetsGroup;
}

- (NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType
{
    if (!assetsGroup) {
        return nil;
    }
    
    NSMutableArray *assetsList  = [NSMutableArray array];
    
    self.assetsFilterType       = assetsFilterType;
    [assetsGroup setAssetsFilter:self.assetsFilter];
    
    [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        [assetsList addObject:result];
    }];
    
    return assetsList;
}

#pragma mark - 设置属性

- (ALAssetsLibrary *)assetsLibrary
{
    if (_assetsLibrary) {
        return _assetsLibrary;
    }
    
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    return _assetsLibrary;
}

- (void)setAssetsFilterType:(CGAssetsFilterType)assetsFilterType
{
    if (_assetsFilterType != assetsFilterType) {
        
        _assetsFilterType   = assetsFilterType;
        [self cg_assetsFilterWithType:assetsFilterType];
    }
}

- (ALAssetsFilter *)assetsFilter
{
    return [self cg_assetsFilterWithType:self.assetsFilterType];
}

@end

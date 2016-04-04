//
//  CGAssetsLibraryManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetsLibraryManager.h"

#import "CGAssetsFilterObject.h"

@interface CGAssetsLibraryManager ()
{
    ALAssetsFilter *_assetsFilter;
}

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong, readonly) ALAssetsFilter *assetsFilter;

@property (nonatomic, assign) BOOL isCache;
/** 缓存的图片数组集合 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSArray<ALAssetsGroup *> *> *cacheAssetsGroupDictionary;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSArray<ALAsset *> *> *cacheAssetsDictionary;
@end

@implementation CGAssetsLibraryManager

//+ (instancetype)sharedManager
//{
//    static CGAssetsLibraryManager *sharedManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedManager  = [[CGAssetsLibraryManager alloc] init];
//    });
//    return sharedManager;
//}

- (void)initialization
{
    _isCache                = YES;
    self.assetsFilterType   = CGAssetsFilterTypeAllPhotos;
    self.assetsSequenceType = CGAssetsSequenceTypeDescending;
    
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    if (_isCache) {
        _cacheAssetsGroupDictionary = [NSMutableDictionary dictionary];
        _cacheAssetsDictionary      = [NSMutableDictionary dictionary];
    }
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

#pragma mark - 图片视频集资源处理
- (void)cg_assetsGroupsWithGroupsType:(ALAssetsGroupType)groupType assetsGroups:(nonnull void (^)(NSArray<ALAssetsGroup *> * _Nullable))assetsGroupsBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock
{
    if (self.isCache) {
        NSArray<ALAssetsGroup *> *tempAssetsGroup   = [self.cacheAssetsGroupDictionary objectForKey:@(groupType)];
        if (tempAssetsGroup) {
            if (assetsGroupsBlock) {
                assetsGroupsBlock(tempAssetsGroup);
            }
            
            return;
        }
    }
    
    NSMutableArray *assetsGroup = [NSMutableArray array];
    
    [self.assetsLibrary enumerateGroupsWithTypes:groupType usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            [assetsGroup addObject:group];
        }else {
            if (self.isCache) {
                
                !assetsGroup ?: [self.cacheAssetsGroupDictionary setObject:assetsGroup forKey:@(groupType)];
            }
            //当图片视频组为空时，资源结束
            if (assetsGroupsBlock) {
                assetsGroupsBlock(assetsGroup);
            }
        }
    } failureBlock:failureBlock];
}

#pragma mark - 图片视频单个对象资源处理
- (NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup
{
    return [self cg_assetsWithGroup:assetsGroup assetsFilterType:self.assetsFilterType];
}

- (NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType
{
    return [self cg_assetsWithGroup:assetsGroup assetsFilterType:assetsFilterType flag:YES];
}

/** 
 @param flag 标识是否进行时间排序，YES进行排序，NO不进行排序
 */
- (NSArray<ALAsset *> *)cg_assetsWithGroup:(ALAssetsGroup *)assetsGroup assetsFilterType:(CGAssetsFilterType)assetsFilterType flag:(BOOL)flag
{
    if (!assetsGroup) {
        return nil;
    }
    
    
    NSArray        *assets      = nil;
    NSMutableArray *assetsList  = [NSMutableArray arrayWithCapacity:assetsGroup.numberOfAssets];
    
    self.assetsFilterType       = assetsFilterType;
    [assetsGroup setAssetsFilter:self.assetsFilter];
    
    [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            [assetsList addObject:result];
        }
    }];
    
    
    if (flag) {
        assets  = [self cg_assetsSequenceWithOldAssets:assetsList type:self.assetsSequenceType];
    }else {
        assets  = assetsList;
    }
    
    return assets;
}

/** 对图片视频集按时间排序 */
- (NSArray<ALAsset *> *)cg_assetsSequenceWithOldAssets:(NSArray<ALAsset *> *)oldAssets type:(CGAssetsSequenceType)sequenceType
{
    if (sequenceType == CGAssetsSequenceTypeDefault) {
        return oldAssets;
    }
    
    return [oldAssets sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        ALAsset *asset1 = obj1;
        ALAsset *asset2 = obj2;
        
        NSDate *date1   = [asset1 valueForProperty:ALAssetPropertyDate];
        NSDate *date2   = [asset2 valueForProperty:ALAssetPropertyDate];
        NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
        
        NSComparisonResult comparisonResult = NSOrderedSame;
        if (timeInterval != 0) {
            
            if (sequenceType == CGAssetsSequenceTypeAscending) {
                
                if (timeInterval > 0) {
                    comparisonResult    = NSOrderedDescending;
                }else {
                    comparisonResult    = NSOrderedAscending;
                }
            }else if (sequenceType == CGAssetsSequenceTypeDescending){
                
                if (timeInterval > 0) {
                    comparisonResult    = NSOrderedAscending;
                }else {
                    comparisonResult    = NSOrderedDescending;
                }
            }
        }
        
        return comparisonResult;
    }];
}

- (void)cg_assetsListWithAssetsFilter:(CGAssetsFilterObject *)assetsFilter assetList:(nonnull void (^)(NSArray<ALAsset *> * _Nullable))assetListBlock failureBlock:(nullable ALAssetsLibraryAccessFailureBlock)failureBlock
{
    [self cg_assetsListWithAssetsGroupType:assetsFilter.assetsGroupType assetsFilterType:assetsFilter.assetsFilterType assetsSequenceType:assetsFilter.assetsSequenceType assetList:assetListBlock failureBlock:failureBlock];
}

- (void)cg_assetsListWithAssetsGroupType:(ALAssetsGroupType)assetsGroupType assetList:(void (^)(NSArray<ALAsset *> * _Nullable))assetListBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock
{
    
    [self cg_assetsListWithAssetsGroupType:assetsGroupType assetsFilterType:self.assetsFilterType assetsSequenceType:self.assetsSequenceType assetList:assetListBlock failureBlock:failureBlock];
}

- (void)cg_assetsListWithAssetsGroupType:(ALAssetsGroupType)assetsGroupType assetsFilterType:(CGAssetsFilterType)assetsFilterType assetsSequenceType:(CGAssetsSequenceType)assetsSequenceType assetList:(void (^)(NSArray<ALAsset *> * _Nullable))assetListBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock
{
    __weak __block typeof(self) weakself = self;
    [self cg_assetsGroupsWithGroupsType:assetsGroupType assetsGroups:^(NSArray<ALAssetsGroup *> * _Nullable paramAssetsGroup) {
        
        NSArray<ALAsset *> *assetList = nil;
        if (paramAssetsGroup.count) {
            NSMutableArray<ALAsset *> *assetListArray = [NSMutableArray array];
            [paramAssetsGroup enumerateObjectsUsingBlock:^(ALAssetsGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray<ALAsset *> *assets  = [weakself cg_assetsWithGroup:obj assetsFilterType:assetsFilterType flag:NO];
                if (assets) {
                    [assetListArray addObjectsFromArray:assets];
                }
            }];
            assetList   = [weakself cg_assetsSequenceWithOldAssets:assetListArray type:assetsSequenceType];
        }
        
        if (assetListBlock) {
            assetListBlock(assetList);
        }
    } failureBlock:failureBlock];
}

#pragma mark - 设置属性

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

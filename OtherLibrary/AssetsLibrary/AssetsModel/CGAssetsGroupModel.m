//
//  CGAssetsGroupModel.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAssetsGroupModel.h"

@interface CGAssetsGroupModel ()

/** 相册组名称 */
@property (nullable, nonatomic, strong, readwrite) NSString *assetsGroupName;

/** 相册封面图片 */
@property (nullable, nonatomic, strong, readwrite) UIImage *posterImage;

/** 相册数目 */
@property (nonatomic, assign, readwrite) NSInteger numberOfAssets;

@end

@implementation CGAssetsGroupModel

+ (instancetype)createAssetsGroupWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    if (!assetsGroup) {
        return nil;
    }
    return [[self alloc] initWithAssetsGroup:assetsGroup];
}

- (instancetype)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    self = [super init];
    if (self && assetsGroup) {
        _assetsGroupName    = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        _numberOfAssets     = [assetsGroup numberOfAssets];
        
        CGImageRef imageRef = [assetsGroup posterImage];
        if (imageRef) {
            _posterImage    = [UIImage imageWithCGImage:imageRef];
        }
    }
    return self;
}

@end

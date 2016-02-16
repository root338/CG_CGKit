//
//  CGAssetTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGAssetTypeHeader_h
#define CGAssetTypeHeader_h

/**
 *  图片视频资源的类型
 */
typedef NS_ENUM(NSInteger, CGAssetType) {
    /**
     *  未知
     */
    CGAssetTypeUnknown,
    /**
     *  图片类型
     */
    CGAssetTypePhoto,
    /**
     *  视频类型
     */
    CGAssetTypeVideo,
};

/**
 *  缩略图的类型
 */
typedef NS_ENUM(NSInteger, CGThumbnailsType) {
    /**
     *  方形
     */
    CGThumbnailsTypeSquare,
    /**
     *  等比
     */
    CGThumbnailsTypeAspectRatio,
};

#endif /* CGAssetTypeHeader_h */

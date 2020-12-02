//
//  CGAssetsFilterTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGAssetsFilterTypeHeader_h
#define CGAssetsFilterTypeHeader_h

/**
 *  获取图片视频资源的类型
 */
typedef NS_ENUM(NSInteger, CGAssetsFilterType) {
    /**
     *  所有资源
     */
    CGAssetsFilterTypeAll,
    /**
     *  所有视频资源
     */
    CGAssetsFilterTypeAllVideos,
    /**
     *  所有图片资源
     */
    CGAssetsFilterTypeAllPhotos,
};

/**
 *  照片数组排序方式
 */
typedef NS_ENUM(NSInteger, CGAssetsGroupFilterType) {
    /**
     *  默认
     */
    CGAssetsGroupFilterTypeDefault,
    /**
     *  内部自定义好的排序，相机胶卷提前，其他默认
     */
    CGAssetsGroupFilterTypeValue1,
    /**
     *  按数量升序
     */
    CGAssetsGroupFilterTypeNumberAscending,
    /**
     *  按数量降序
     */
    CGAssetsGroupFilterTypeNumberDescending,
};

/**
 *  图片排序方式
 */
typedef NS_ENUM(NSInteger, CGAssetsSequenceType) {
    
    /**
     *  默认顺序
     */
    CGAssetsSequenceTypeDefault,
    
    /**
     *  时间升序，从过去最远时间到现在
     */
    CGAssetsSequenceTypeAscending,
    
    /**
     *  时间降序，从现在时间到过去最远
     */
    CGAssetsSequenceTypeDescending,
};

#endif /* CGAssetsFilterTypeHeader_h */

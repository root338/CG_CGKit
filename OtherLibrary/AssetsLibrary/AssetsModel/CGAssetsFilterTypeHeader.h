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

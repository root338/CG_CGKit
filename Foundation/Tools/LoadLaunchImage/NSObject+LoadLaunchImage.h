//
//  NSObject+LoadLaunchImage.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  加载当前分辨率启动图的错误类型
 */
typedef NS_ENUM(NSInteger, CGLoadLaunchImageErrorType){
    /**
     *  没有错误
     */
    CGLoadLaunchImageErrorTypeNone,
    /**
     *  没有当前启动图key值
     */
    CGLoadLaunchImageErrorTypeNullKey,
    /**
     *  没有当前启动图
     */
    CGLoadLaunchImageErrorTypeNullImage,
    
    /**
     *  默认图片路径中没有相应图片资源
     */
    CGLoadLaunchImageErrorTypeDefaultImagePathNullImage,
};

@interface NSObject (LoadLaunchImage)

////////////////////////////////////////////////////////////////////////////////////////
//方法一

//--------------------------加载启动图

//确定：launchImageDictionary为固定资源，需要不断更新
////////////////////////////////////////////////////////////////////////////////////////
/** 当前启动图字典 */
@property (nonatomic, readonly) NSDictionary *launchImageDictionary;

/** 使用固定键值对加载启动图 */
- (UIImage *)cg_load_type_fixedResource_CurrentPixelsImageWithErrorType:(CGLoadLaunchImageErrorType *)errorType;

////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////
//方法二

//说明：通过获取app根路径下所有图片资源，寻找LaunchImage开头的图片，再判断图片是否与当前分辨率是否一致
//从而得到相应启动图片
//--------------------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////////////

/** 加载本地所有图片名称遍历加载启动图 */
- (UIImage *)cg_load_type_enumImagesResource_CurrentPixelsImageWithEorrType:(CGLoadLaunchImageErrorType *)errorType;
////////////////////////////////////////////////////////////////////////////////////////
@end

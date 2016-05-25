//
//  UIImage+CGResizableImage.h
//  QuickAskCommunity
//
//  Created by DY on 16/5/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (CGResizableImage)

/** 加载本地图片，并以中心进行拉伸 */
+ (UIImage *)cg_resizableImageWithCapCenterImageName:(NSString *)imageName;


@end
NS_ASSUME_NONNULL_END
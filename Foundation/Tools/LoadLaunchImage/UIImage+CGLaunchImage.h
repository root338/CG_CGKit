//
//  UIImage+CGLaunchImage.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CGLaunchImage)

/** 获取当前加载的启动图片 */
+ (UIImage *)cg_currentLaunchImage;
@end

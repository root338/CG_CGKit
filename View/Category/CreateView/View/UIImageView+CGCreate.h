//
//  UIImageView+CGCreate.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CGCreate)

+ (UIImageView *)cg_createImageName:(NSString *)imageName;

+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode;

+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode capInsets:(UIEdgeInsets)capInsets;

/**
 *  创建一个UIImageView
 *
 *  @param imageName    本地图片的名字
 *  @param contentMode  图片显示的方式
 *  @param capInsets    图片拉伸的方式
 *  @param resizingMode 图片拉伸的类型，平铺／拉伸
 *
 *  @return 返回创建好的UIImageView
 */
+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

@end

NS_ASSUME_NONNULL_END
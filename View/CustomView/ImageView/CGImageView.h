//
//  CGZoomImageView.h
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 可以对图片进行缩放
 */
@interface CGImageView : CGBaseView

@property (nonatomic, readonly) UIImageView *imageView;

@property (nonatomic, strong, readonly) UIScrollView *imageScrollView;

/** 是否禁止缩放 默认 NO*/
@property (nonatomic, assign) BOOL disableScale;
/** 是否禁止双击缩放 默认 NO  */
@property (nonatomic, assign) BOOL disableDoubleScale;

/** 双击放大的倍数 默认 1.5 */
@property (nonatomic, assign) CGFloat zoomMultiple;

/** 添加单击事件处理方法 */
- (void)addSingleTapTarget:(id)target action:(SEL)action;
/** 移除单击事件处理方法 */
- (void)removeSingleTapTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
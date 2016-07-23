//
//  CGAlertArrowAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/23.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

/** 弹层箭头样式 */
@interface CGAlertArrowAppearance : NSObject

#pragma mark - 画布设置
/** 画布大小 */
@property (nonatomic, assign) CGSize canvasSize;
/** 是否不透明 @param YES：不透明，NO：透明 */
@property (nonatomic, assign) BOOL opaque;
/** 图片的缩放比例 */
@property (nonatomic, assign) CGFloat scale;

/** 背景色 */
@property (nullable, nonatomic, strong) UIColor *canvasBackgroundColor;



@end


NS_ASSUME_NONNULL_END
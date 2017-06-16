//
//  UIView+CGViewCategory.h
//  QuickAskCommunity
//
//  Created by DY on 2017/6/16.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGViewCategory)

/**
 在使用swift时，和
 - (CGPoint)convertPoint:(CGPoint)point toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
 - (CGPoint)convertPoint:(CGPoint)point fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
 - (CGRect)convertRect:(CGRect)rect toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
 - (CGRect)convertRect:(CGRect)rect fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
 方法会转为一样的形式，避免 冲突
 */
//

- (CGPoint)cg_convertPoint:(CGPoint)point toView:(nullable UIView *)view;
- (CGPoint)cg_convertPoint:(CGPoint)point fromView:(nullable UIView *)view;
- (CGRect)cg_convertRect:(CGRect)rect toView:(nullable UIView *)view;
- (CGRect)cg_convertRect:(CGRect)rect fromView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END

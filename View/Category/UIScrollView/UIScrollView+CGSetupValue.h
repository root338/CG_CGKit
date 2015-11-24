//
//  UIScrollView+CGSetupValue.h
//  TestProject
//
//  Created by DY on 15/11/24.
//  Copyright © 2015年 -. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 改变UIScrollView一些属性值 */
@interface UIScrollView (CGSetupValue)

#pragma mark - 偏移量
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat offsetY;

- (void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated;
- (void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated;
@end

//
//  UIView+CGCreateViews.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CGCreateViewsAppearance;
@interface UIView (CGCreateViews)

- (void)cg_createViewsWithRule:(CGCreateViewsAppearance *)viewsRule subview:(__kindof UIView * (^) (NSInteger index))setupSubview;

@end
NS_ASSUME_NONNULL_END
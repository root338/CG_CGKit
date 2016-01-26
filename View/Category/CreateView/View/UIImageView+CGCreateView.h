//
//  UIImageView+CGCreateView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CGCreateView)

+ (instancetype)cg_createImageViewWithContentMode:(UIViewContentMode)contentMode;

@end

NS_ASSUME_NONNULL_END
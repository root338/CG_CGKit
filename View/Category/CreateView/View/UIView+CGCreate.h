//
//  UIView+CGCreate.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGCreate)

+ (instancetype)cg_createView;

+ (instancetype)cg_createClearColorView;

+ (instancetype)cg_createViewWithBackgroundColor:(UIColor *)backgroundColor;
@end
NS_ASSUME_NONNULL_END

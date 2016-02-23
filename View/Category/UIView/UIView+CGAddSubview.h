//
//  UIView+CGAddSubview.h
//  QuickAskCommunity
//
//  Created by DY on 16/2/22.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (CGAddSubview)

- (void)cg_addSubviews:(NSArray<UIView *> *)subviews;

@end
NS_ASSUME_NONNULL_END
//
//  UIView+CGUpdateLayout.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/10.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 更新布局 */
@interface UIView (CGUpdateLayout)

- (void)updateWithOneView:(UIView *)oneView twoView:(UIView *)twoView marginEdgeInsets:(UIEdgeInsets)marginEdgeInsets subviewSpace:(CGFloat)subviewSpace;

@end

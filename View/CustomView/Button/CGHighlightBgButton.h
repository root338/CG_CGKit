//
//  CGHighlightBgButton.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseButton.h"

/** 自定义在按钮不同状态显示不同背景色 */
@interface CGHighlightBgButton : CGBaseButton

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state;

- (nullable UIColor *)backgroundColorForState:(UIControlState)state;
@end

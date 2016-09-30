//
//  UIView+CGUpdateViewLayout.h
//  QuickAskCommunity
//
//  Created by DY on 16/9/30.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CGUpdateViewLayout)

- (void)cg_updateConstraintsIfNeeded;
- (void)cg_layoutIfNeeded;

/** 重绘标记调用 setNeedsDisplay, setNeedsDisplayInRect:方法 */

@end

@interface UITableViewCell (CGUpdateCellLayout)

- (void)cg_updateContentLayoutIfNeeded;

@end

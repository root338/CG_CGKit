//
//  UITableView+CGScrolling.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITableView (CGScrolling)

/** 将表格滑动到底部 */
- (void)cg_tableViewScrollingToBottom;

/** 将表格滑动到底部，是否动画 */
- (void)cg_tableViewScrollingToBottomIsAnimated:(BOOL)isAnimated;

@end
NS_ASSUME_NONNULL_END
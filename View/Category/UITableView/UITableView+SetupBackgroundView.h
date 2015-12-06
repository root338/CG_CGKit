//
//  UITableView+SetupBackgroundView.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/22.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SetupBackgroundView)

/**
 *  为表格添加背景视图 
 *  主要用于在需要跟随tableView滑动而移动（比如：下拉刷新时背景视图也随着滑动而移动），系统的backgroundView 不满足需求
 *  @warning 不会自动随着页面的frame变化为自动变化，需要在tableView变化后手动设置，建议在优先考虑使用系统backgroundView属性
 */
@property (strong, nonatomic) UIView * bgCustomView;

@end

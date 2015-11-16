//
//  UIView+CGSearchView.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 搜索视图 */
@interface UIView (CGSearchView)

/** 搜索指定类型的父视图 */
- (id)searchSuperViewWithClass:(Class)className;

@end

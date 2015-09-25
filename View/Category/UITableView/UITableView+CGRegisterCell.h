//
//  UITableView+CGRegisterCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CGRegisterCell)

/** 当注册的标识与类名相同时，注册cell的快捷方法 */
- (void)cg_registerClassWithClassIdentifier:(nullable Class)cellClassIdentifier NS_AVAILABLE_IOS(6_0);

- (void)cg_registerNib:(nullable UINib *)nib forCellReuseClass:(nullable Class)identifier NS_AVAILABLE_IOS(5_0);
- (void)cg_registerClass:(nullable Class)cellClass forCellReuseClass:(nullable Class)identifier NS_AVAILABLE_IOS(6_0);

- (void)cg_registerNib:(nullable UINib *)nib forHeaderFooterViewReuseClass:(nullable Class)identifier NS_AVAILABLE_IOS(6_0);
- (void)cg_registerClass:(nullable Class)aClass forHeaderFooterViewReuseClass:(nullable Class)identifier NS_AVAILABLE_IOS(6_0);

@end

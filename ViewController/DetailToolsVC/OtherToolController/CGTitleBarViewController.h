//
//  CGTitleBarViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGTitleBarViewController : CGNavigationBarViewController

/** 当回退按钮为空时隐藏 */
@property (nonatomic, assign) BOOL isHiddenNullBackItemTitle;

/** 回退按钮的标题 */
@property (nullable, nonatomic, strong) NSString *backItemTitle;

/** 回退按钮的属性，key：为不同状态下按钮的样式 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary<NSString *, id> *> *backItemTitleAttributesDict;

/** 
 *  设置左边按钮 
 *  @warning 如果子类重写了该方法，leftItemTitle属性和cg_setTitleTextAttributes:forState:type方法设置的内容会无效，需要自行实现
 */
- (nullable NSArray<UIBarButtonItem *> *)setupLeftItemButtons;
/** 
 *  设置右边按钮 
 *  @warning 如果子类重写了该方法，rightItemTitle属性和cg_setTitleTextAttributes:forState:type方法设置的内容会无效，需要自行实现
 */
- (nullable NSArray<UIBarButtonItem *> *)setupRightItemButtons;

/** 设置回退按钮 */
- (nullable UIBarButtonItem *)setupBackItemButton;

/** 回退按钮触发的方法 */
- (void)handleBackItemAction:(nullable id)sender;

@end
NS_ASSUME_NONNULL_END
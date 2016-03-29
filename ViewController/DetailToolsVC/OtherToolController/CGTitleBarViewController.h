//
//  CGTitleBarViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGTitleBarItemType) {

    CGTitleBarItemTypeLeft,
    CGTitleBarItemTypeRight,
};

@interface CGTitleBarViewController : CGNavigationBarViewController

/** 顶部左上角按钮的标题 */
@property (nullable, nonatomic, strong) NSString *leftItemTitle;
/** 顶部右上角按钮的标题 */   //父类已定义
//@property (nullable, nonatomic, strong) NSString *rightItemTitle;

/** 顶部左上角按钮的属性，key：为不同状态下按钮的样式 */
@property (nullable, nonatomic, strong, readonly) NSMutableDictionary<NSNumber *, NSDictionary *> *leftItemTitleAttributesDict;
/** 顶部右上角按钮的属性，key：为不同状态下按钮的样式 */
@property (nullable, nonatomic, strong, readonly) NSMutableDictionary<NSNumber *, NSDictionary *> *rightItemTitleAttributesDict;

/** 设置指定标题的属性 */
- (void)cg_setTitleTextAttributes:(nullable NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state type:(CGTitleBarItemType)type;

/** 顶部左上角按钮的图片 */
@property (nullable, nonatomic, strong) UIImage *leftItemImage;
/** 顶部右上角按钮的图片 */   //父类已定义
//@property (nullable, nonatomic, strong) UIImage *rightItemImage;

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

/** dismiss后回调block */
@property (nullable, nonatomic, copy) void (^dismissViewControllerCompletion) (void);

/** 左边按钮触发的方法 */
- (void)handleLeftItemAction:(id)sender;
/** 右边按钮触发的方法 */
- (void)handleRightItemAction:(id)sender;


@end
NS_ASSUME_NONNULL_END
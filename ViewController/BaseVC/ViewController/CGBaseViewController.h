//
//  CGBaseViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGTitleBarItemType) {
    
    CGTitleBarItemTypeLeft,
    CGTitleBarItemTypeRight,
    CGTitleBarItemTypeBack,
};

@protocol CGBaseViewControllerDelegate <NSObject>

@required
/** 重置回退标题为空 */
- (BOOL)shouldDisableResetBackTitleIsNull;

@end

NS_ASSUME_NONNULL_BEGIN
@interface CGBaseViewController : UIViewController<CGBaseViewControllerDelegate>

/** 右边导航栏标题 */
@property (nullable, nonatomic, strong) NSString *rightItemTitle;
/** 右边导航栏图片 */
@property (nullable, nonatomic, strong) UIImage *rightItemImage;
/** 右边导航栏横向时的图片，为nil时与rightItemImage图片相同 */
@property (nullable, nonatomic, strong) UIImage *rightLandscapeImage;
/** 顶部右上角按钮的属性，key：为不同状态下按钮的样式 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary<NSString *, id> *> *rightItemTitleAttributesDict;

/** 右边导航栏标题 */
@property (nullable, nonatomic, strong) NSString *leftItemTitle;
/** 右边导航栏图片 */
@property (nullable, nonatomic, strong) UIImage *leftItemImage;
/** 右边导航栏横向时的图片，为nil时与rightItemImage图片相同 */
@property (nullable, nonatomic, strong) UIImage *leftLandscapeImage;
/** 顶部左上角按钮的属性，key：为不同状态下按钮的样式 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary<NSString *, id> *> *leftItemTitleAttributesDict;

/** 设置指定标题的属性 */
- (BOOL)cg_setTitleTextAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state type:(CGTitleBarItemType)type;

/** 视图为model加载，dismiss后回调block */
@property (nullable, nonatomic, copy) void (^dismissViewControllerCompletion) (void);

/** 左边按钮触发的方法 */
- (void)handleLeftItemAction:(nullable id)sender;
/** 右边按钮触发的方法 */
- (void)handleRightItemAction:(nullable id)sender;
@end
NS_ASSUME_NONNULL_END

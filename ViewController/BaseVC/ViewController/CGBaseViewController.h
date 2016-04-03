//
//  CGBaseViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CGBaseViewController : UIViewController

/** 右边导航栏标题 */
@property (nullable, nonatomic, strong) NSString *rightItemTitle;
/** 右边导航栏图片 */
@property (nullable, nonatomic, strong) UIImage *rightItemImage;
/** 右边导航栏横向时的图片，为nil时与rightItemImage图片相同 */
@property (nullable, nonatomic, strong) UIImage *rightLandscapeImage;

/** 右边导航栏标题 */
@property (nullable, nonatomic, strong) NSString *leftItemTitle;
/** 右边导航栏图片 */
@property (nullable, nonatomic, strong) UIImage *leftItemImage;
/** 右边导航栏横向时的图片，为nil时与rightItemImage图片相同 */
@property (nullable, nonatomic, strong) UIImage *leftLandscapeImage;

/** 视图为model加载，dismiss后回调block */
@property (nullable, nonatomic, copy) void (^dismissViewControllerCompletion) (void);

/** 左边按钮触发的方法 */
- (void)handleLeftItemAction:(id)sender;
/** 右边按钮触发的方法 */
- (void)handleRightItemAction:(id)sender;
@end
NS_ASSUME_NONNULL_END
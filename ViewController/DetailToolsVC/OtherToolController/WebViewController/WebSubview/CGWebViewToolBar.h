//
//  CGWebBottomView.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGWebViewToolBarHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebViewToolBar;
@protocol CGWebViewToolBarDelegate <NSObject>

@optional
- (void)webViewToolBar:(CGWebViewToolBar *)webViewToolBar itemType:(CGWebViewItemType)itemType;

@end

/** 网页工具栏 */
@interface CGWebViewToolBar : UIToolbar

@property (nullable, nonatomic, copy) void (^actionCallback) (CGWebViewItemType actionType);

@property (nonatomic, weak) id<CGWebViewToolBarDelegate> toolBarProxyDelegate;

/** 里面对象应为(CGWebViewItemType 类型的数字对象) */
@property (nullable, nonatomic, strong, readonly) NSArray<NSNumber *> *itemsType;

@property (nullable, nonatomic, readonly) UIBarButtonItem *backItem;
@property (nullable, nonatomic, readonly) UIBarButtonItem *forwardItem;
@property (nullable, nonatomic, readonly) UIBarButtonItem *refreshItem;

- (instancetype)initWithItemsType:(nullable NSArray<NSNumber *> *)itemsType;
- (instancetype)initWithFrame:(CGRect)frame itemsType:(nullable NSArray<NSNumber *> *)itemsType NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END

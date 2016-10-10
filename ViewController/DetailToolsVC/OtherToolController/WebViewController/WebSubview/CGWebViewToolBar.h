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
/** 网页工具栏 */
@interface CGWebViewToolBar : UIToolbar

@property (nullable, nonatomic, copy) void (^actionCallback) (CGWebViewItemType actionType);

@property (nonatomic, readonly) NSArray<NSNumber *> *itemsType;

- (instancetype)initWithFrame:(CGRect)frame itemsType:(nullable NSArray<NSNumber *> *)itemsType NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
NS_ASSUME_NONNULL_END

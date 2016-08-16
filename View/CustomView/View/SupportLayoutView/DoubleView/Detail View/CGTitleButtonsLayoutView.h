//
//  CGTitleButtonsLayoutView.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGDoubleLayoutBaseView.h"

NS_ASSUME_NONNULL_BEGIN
/** 两个按钮视图 */
@interface CGTitleButtonsLayoutView : CGDoubleLayoutBaseView

@property (nonatomic, strong, readonly) UIButton *firstButton;

@property (nonatomic, strong, readonly) UIButton *secondButton;

- (instancetype)initwithButtonType:(UIButtonType)buttonType;
@end
NS_ASSUME_NONNULL_END
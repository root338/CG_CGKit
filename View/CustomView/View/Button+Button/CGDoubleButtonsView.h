//
//  CGButtonContentView.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGBaseButton.h"

/**
 *  两个button按钮
 *  @bug 没有考虑两个按钮宽度 + marginEdgeInsets + subviewsSpace 超出屏幕的情况
 */
@interface CGDoubleButtonsView : CGBaseView

@property (strong, nonatomic, readonly) CGBaseButton *leftButton;

@property (strong, nonatomic, readonly) CGBaseButton *rightButton;

@property (assign, nonatomic) UIEdgeInsets marginEdgeInsets;

/** 当为 0 时，左右button两端对齐 */
@property (assign, nonatomic) CGFloat subviewsSpace;
@end

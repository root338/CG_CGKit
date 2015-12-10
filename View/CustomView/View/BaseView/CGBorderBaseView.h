//
//  CGBorderBaseView.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseView.h"
//协议
#import "CGViewBorderStateProtocol.h"

@class CGBorderObject;
/** 设置视图在不同状态拥有不同边框 */
@interface CGBorderBaseView : CGBaseView

@property (nonatomic, assign) CGViewBorderState viewBorderState;

/** 设置 */
- (void)cg_setupBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state;
- (void)cg_setupBorderWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state;

@end

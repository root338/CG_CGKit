//
//  CGViewBorderStateProtocol.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGBorderStateHeader.h"

/** 不同状态下的UIView边框设置协议 */
@protocol CGViewBorderStateProtocol <NSObject>

@optional

@property (nonatomic, assign) CGViewBorderState viewBorderState;

/** 返回不同状态下的颜色 */
- (UIColor *)cg_setupBorderColorWithState:(CGViewBorderState)state;

/** 返回不同状态下的宽度 */
- (CGFloat)cg_setupBorderWidthWithState:(CGViewBorderState)state;

/** 更新指定状态下的边框宽度 */
- (void)cg_updateBorderWidth:(CGFloat)width state:(CGViewBorderState)state;
/** 更新指定状态下的边框颜色 */
- (void)cg_updateBorderColor:(UIColor *)color state:(CGViewBorderState)state;
/** 更新指定状态下的边框值失败是否创建一个新值 */
- (BOOL)cg_updateFaildIsCreateBorderObjectWithState:(CGViewBorderState)state;

/** 更新当前边框的属性 */
- (void)cg_updateBorder;
@end

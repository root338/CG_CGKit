//
//  CGViewInteractionStatusDelegate.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGViewStatusHeader.h"

/**
 *  视图状态设置协议
 *  @bug 先舍弃这个方法 @param 使用方式：需要改变状态的视图应有个CGViewInteractionStatus类型的属性，改属性应由cg_viewInteractionStatusWith:协议方法设置，当属性变化时自动代理自动回调cg_setupButton: withInteractionStatus:方法
 */
@protocol CGViewInteractionStatusDelegate <NSObject>

/**
 *  设置按钮不同状态下的内容
 *
 *  @param status 内容
 */
- (void)cg_setupButton:(UIButton *)button interactionStatus:(CGViewInteractionStatus)status;

- (void)cg_setupButton:(UIButton *)button didChangeInteractionStatus:(CGViewInteractionStatus)status;

/** 
 *  返回指定视图的状态 
 */
- (CGViewInteractionStatus)cg_viewInteractionStatusWith:(UIView *)view;
@end

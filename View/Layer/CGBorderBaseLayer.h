//
//  CGBorderButtonLayer.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CGViewBorderStateProtocol.h"

@class CGBorderBaseLayer;
@protocol CGBorderLayerDelegate <NSObject>

@optional
/** 已改变层边颜色 */
- (void)cg_layerDidChangeBorderColor:(CGBorderBaseLayer *)layer;
/** 已改变层边宽度 */
- (void)cg_layerDidChangeBorderWidth:(CGBorderBaseLayer *)layer;

@end

@interface CGBorderBaseLayer : CALayer

@property (nonatomic, assign) CGViewBorderState borderState;

@property (nonatomic, weak) id<CGBorderLayerDelegate> cg_delegate;
/** 是否关闭方式代理的回调，默认NO */
@property (nonatomic, assign) BOOL disableSendDelegateAction;

@end

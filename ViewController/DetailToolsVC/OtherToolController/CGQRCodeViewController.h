//
//  CGQRCodeViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseViewController.h"

/**
 *  扫二维码
 */
@interface CGQRCodeViewController : CGBaseViewController

@property (assign, nonatomic) CGRect QRCodeVideoFrame;

@property (copy, nonatomic) void (^QRCodeCallback) (NSString *resultUrl);

/** 设置扫描感应框 */
- (CGRect)setupRectOfInterest;

- (void)startCaptureSession;
- (void)stopCaptureSession;
@end

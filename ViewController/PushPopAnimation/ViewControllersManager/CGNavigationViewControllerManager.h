//
//  CGNavigationViewControllerManager.h
//  TestCG_CGKit
//
//  Created by DY on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIPanGestureRecognizer;
@interface CGNavigationViewControllerManager : NSObject

- (void)handlePopGestureRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

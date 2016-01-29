//
//  CGNavigationController.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGNavigationAppearanceProtocol;
NS_ASSUME_NONNULL_BEGIN
@interface CGNavigationController : UINavigationController

@property (nonatomic, weak) id<CGNavigationAppearanceProtocol> appearanceDelegate;



@end
NS_ASSUME_NONNULL_END
//
//  CGBaseButton.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"
#import "CGViewSetupBorderStateDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGBaseButton : UIButton<CGViewInitializationProtocol, CGViewSetupBorderStateDelegate>




@end

NS_ASSUME_NONNULL_END
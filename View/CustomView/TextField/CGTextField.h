//
//  CGTextField.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets textInputMarginEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets leftViewMarginEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets rightViewMarginEdgeInsets;

@property (nonatomic, assign) BOOL disableAllPerformActionMenu;
@end
NS_ASSUME_NONNULL_END

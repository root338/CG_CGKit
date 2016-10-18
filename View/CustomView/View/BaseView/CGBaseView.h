//
//  CGBaseView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"

#import "UIView+CGSetupFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGBaseView : UIView<CGViewInitializationProtocol>

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

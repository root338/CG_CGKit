//
//  UIView+CGAddConstraints.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CreateAutoLayoutTypeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGAddConstraints)

- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

@end
NS_ASSUME_NONNULL_END
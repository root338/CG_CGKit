//
//  NSArray+CGSearchConstraints.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

/** 传入的数组中的对象必须是NSLayoutConstraint类型 */
@interface NSArray (CGSearchConstraints)

- (nullable NSLayoutConstraint *)cg_searchConstraintWithOptions:(NSEnumerationOptions)options item1:(id)item1 attribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)item2 attribute:(NSLayoutAttribute)att2;

@end

NS_ASSUME_NONNULL_END
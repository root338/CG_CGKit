//
//  UIView+CGCopyView.h
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CGCopyView)

/** 
 *  复制视图 @warning 内部数据有可能无法复制，需要再赋值，最好别用，这样的问题不少，视图的子视图层次都对改变
 */
- (instancetype)copyView;

@end

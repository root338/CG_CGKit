//
//  CGNavigationBarViewDelegate.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGNavigationBarViewDelegate_h
#define CGNavigationBarViewDelegate_h

@protocol CGNavigationBarViewDelegate <NSObject>

@required
/** 设置自定义导航栏的显示区域 */
- (CGRect)cg_navigationBarFrame;

@optional
/** 设置contentView的显示区域 */
- (CGRect)cg_contentViewFrame;



@end

#endif /* CGNavigationBarViewDelegate_h */

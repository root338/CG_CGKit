//
//  NSObject+CGDelaySelector.h
//  TestProject
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 -. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CGDelaySelector)

/** 0s后执行 */
- (void)cg_performAfterZeroDelaySelector:(SEL)aSelector;

@end

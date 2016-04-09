//
//  UIView+CGCopyView.m
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import "UIView+CGCopyView.h"

@implementation UIView (CGCopyView)

- (instancetype)copyView
{
    UIView *view = nil;
    if (self) {
        view = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    }
    
    return view;
}

@end

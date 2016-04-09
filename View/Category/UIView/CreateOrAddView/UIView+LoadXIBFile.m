//
//  UIView+LoadXIBFile.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/28.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+LoadXIBFile.h"

@implementation UIView (LoadXIBFile)

+ (instancetype)loadXIBFile
{
    return [self loadXIBFileWithName:NSStringFromClass([self class])];
}

+ (instancetype)loadXIBFileWithName:(NSString *)xibFileName
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibFileName owner:nil options:nil];
    __block UIView *targetView = nil;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[self class]]) {
            targetView = obj;
        }
    }];
    return targetView;
}
@end

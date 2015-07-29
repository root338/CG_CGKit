//
//  UIView+LoadXIBFile.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/28.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadXIBFile)

+ (instancetype)loadXIBFile;

+ (instancetype)loadXIBFileWithName:(NSString *)xibFileName;

@end

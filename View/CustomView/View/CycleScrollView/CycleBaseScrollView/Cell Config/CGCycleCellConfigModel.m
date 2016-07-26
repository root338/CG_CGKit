//
//  CGCycleCellConfigModel.m
//  TestCG_CGKit
//
//  Created by DY on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCycleCellConfigModel.h"

@interface CGCycleCellConfigModel ()

@property (nonatomic, assign, readwrite) NSInteger index;

@end

@implementation CGCycleCellConfigModel

- (instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        _index  = index;
    }
    return self;
}

@end

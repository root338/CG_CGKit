//
//  CGSubviewsSizeAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGSubviewsSizeAppearance.h"

@implementation CGSubviewsSizeAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _lineSpacing        = 0;
        _interitemSpacing   = 0;
        _itemSize           = CGSizeZero;
        _alignmentType      = CGAlignmentTypeVertical;
        
    }
    return self;
}

@end

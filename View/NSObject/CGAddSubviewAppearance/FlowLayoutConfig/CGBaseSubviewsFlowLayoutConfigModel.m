//
//  CGBaseSubviewsFlowLayoutConfigModel.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseSubviewsFlowLayoutConfigModel.h"

@implementation CGBaseSubviewsFlowLayoutConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _itemSize           = CGSizeZero;
        _lineSpacing        = 0;
        _interitemSpacing   = 0;
        _contentMaxWidth    = 0;
        _alignmentType      = CGAlignmentTypeVertical;
    }
    return self;
}

@end

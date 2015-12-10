//
//  CGBorderButton.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBorderButton.h"
#import "CGBorderBaseLayer.h"

@interface CGBorderButton ()
{
    CGBorderBaseLayer *_buttonLayer;
}
@end

@implementation CGBorderButton

+ (Class)layerClass
{
    return [CGBorderBaseLayer class];
}

- (void)initialization
{
    if ([self.layer isKindOfClass:[CGBorderBaseLayer class]]) {
        _buttonLayer = (id)self.layer;
    }
    
    
}


@end

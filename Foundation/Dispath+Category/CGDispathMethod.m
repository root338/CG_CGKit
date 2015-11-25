//
//  DispathMethod.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/4.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGDispathMethod.h"

void cg_dispath_after_second(CGFloat second, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}
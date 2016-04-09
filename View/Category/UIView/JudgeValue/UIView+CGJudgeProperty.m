//
//  UIView+CGJudgeProperty.m
//  TestCG_CGKit
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGJudgeProperty.h"

#import "UIView+CGSetupFrame.h"

@implementation UIView (CGJudgeProperty)

#pragma mark - 显示区域判断
- (BOOL)cg_judgeViewSizeIsZero
{
    return CGSizeEqualToSize(self.size, CGSizeZero);
}


@end

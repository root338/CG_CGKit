//
//  UILabel+MLAdd.m
//  QuickAskCommunity
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "UILabel+MLAdd.h"

@implementation UILabel (MLAdd)

@dynamic ml_lineHeight;
@dynamic ml_wordHeight;
@dynamic ml_offsetValue;

#pragma mark - Properties
- (CGFloat)ml_lineHeight { return self.font.lineHeight; }
- (CGFloat)ml_wordHeight { return self.font.pointSize; }
- (CGFloat)ml_offsetValue { return self.ml_lineHeight - self.ml_wordHeight; }

@end

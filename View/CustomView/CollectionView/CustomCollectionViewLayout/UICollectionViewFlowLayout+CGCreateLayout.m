//
//  UICollectionViewFlowLayout+CGCreateLayout
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UICollectionViewFlowLayout+CGCreateLayout.h"

@implementation UICollectionViewLayout (CGCreateLayout)

+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count space:(CGFloat)space
{
    return [self cg_createWithWidth:width count:count space:space edgeInsets:UIEdgeInsetsZero];
}

+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count space:(CGFloat)space edgeInsets:(UIEdgeInsets)insets
{
    return [self cg_createWithWidth:width count:count InteritemSpace:space lineSpace:space edgeInsets:insets];
}

+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count InteritemSpace:(CGFloat)InteritemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)insets
{
    
    CGFloat length                          = ((width - (insets.left + insets.right)) - InteritemSpace * (count - 1)) / (float)count;
    UICollectionViewFlowLayout *flowLayout  = [[self alloc] init];
    flowLayout.minimumInteritemSpacing      = InteritemSpace;
    flowLayout.minimumLineSpacing           = lineSpace;
    flowLayout.itemSize                     = CGSizeMake(length, length);
    
    return flowLayout;
}
@end
